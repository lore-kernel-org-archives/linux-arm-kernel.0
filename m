Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D0DC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:43:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5479321479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mRISQv9c";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H+wup7CJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5479321479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z9u2IiO2vyNbka1nRKRFX/g2dN2A5iL9cAX0ZEa0uvw=; b=mRISQv9caMPYfo
	5I6Gj/sF6ZgCSfksqRI+W7bhki9gdcfOVfozjv/akzxkuwBnUGZy48QedKhkCBlqSu6DiML/v5HLL
	70Qa7Cu0S7pCO4b1GvsaSAG2DkxsIWaxos7Ls1hhBnvIpuWviXf5J2pxNndT+o3JBktT5IVJ7e3Cr
	qN6s6TQK8ew4FP2piEzdG/hj1AY/YZe+Z96f9od1UrP9jeSNPBiDTGdlQnjfDpHMgxZX2DuJ4NMqb
	Rr4OZD7cXiC3JScHWIqA7axPboKfuJcgb9dKnPqzp11N8yLFUGdsLWlLGvR+skwd9ml0RY+rJIPQN
	Sf5SvQbkQiKmuczStNbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUqCD-0007SA-1Q; Thu, 06 Dec 2018 09:43:49 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUqC9-0007R3-Ch
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 09:43:47 +0000
Received: by mail-wm1-x341.google.com with SMTP id s14so293395wmh.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 01:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZSk6hIsmK/zbcNqT53FU0KnRlMRG/z7GDbRCkUaGy7o=;
 b=H+wup7CJxMxA4AwAggu9UNYtiUSodyYLJ/cxd9IoqnKnmQCAhXgyG17+Z90oxXd98K
 SN1f761WuLchXP9E0t3/TPWWDVXmnwyptszNS/8zxfg1YT+jdgOB1UCS0SiipGkzGMWF
 11XIKiUsKUiGV1Pq4clyUO+WUf/qAYMPyK/vE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZSk6hIsmK/zbcNqT53FU0KnRlMRG/z7GDbRCkUaGy7o=;
 b=cOu7CSD/cY/WWCrYn0MwLTepbSNxyNqVJes46h8C17WYeBJ2Ao7WauIj2OrdC9ROsz
 S9accg6glaNP24nRo6AXaoeLfY5i/ZDSBAwnlzo69NCm6tNV6y1SXSpuKwOgZDIIgTsG
 FMj/BIGBtHCYlZr3sT//vF/ddo1hnkAj+NTzW/bOlxl3x4/N0nh4Pu3oooEfBKkwLmlf
 rRQyWO+fhlt4SdhYZX5zcciQi+HYtw7XEulOlgONnUQDQys67hNL6b2D/AT0fP7mBIYE
 nwA6z/hsfX9lGl28ttrjSkLPu1e/k8/B6nImj3jdPaxIuIj9cvSF62wvmhbw8zM3oPE2
 xK+w==
X-Gm-Message-State: AA+aEWZ7loD5AM69LQVGu1pn3RTeYmxYaATf+7P/Jn5QWY+bASK2kw6N
 Jkv2P2yq5d/1kdTbSbzC3b1wrg==
X-Google-Smtp-Source: AFSGD/XvJXN8IJLduPGF6ZvZUe+4QJB7XN2klvbdjb4VTK9MGVEcE/62pT5iQW9V4/OaZa1L2e7EmA==
X-Received: by 2002:a1c:9a4c:: with SMTP id c73mr19841697wme.35.1544089412593; 
 Thu, 06 Dec 2018 01:43:32 -0800 (PST)
Received: from [192.168.0.40] ([80.125.148.122])
 by smtp.googlemail.com with ESMTPSA id q12sm353131wmf.2.2018.12.06.01.43.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Dec 2018 01:43:31 -0800 (PST)
Subject: Re: [PATCH] thermal: stm32: read factory settings properly
To: David HERNANDEZ SANCHEZ <david.hernandezsanchez@st.com>,
 Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre TORGUE <alexandre.torgue@st.com>
References: <1544087575-22242-1-git-send-email-david.hernandezsanchez@st.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b6e93540-120d-9358-86df-d8b78f37b67a@linaro.org>
Date: Thu, 6 Dec 2018 10:43:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544087575-22242-1-git-send-email-david.hernandezsanchez@st.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_014345_432388_C8BDAD5A 
X-CRM114-Status: GOOD (  23.99  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CkhpIERhdmlkLAoKT24gMDYvMTIvMjAxOCAxMDoxMiwgRGF2aWQgSEVSTkFOREVaIFNBTkNIRVog
d3JvdGU6Cj4gQ2FsbCBzdG1fdGhlcm1hbF9yZWFkX2ZhY3Rvcnlfc2V0dGluZ3Mgb25jZQo+IGlu
dGVybmFsIHBlcmlwaGVyYWwgaXMgcHJvcGVybHkgY2xvY2tlZC4KPiAKPiBUbyBhdm9pZCB3cm9u
ZyBpbml0aWFsaXphdGlvbiBvZiBmbXQwCj4gKHN0bV90aGVybWFsX3NlbnNvciBzdHJ1Y3QpIG1l
bWJlciBhZGQKPiBicmFja2V0cyBwcm9wZXJseS4KPiAKPiBDaGFuZ2UtSWQ6IEkxNTBkMDBmZDUw
ZTM4MmRmMDRiZmFkMTJmMDY1M2IxZWQ2YTFkYjFiCgpQbGVhc2UgZG8gYSBjbGVhbnVwIG9mIHRo
ZSBsb2c6CiAgLSBsaW5lIHdyYXAgYXQgNzIgY2hhcmFjdGVycwogIC0gTm8gQ2hhbmdlLUlkCgpT
dGF0ZSB0aGUgcHJvYmxlbSBhbmQgdGhlbiB0ZWxsIHdoYXQgeW91IGRvIHRvIGZpeCBpdC4KCkZv
ciBleGFtcGxlLCBpdCBpcyB1bmNsZWFyIHdoYXQgaGFwcGVucyBpZiB0aGUgZmFjdG9yeSBzZXR0
aW5ncyBhcmUgcmVhZApiZWZvcmUgdGhlIGNsb2NrIGlzIHNldC4KClRoZSBicmFja2V0IGNoYW5n
ZSBpcyBub3QgZGlyZWN0bHkgcmVsYXRlZCB0byB0aGUgY2xvY2sgb3JkZXJpbmcgYW5kIGl0CnNo
b3VsZCBnbyBpbiBhbm90aGVyIHBhdGNoLgoKSW4gYWRkaXRpb24gZWFjaCBwYXRjaCBpcyBmaXhp
bmcgc29tZXRoaW5nLCBpbiB0aGlzIGNhc2UgaXQgaXMgdGhlCmluaXRpYWwgaW1wb3J0LCBzbyBl
YWNoIGZpeGVzIHNob3VsZCBjb250YWluIHRoZSB0YWc6CgpGaXhlczogMWQ2OTMxNTUgKHRoZXJt
YWw6IGFkZCBzdG0zMiB0aGVybWFsIGRyaXZlcikKCgo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIEhl
cm5hbmRleiBTYW5jaGV6IDxkYXZpZC5oZXJuYW5kZXpzYW5jaGV6QHN0LmNvbT4KPiAKPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy90aGVybWFsL3N0L3N0bV90aGVybWFsLmMgYi9kcml2ZXJzL3RoZXJt
YWwvc3Qvc3RtX3RoZXJtYWwuYwo+IGluZGV4IDQ3NjIzZGEuLmJiZDczYzUgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy90aGVybWFsL3N0L3N0bV90aGVybWFsLmMKPiArKysgYi9kcml2ZXJzL3RoZXJt
YWwvc3Qvc3RtX3RoZXJtYWwuYwo+IEBAIC0yNDEsOCArMjQxLDggQEAgc3RhdGljIGludCBzdG1f
dGhlcm1hbF9yZWFkX2ZhY3Rvcnlfc2V0dGluZ3Moc3RydWN0IHN0bV90aGVybWFsX3NlbnNvciAq
c2Vuc29yKQo+ICAJCXNlbnNvci0+dDAgPSBUUzFfVDBfVkFMMTsKPiAgCj4gIAkvKiBSZXRyaWV2
ZSBmbXQwIGFuZCBwdXQgaXQgb24gSHogKi8KPiAtCXNlbnNvci0+Zm10MCA9IEFESlVTVCAqIHJl
YWRsX3JlbGF4ZWQoc2Vuc29yLT5iYXNlICsgRFRTX1QwVkFMUjFfT0ZGU0VUKQo+IC0JCQkJCSAg
ICAgICYgVFMxX0ZNVDBfTUFTSzsKPiArCXNlbnNvci0+Zm10MCA9IEFESlVTVCAqIChyZWFkbF9y
ZWxheGVkKHNlbnNvci0+YmFzZSArCj4gKwkJCQkgRFRTX1QwVkFMUjFfT0ZGU0VUKSAmIFRTMV9G
TVQwX01BU0spOwo+ICAKPiAgCS8qIFJldHJpZXZlIHJhbXAgY29lZmZpY2llbnQgKi8KPiAgCXNl
bnNvci0+cmFtcF9jb2VmZiA9IHJlYWRsX3JlbGF4ZWQoc2Vuc29yLT5iYXNlICsgRFRTX1JBTVBW
QUxSX09GRlNFVCkgJgo+IEBAIC01MzIsNiArNTMyLDEwIEBAIHN0YXRpYyBpbnQgc3RtX3RoZXJt
YWxfcHJlcGFyZShzdHJ1Y3Qgc3RtX3RoZXJtYWxfc2Vuc29yICpzZW5zb3IpCj4gIAlpZiAocmV0
KQo+ICAJCXJldHVybiByZXQ7Cj4gIAo+ICsJcmV0ID0gc3RtX3RoZXJtYWxfcmVhZF9mYWN0b3J5
X3NldHRpbmdzKHNlbnNvcik7Cj4gKwlpZiAocmV0KQo+ICsJCWdvdG8gdGhlcm1hbF91bnByZXBh
cmU7Cj4gKwo+ICAJcmV0ID0gc3RtX3RoZXJtYWxfY2FsaWJyYXRpb24oc2Vuc29yKTsKPiAgCWlm
IChyZXQpCj4gIAkJZ290byB0aGVybWFsX3VucHJlcGFyZTsKPiBAQCAtNjM2LDEwICs2NDAsNiBA
QCBzdGF0aWMgaW50IHN0bV90aGVybWFsX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpCj4gIAkvKiBQb3B1bGF0ZSBzZW5zb3IgKi8KPiAgCXNlbnNvci0+YmFzZSA9IGJhc2U7Cj4g
IAo+IC0JcmV0ID0gc3RtX3RoZXJtYWxfcmVhZF9mYWN0b3J5X3NldHRpbmdzKHNlbnNvcik7Cj4g
LQlpZiAocmV0KQo+IC0JCXJldHVybiByZXQ7Cj4gLQo+ICAJc2Vuc29yLT5jbGsgPSBkZXZtX2Ns
a19nZXQoJnBkZXYtPmRldiwgInBjbGsiKTsKPiAgCWlmIChJU19FUlIoc2Vuc29yLT5jbGspKSB7
Cj4gIAkJZGV2X2VycigmcGRldi0+ZGV2LCAiJXM6IGZhaWxlZCB0byBmZXRjaCBQQ0xLIGNsb2Nr
XG4iLAo+IAoKCi0tIAogPGh0dHA6Ly93d3cubGluYXJvLm9yZy8+IExpbmFyby5vcmcg4pSCIE9w
ZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29DcwoKRm9sbG93IExpbmFybzogIDxodHRwOi8v
d3d3LmZhY2Vib29rLmNvbS9wYWdlcy9MaW5hcm8+IEZhY2Vib29rIHwKPGh0dHA6Ly90d2l0dGVy
LmNvbS8jIS9saW5hcm9vcmc+IFR3aXR0ZXIgfAo8aHR0cDovL3d3dy5saW5hcm8ub3JnL2xpbmFy
by1ibG9nLz4gQmxvZwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LWFybS1rZXJuZWwK

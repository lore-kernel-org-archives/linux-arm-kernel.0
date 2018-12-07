Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C70C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:09:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82C5F20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NiIpC6lY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MIwyKPTe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C5F20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TUD3CDa7+Dcb26KtCaFff0LI1ZI5k4JmDpNXeeupfus=; b=NiIpC6lY7+tIaC
	x5jSmVRm09qtWi6lWoKcvLmF3fVdzsUN1etIgHAs+CNTcYFRmClV8JaeMEdmr2i1HlFsn6jedcail
	EB3Je6WSSW0ZVzmwz6Dj9ZwS6xzA6wBDLJh6qvShtpuOc/b+5rlIutJzfSaugW8MiMIsJ50enVChd
	QMLXquqcHL/ePpnqje92ONUSGrYTpib1yqLQGVR/4pggyNLLl30Nyc5waGCREGjnuHoRrACHNdE4H
	Q2shX/bE7i1fXFPqIuh6AFLOEdUvDIpOHz3c0VEmL510QSbZFm4sI/qskTIBWk6osvynnRBM77gO9
	QcSPGSyju4V0+Rlq5glg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVAGP-0000os-JY; Fri, 07 Dec 2018 07:09:29 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVAGM-0000o5-0Y
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 07:09:27 +0000
Received: by mail-wr1-x444.google.com with SMTP id p4so2763910wrt.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 23:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=p/ijNVegE4ehNi8UoZbjg25Mma34Nj/8H2lL0QDCA7Y=;
 b=MIwyKPTe8BGgP5A4fEMcZ5cV7tH8byg4g2QBt18tTZmmz9thhSftgkcsmG85ual2kD
 OPL8KV43SLHXsRbpJHZfFG6SySe8k+rCq7PrbwX8cClkoodvzTGUQ5c8RoGWk/zUBX2+
 9wuIIm7VRJKHeA8eFhgeGbps5mrCLBlDQ9Quw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=p/ijNVegE4ehNi8UoZbjg25Mma34Nj/8H2lL0QDCA7Y=;
 b=Gvpy46+nGo/dQdwr9PuPjb08a/LDZMb+y3t7hnq+M7bS44YrAJjPqoMLP+xZbVbykE
 vqAN5Z8i/t5MMJYoEreH7R7KtaKObpW57NIrPBjyJmeIjWG/uNNEWEIi/sA3xaXdE4I8
 MfwiHfs+fWw/piElCdRl5tdVwcoMnDFwafMJgSjQUSi3yl6WqDaSoeW/x2dvbnpDuTSV
 dycvB1oChXqg5qdQWoM8WPBzGSNu+MYnFubTlyF2ksWQxjIVVx2KMf3lery2vj/abZs0
 fA68eRnZruknBgKt8qIlXijnmxqPNLKfS+FndiYs+if0QHZ9ieef3vCIiXqXD4sRsZmm
 SdNQ==
X-Gm-Message-State: AA+aEWZnlZJPO1kzrPS9MgsIQSUGi5Wc2ND2qxOgaNN2SMTVq0p2lI2e
 o+Dv/6NZ4Z0JoNq2vQX/xrnbrA==
X-Google-Smtp-Source: AFSGD/VjSPhQM2jS1fKl6/lvV+e9jStHXlnTFkVm+EBCTjjKtSF1GBdNAyY5P6p/zLmkeDW19MZQJA==
X-Received: by 2002:adf:dd06:: with SMTP id a6mr879206wrm.2.1544166552994;
 Thu, 06 Dec 2018 23:09:12 -0800 (PST)
Received: from [192.168.0.40] (80.149.136.77.rev.sfr.net. [77.136.149.80])
 by smtp.googlemail.com with ESMTPSA id x8sm7519758wmd.45.2018.12.06.23.09.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Dec 2018 23:09:12 -0800 (PST)
Subject: Re: [PATCH] thermal: uniphier: Convert to SPDX identifier
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>
References: <1544144764-17964-1-git-send-email-hayashi.kunihiko@socionext.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e8a64b24-b107-98ed-0e67-a61531e0ca0e@linaro.org>
Date: Fri, 7 Dec 2018 08:09:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544144764-17964-1-git-send-email-hayashi.kunihiko@socionext.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_230926_059001_046673E7 
X-CRM114-Status: GOOD (  18.15  )
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMDcvMTIvMjAxOCAwMjowNiwgS3VuaWhpa28gSGF5YXNoaSB3cm90ZToKPiBUaGlzIGNvbnZl
cnRzIGxpY2Vuc2UgYm9pbGVycGxhdGUgdG8gU1BEWCBpZGVudGlmaWVyLCBhbmQgcmVtb3Zlcwo+
IHVubmVjZXNzYXJ5IGxpbmVzLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEt1bmloaWtvIEhheWFzaGkg
PGhheWFzaGkua3VuaWhpa29Ac29jaW9uZXh0LmNvbT4KPiAtLS0KClJldmlld2VkLWJ5OiBEYW5p
ZWwgTGV6Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz4KCj4gIGRyaXZlcnMvdGhlcm1h
bC91bmlwaGllcl90aGVybWFsLmMgfCAxMyArLS0tLS0tLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMTIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdGhlcm1hbC91bmlwaGllcl90aGVybWFsLmMgYi9kcml2ZXJzL3RoZXJtYWwvdW5pcGhpZXJf
dGhlcm1hbC5jCj4gaW5kZXggNTU0NzdkNy4uYmJhMjI4NCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L3RoZXJtYWwvdW5pcGhpZXJfdGhlcm1hbC5jCj4gKysrIGIvZHJpdmVycy90aGVybWFsL3VuaXBo
aWVyX3RoZXJtYWwuYwo+IEBAIC0xLDIxICsxLDEwIEBACj4gKy8vIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wCj4gIC8qKgo+ICAgKiB1bmlwaGllcl90aGVybWFsLmMgLSBTb2Npb25l
eHQgVW5pUGhpZXIgdGhlcm1hbCBkcml2ZXIKPiAtICoKPiAgICogQ29weXJpZ2h0IDIwMTQgICAg
ICBQYW5hc29uaWMgQ29ycG9yYXRpb24KPiAgICogQ29weXJpZ2h0IDIwMTYtMjAxNyBTb2Npb25l
eHQgSW5jLgo+IC0gKiBBbGwgcmlnaHRzIHJlc2VydmVkLgo+IC0gKgo+ICAgKiBBdXRob3I6Cj4g
ICAqCUt1bmloaWtvIEhheWFzaGkgPGhheWFzaGkua3VuaWhpa29Ac29jaW9uZXh0LmNvbT4KPiAt
ICoKPiAtICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU6IHlvdSBjYW4gcmVkaXN0cmli
dXRlIGl0IGFuZC9vciBtb2RpZnkKPiAtICogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUg
R2VuZXJhbCBQdWJsaWMgTGljZW5zZSB2ZXJzaW9uIDIgIG9mCj4gLSAqIHRoZSBMaWNlbnNlIGFz
IHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLgo+IC0gKgo+IC0gKiBU
aGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVz
ZWZ1bCwKPiAtICogYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGlt
cGxpZWQgd2FycmFudHkgb2YKPiAtICogTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEg
UEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZQo+IC0gKiBHTlUgR2VuZXJhbCBQdWJsaWMgTGlj
ZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgo+ICAgKi8KPiAgCj4gICNpbmNsdWRlIDxsaW51eC9iaXRv
cHMuaD4KPiAKCgotLSAKIDxodHRwOi8vd3d3LmxpbmFyby5vcmcvPiBMaW5hcm8ub3JnIOKUgiBP
cGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKCkZvbGxvdyBMaW5hcm86ICA8aHR0cDov
L3d3dy5mYWNlYm9vay5jb20vcGFnZXMvTGluYXJvPiBGYWNlYm9vayB8CjxodHRwOi8vdHdpdHRl
ci5jb20vIyEvbGluYXJvb3JnPiBUd2l0dGVyIHwKPGh0dHA6Ly93d3cubGluYXJvLm9yZy9saW5h
cm8tYmxvZy8+IEJsb2cKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsCg==

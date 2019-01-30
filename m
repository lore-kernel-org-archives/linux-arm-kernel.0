Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7AAC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:24:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 006A720882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qArmxWLU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I1dIpshB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006A720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fWhwfH+Yq17Qe5vaHjEAwNpFgfe6KBOJ2NBw6nqdeuY=; b=qArmxWLU9OHauk
	ZS2FoTGDdgCN9AYLsbhwI3FUL9S/5rFykonqGptij/0cs9iazYVf3Txfq6SSowVjzWCP2xtmffl6T
	ad7dsdyLlrr5q/ApLhPiKpTxSAf4XmTZmXxSxotlYL1VpvqWoCn834c2j0M51mel27M9iXfEvQf4T
	EmZZDa/ZEVrZa8VuheyJ/rxiF4QnoqylAR6UPIviWcofnZNVo7kqvNJ1lDcXllHzgbGTCeSp0L6JI
	WrmGsRf3EhpwJWPFczMGaPIuhKpcv3Nlp+WL2VkmbK8jhS5K8CSUmZa3zhEP5zx4YhJyu9tJrwm1D
	lkOqMx48eLBRVbkYvXbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gom71-0001yE-GT; Wed, 30 Jan 2019 09:24:51 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gom6y-0001xp-3O
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 09:24:49 +0000
Received: by mail-lf1-x143.google.com with SMTP id u18so16820250lff.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 01:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=a6wuYAzUKJFK17sFW5IvyQfSur/oHfCkaT4dffnoCek=;
 b=I1dIpshBNVhV/iBrdyWW2LhtIYVP4sAETBUIw4/H4EIhbWMFJaLrgH+Snjlji1ZgJm
 TmASN1P05uw1OTrp/ien+32Wh2NunCFmfN6Gk8W6mVf+0mFDj526Oug5IHm81m18DIAk
 ygvSzEG3G9X8P0kzRqBubDRD2biqlklohValo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=a6wuYAzUKJFK17sFW5IvyQfSur/oHfCkaT4dffnoCek=;
 b=UvPAxHefLiONhegMvb9vt/iqoc78LXuliJWTd/pmjxCq33nssWbnCNMiPMsmaEaaMn
 bB8dZEpPqoTluWEfEU1abVNQH5uClmIrHJ5Mu0+9UpPkjhK/wQIV1HAbf2FYoawoZDXy
 YiImfD87D81GnEjjaCTG6nlom+0LSc0qhWMbZksS9OBAze4hRHSVddmhkYsRi1cmmKYp
 ih0epQKXyulX54L5QxADy1KBZGwKEzNmQeG557R0QqSMPzOSiseNj2NuIlwzk6FyDhBc
 crz32moGCKpJaUdYAvmUhaodRIIP1lDgl0tXfRzxR8WBAsXhbg8mKAepL7KEuHiCPUIi
 B9Cw==
X-Gm-Message-State: AJcUukfr8MadN35XrT7x0ntXv0ZW3DbXLbjCo/UV6s6zSZ/H5Q+EU2zE
 iPvc88yaboZ0Po98908nSEZ0cQ==
X-Google-Smtp-Source: ALg8bN7vglkBkAPnDzc77h69eDlPk288seMZyirG8ade+BplyFtwnNBG3rvOJV+1qcCFSAk/cU8saA==
X-Received: by 2002:ac2:4194:: with SMTP id z20mr22400987lfh.74.1548840285704; 
 Wed, 30 Jan 2019 01:24:45 -0800 (PST)
Received: from localhost.localdomain
 (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
 by smtp.gmail.com with ESMTPSA id q20sm189864lfj.20.2019.01.30.01.24.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 01:24:44 -0800 (PST)
Date: Wed, 30 Jan 2019 09:43:21 +0100
From: Anders Roxell <anders.roxell@linaro.org>
To: Lucas Stach <l.stach@pengutronix.de>,
 Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] arm64: Kconfig.platforms: fix warning unmet direct
 dependencies
Message-ID: <20190130084321.GB3369@localhost.localdomain>
References: <20190115191839.13823-1-anders.roxell@linaro.org>
 <20190125143215.GE25901@arrakis.emea.arm.com>
 <1548431829.28802.50.camel@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548431829.28802.50.camel@pengutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_012448_140144_D52CC08B 
X-CRM114-Status: GOOD (  26.79  )
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
Cc: will.deacon@arm.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMjAxOS0wMS0yNSAxNjo1NywgTHVjYXMgU3RhY2ggd3JvdGU6Cj4gQW0gRnJlaXRhZywgZGVu
IDI1LjAxLjIwMTksIDE0OjMyICswMDAwIHNjaHJpZWIgQ2F0YWxpbiBNYXJpbmFzOgo+ID4gT24g
VHVlLCBKYW4gMTUsIDIwMTkgYXQgMDg6MTg6MzlQTSArMDEwMCwgQW5kZXJzIFJveGVsbCB3cm90
ZToKPiA+ID4gV2hlbiBBUkNIX01YQyBnZXQgZW5hYmxlZCwgQVJNNjRfRVJSQVRVTV84NDU3MTkg
d2lsbCBiZSBzZWxlY3RlZCBhbmQKPiA+ID4gdGhpcyB3YXJuaW5nIHdpbGwgaGFwcGVuIHdoZW4g
Q09NUEFUIGlzbid0IHNldC4KPiA+ID4gCj4gPiA+IFdBUk5JTkc6IHVubWV0IGRpcmVjdCBkZXBl
bmRlbmNpZXMgZGV0ZWN0ZWQgZm9yIEFSTTY0X0VSUkFUVU1fODQ1NzE5Cj4gPiA+IMKgIERlcGVu
ZHMgb24gW25dOiBDT01QQVQgWz1uXQo+ID4gPiDCoCBTZWxlY3RlZCBieSBbeV06Cj4gPiA+IMKg
IC0gQVJDSF9NWEMgWz15XQo+ID4gPiAKPiA+ID4gUmV3b3JrIHRvIGFkZCAnaWYgQ09NUEFUJyBi
ZWZvcmUgQVJNNjRfRVJSQVRVTV84NDU3MTkgZ2V0cyBzZWxlY3RlZCwKPiA+ID4gc2luY2UgQVJN
NjRfRVJSQVRVTV84NDU3MTkgZGVwZW5kcyBvbiBDT01QQVQuCj4gPiA+IAo+ID4gPiA+ID4gU2ln
bmVkLW9mZi1ieTogQW5kZXJzIFJveGVsbCA8YW5kZXJzLnJveGVsbEBsaW5hcm8ub3JnPgo+ID4g
PiAtLS0KPiA+ID4gwqBhcmNoL2FybTY0L0tjb25maWcucGxhdGZvcm1zIHwgMiArLQo+ID4gPiDC
oDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+ID4gPiAKPiA+
ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvS2NvbmZpZy5wbGF0Zm9ybXMgYi9hcmNoL2FybTY0
L0tjb25maWcucGxhdGZvcm1zCj4gPiA+IGluZGV4IDI1MWVjZjM0Y2IwMi4uZDRmYWNhNzc1ZDlj
IDEwMDY0NAo+ID4gPiAtLS0gYS9hcmNoL2FybTY0L0tjb25maWcucGxhdGZvcm1zCj4gPiA+ICsr
KyBiL2FyY2gvYXJtNjQvS2NvbmZpZy5wbGF0Zm9ybXMKPiA+ID4gQEAgLTE0NSw3ICsxNDUsNyBA
QCBjb25maWcgQVJDSF9NVkVCVQo+ID4gPiDCoGNvbmZpZyBBUkNIX01YQwo+ID4gPiA+ID4gwqAJ
Ym9vbCAiQVJNdjggYmFzZWQgTlhQIGkuTVggU29DIGZhbWlseSIKPiA+ID4gPiA+IMKgCXNlbGVj
dCBBUk02NF9FUlJBVFVNXzg0MzQxOQo+ID4gPiA+ID4gLQlzZWxlY3QgQVJNNjRfRVJSQVRVTV84
NDU3MTkKPiA+ID4gPiA+ICsJc2VsZWN0IEFSTTY0X0VSUkFUVU1fODQ1NzE5IGlmIENPTVBBVAo+
ID4gPiA+ID4gwqAJaGVscAo+ID4gPiA+ID4gwqAJwqDCoFRoaXMgZW5hYmxlcyBzdXBwb3J0IGZv
ciB0aGUgQVJNdjggYmFzZWQgU29DcyBpbiB0aGUKPiA+ID4gwqAJwqDCoE5YUCBpLk1YIGZhbWls
eS4KPiA+IAo+ID4gQWN0dWFsbHksIGRvIHdlIG5lZWQgdG8gc2VsZWN0IHRoZSBlcnJhdGEgd29y
a2Fyb3VuZHMgZXhwbGljaXRseT8gVGhhdAo+ID4gc2VlbXMgdG8gYmUgdGhlIG9ubHkgY2FzZSB3
aGVyZSB3ZSBkbyBpdCAoY29tbWl0IDkzMDUwN2MxODMwNCwgImFybTY0Ogo+ID4gYWRkIGJhc2lj
IEtjb25maWcgc3ltYm9scyBmb3IgaS5NWDgiKS4gVGhleSBhcmUgZGVmYXVsdCB5LCBzbyB3ZQo+
ID4gc2hvdWxkbid0IG5lZWQgdG8gZm9yY2UgdGhlbSBvbi4KPiAKPiBUaGlzIGlzIGJhc2VkIG9u
IHBhc3QgZXhwZXJpZW5jZS4gV2UndmUgaGFkIGEgbG90IG9mIGNhc2VzIHdlcmUgcGVvcGxlCj4g
ZGlkIG5vdCBlbmFibGUgdGhlIG5lY2Vzc2FyeSBDUFUgZXJyYXRhIHdvcmthcm91bmQsIHdoaWNo
IHRoZW4gdXN1YWxseQo+IGxlYWQgdG8gdmVyeSBoYXJkIHRvIGRlYnVnIHN5c3RlbSBmYWlsdXJl
cy4gSXQgaXMgb24gb3VyIGxpc3Qgb2YgdGhpbmdzCj4gdG8gbG9vayBvdXQgZm9yIG5vdywgYnV0
IEkgd291bGQgZmVlbCBtdWNoIGJldHRlciBpZiB0aGVyZSBpcyBqdXN0IG5vCj4gY2hhbmNlIGZv
ciBhIHVzZXIgdG8gbWlzY29uZmlndXJlIHRoZSBrZXJuZWwgaW4gdGhpcyB3YXkuCj4gCgpXb3Vs
ZCBhIGJldHRlciBhcHByb2FjaCBiZSB0byByZW1vdmUgdGhlICdkZXBlbmRzIG9uIENPTVBBVCcg
aW4gdGhlCktjb25maWcgYW5kIG1vdmUgaXQgaW50byB0aGUgc3JjIGZpbGVzIGluc3RlYWQgc2Vl
IGJlbG93LgoKQ2hlZXJzLApBbmRlcnMKCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9LY29uZmln
IGIvYXJjaC9hcm02NC9LY29uZmlnCmluZGV4IGQ5YWI4ZmYzZjdlNS4uMDRiMTE4MDZlMmQ3IDEw
MDY0NAotLS0gYS9hcmNoL2FybTY0L0tjb25maWcKKysrIGIvYXJjaC9hcm02NC9LY29uZmlnCkBA
IC00MzAsNyArNDMwLDYgQEAgY29uZmlnIEFSTTY0X0VSUkFUVU1fODM0MjIwCiAKIGNvbmZpZyBB
Uk02NF9FUlJBVFVNXzg0NTcxOQogCWJvb2wgIkNvcnRleC1BNTM6IDg0NTcxOTogYSBsb2FkIG1p
Z2h0IHJlYWQgaW5jb3JyZWN0IGRhdGEiCi0JZGVwZW5kcyBvbiBDT01QQVQKIAlkZWZhdWx0IHkK
IAloZWxwCiAJICBUaGlzIG9wdGlvbiBhZGRzIGFuIGFsdGVybmF0aXZlIGNvZGUgc2VxdWVuY2Ug
dG8gd29yayBhcm91bmQgQVJNCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2tlcm5lbC9jcHVfZXJy
YXRhLmMgYi9hcmNoL2FybTY0L2tlcm5lbC9jcHVfZXJyYXRhLmMKaW5kZXggOTk1MGJiMGNiZDUy
Li40M2IxNGE1ZmM4YzEgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtNjQva2VybmVsL2NwdV9lcnJhdGEu
YworKysgYi9hcmNoL2FybTY0L2tlcm5lbC9jcHVfZXJyYXRhLmMKQEAgLTY0MSw3ICs2NDEsNyBA
QCBjb25zdCBzdHJ1Y3QgYXJtNjRfY3B1X2NhcGFiaWxpdGllcyBhcm02NF9lcnJhdGFbXSA9IHsK
IAkJTUlEUl9GSVhFRCgweDQsIEJJVCg4KSksCiAJfSwKICNlbmRpZgotI2lmZGVmIENPTkZJR19B
Uk02NF9FUlJBVFVNXzg0NTcxOQorI2lmIGRlZmluZWQoQ09ORklHX0FSTTY0X0VSUkFUVU1fODQ1
NzE5KSAmJiBkZWZpbmVkKENPTkZJR19DT01QQVQpCiAJewogCS8qIENvcnRleC1BNTMgcjBwWzAx
MjM0XSAqLwogCQkuZGVzYyA9ICJBUk0gZXJyYXR1bSA4NDU3MTkiLApkaWZmIC0tZ2l0IGEvYXJj
aC9hcm02NC9rZXJuZWwvZW50cnkuUyBiL2FyY2gvYXJtNjQva2VybmVsL2VudHJ5LlMKaW5kZXgg
MGVjMGM0NmIyYzBjLi5lMmJlMzdlZTU2MTUgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtNjQva2VybmVs
L2VudHJ5LlMKKysrIGIvYXJjaC9hcm02NC9rZXJuZWwvZW50cnkuUwpAQCAtMzExLDcgKzMxMSw3
IEBAIGFsdGVybmF0aXZlX2Vsc2Vfbm9wX2VuZGlmCiAJdHN0CXgyMiwgI1BTUl9NT0RFMzJfQklU
CQkvLyBuYXRpdmUgdGFzaz8KIAliLmVxCTNmCiAKLSNpZmRlZiBDT05GSUdfQVJNNjRfRVJSQVRV
TV84NDU3MTkKKyNpZiBkZWZpbmVkKENPTkZJR19BUk02NF9FUlJBVFVNXzg0NTcxOSkgJiYgZGVm
aW5lZChDT05GSUdfQ09NUEFUKQogYWx0ZXJuYXRpdmVfaWYgQVJNNjRfV09SS0FST1VORF84NDU3
MTkKICNpZmRlZiBDT05GSUdfUElEX0lOX0NPTlRFWFRJRFIKIAltcnMJeDI5LCBjb250ZXh0aWRy
X2VsMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
YXJtLWtlcm5lbAo=

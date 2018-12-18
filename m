Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDEAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:49:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B46221841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CW/mh9/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B46221841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yJWnm6cxRewmPVKScU1DveCuHFob1i39CS4/rhKLMng=; b=CW/mh9/cnTVIgK
	/vfogaUd2aYhwCSh/FglstRacpUPOOOP5t6w7ApZiz9jpsRJZWk9q25YiyLqvxQjc8yz3RUj6Xd48
	XIwpTqAFlSR5r1hddMaQrB4FgNzo/XyiQ4K9EnH124Bom6Q/yjaCSFytiphlz6NCxSHLZKC+a/2vv
	Juh43Cpr/KTLE20jOEH26MS7qvSNRt/Zk02jP5hJClQT52SsAuGO91u47FIeyF6GcCpPcbwXgi+gr
	Kg0Gyy7hbuPf9Uc7dxr2yrCtCeLMF8X0hLtSofUv2byPUJqu4f5tQTFLnODghkPLXqmgU2pDGfbTk
	jHfurpIT8XoDJ84WzEvw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZLN5-0004rb-FR; Tue, 18 Dec 2018 19:49:39 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZLN2-0004qE-5N; Tue, 18 Dec 2018 19:49:38 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 679FFAFB5;
 Tue, 18 Dec 2018 19:49:20 +0000 (UTC)
Subject: Re: [PATCH 1/5] ARM: actions: Put OF nodes after use
To: Linus Walleij <linus.walleij@linaro.org>
References: <20181211080759.3150-1-linus.walleij@linaro.org>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=afaerber@suse.de; prefer-encrypt=mutual; keydata=
 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
Organization: SUSE Linux GmbH
Message-ID: <b37882e5-0be8-2af0-30f8-493a1cd6c08b@suse.de>
Date: Tue, 18 Dec 2018 20:49:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181211080759.3150-1-linus.walleij@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_114936_504258_4AA76871 
X-CRM114-Status: GOOD (  17.35  )
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
Cc: linux-actions@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

KyBsaW51eC1hY3Rpb25zCgpBbSAxMS4xMi4xOCB1bSAwOTowNyBzY2hyaWViIExpbnVzIFdhbGxl
aWo6Cj4gQWZ0ZXIgdXNpbmcgb2ZfZmluZF9jb21wYXRpYmxlX25vZGUoKSB3ZSBuZWVkIHRvIGlz
c3VlCj4gb2Zfbm9kZV9wdXQoKSBvbiB0aGUgbm9kZSB0byBrZWVwIHJlZmNvdW50Lgo+IAo+IFNp
Z25lZC1vZmYtYnk6IExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZz4KPiAt
LS0KPiAgYXJjaC9hcm0vbWFjaC1hY3Rpb25zL3BsYXRzbXAuYyB8IDQgKysrKwo+ICAxIGZpbGUg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gt
YWN0aW9ucy9wbGF0c21wLmMgYi9hcmNoL2FybS9tYWNoLWFjdGlvbnMvcGxhdHNtcC5jCj4gaW5k
ZXggM2VmYWExMGVmYzQzLi4wMmQxN2VkMGNhMzEgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9hcm0vbWFj
aC1hY3Rpb25zL3BsYXRzbXAuYwo+ICsrKyBiL2FyY2gvYXJtL21hY2gtYWN0aW9ucy9wbGF0c21w
LmMKPiBAQCAtMTIyLDYgKzEyMiw3IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBzNTAwX3NtcF9wcmVw
YXJlX2NwdXModW5zaWduZWQgaW50IG1heF9jcHVzKQo+ICAJfQo+ICAKPiAgCXRpbWVyX2Jhc2Vf
YWRkciA9IG9mX2lvbWFwKG5vZGUsIDApOwo+ICsJb2Zfbm9kZV9wdXQobm9kZSk7Cj4gIAlpZiAo
IXRpbWVyX2Jhc2VfYWRkcikgewo+ICAJCXByX2VycigiJXM6IGNvdWxkIG5vdCBtYXAgdGltZXIg
cmVnaXN0ZXJzXG4iLCBfX2Z1bmNfXyk7Cj4gIAkJcmV0dXJuOwo+IEBAIC0xMzQsNiArMTM1LDgg
QEAgc3RhdGljIHZvaWQgX19pbml0IHM1MDBfc21wX3ByZXBhcmVfY3B1cyh1bnNpZ25lZCBpbnQg
bWF4X2NwdXMpCj4gIAl9Cj4gIAo+ICAJc3BzX2Jhc2VfYWRkciA9IG9mX2lvbWFwKG5vZGUsIDAp
Owo+ICsJb2Zfbm9kZV9wdXQobm9kZSk7Cj4gKwo+ICAJaWYgKCFzcHNfYmFzZV9hZGRyKSB7Cj4g
IAkJcHJfZXJyKCIlczogY291bGQgbm90IG1hcCBzcHMgcmVnaXN0ZXJzXG4iLCBfX2Z1bmNfXyk7
Cj4gIAkJcmV0dXJuOwo+IEBAIC0xNDcsNiArMTUwLDcgQEAgc3RhdGljIHZvaWQgX19pbml0IHM1
MDBfc21wX3ByZXBhcmVfY3B1cyh1bnNpZ25lZCBpbnQgbWF4X2NwdXMpCj4gIAkJfQo+ICAKPiAg
CQlzY3VfYmFzZV9hZGRyID0gb2ZfaW9tYXAobm9kZSwgMCk7Cj4gKwkJb2Zfbm9kZV9wdXQobm9k
ZSk7Cj4gIAkJaWYgKCFzY3VfYmFzZV9hZGRyKSB7Cj4gIAkJCXByX2VycigiJXM6IGNvdWxkIG5v
dCBtYXAgc2N1IHJlZ2lzdGVyc1xuIiwgX19mdW5jX18pOwo+ICAJCQlyZXR1cm47CgpMb29rcyBv
a2F5LCBidXQgZG9lcyBpdCBtYXR0ZXI/IFRvIG15IHVuZGVyc3RhbmRpbmcgdGhpcyBpcyBhbGwK
bm9uLXJlZW50cmFudCBjb2RlLgoKSWYgeW91IGRvIGNvbnNpZGVyIGl0IGEgYnVnZml4LCB0aGVu
IHdlIHNob3VsZCBhZGQgYSBGaXhlcyBoZWFkZXI6Cmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvYXJjaC9hcm0v
bWFjaC1hY3Rpb25zP2lkPTE3MjA2N2UwYmM4NzIxYWYzZTg2MjY1OTZmOTFiMDNmNjkxZTg4YTgK
ClJlZ2FyZHMsCkFuZHJlYXMKCi0tIApTVVNFIExpbnV4IEdtYkgsIE1heGZlbGRzdHIuIDUsIDkw
NDA5IE7DvHJuYmVyZywgR2VybWFueQpHRjogRmVsaXggSW1lbmTDtnJmZmVyLCBKYW5lIFNtaXRo
YXJkLCBHcmFoYW0gTm9ydG9uCkhSQiAyMTI4NCAoQUcgTsO8cm5iZXJnKQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWls
aW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=

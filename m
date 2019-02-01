Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31CEC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:15:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90DBC20844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RFVj/L8o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90DBC20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7M9hAaAb0WFbvpWZ80i6QYgpKcnVSaPKn9msnmDuAUE=; b=RFVj/L8o1FG3J2
	a2U4nc1hRD3YnmOi/M8e4OUjmOMol9OOxcHbXm8v2cJvyuCMgBPncw1M5fMmzYlU15tVeC8XTnVy2
	Kr5S0R0aRxkVXp7oZMg+9qjmefbRcPU2LHYT2Km3D4XFUOmAfpu88ZBSNw04sWqc/9mjHiKPp1Bwk
	qOC7x2IRjl3w9JdDI/4aF6G4DbB+WHHtCjw/xi4PHXOOljZG3ufvTtzuXPRBbNlTtTB55tUuOxuIA
	IDx/qOhcjXWqTEYcS1FyDTefomvEvzPdlXmHEoCuvFnPxYYyNqC4q8uJa8Baj+jdCLE7GXWW7pCr8
	tMKENHDXD0TGNgjod/Ag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpUvD-0005sm-Iq; Fri, 01 Feb 2019 09:15:39 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpUv5-0005sD-K3
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 09:15:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24BF5A78;
 Fri,  1 Feb 2019 01:15:28 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 516463F71E; Fri,  1 Feb 2019 01:15:26 -0800 (PST)
Subject: Re: [PATCH 00/10] GICv3 support for kexec/kdump on EFI systems
To: Sun Ted <xulinsun@gmail.com>
References: <20180921195954.21574-1-marc.zyngier@arm.com>
 <CACiNFG5r2Czfy_kXA2PPQa=xdyzq0vUgoQZ=XNME4d_h=O1oBw@mail.gmail.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <b4594318-9ebf-91ce-b845-3fac92ba6476@arm.com>
Date: Fri, 1 Feb 2019 09:15:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CACiNFG5r2Czfy_kXA2PPQa=xdyzq0vUgoQZ=XNME4d_h=O1oBw@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_011532_013698_743FCC8E 
X-CRM114-Status: GOOD (  28.17  )
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
Cc: Jason Cooper <jason@lakedaemon.net>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Jeffrey Hugo <jhugo@codeaurora.org>, linux-kernel@vger.kernel.org,
 Jeremy Linton <jeremy.linton@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgWHVsaW4sCgpPbiAwMS8wMi8yMDE5IDA2OjExLCBTdW4gVGVkIHdyb3RlOgo+IEhpIE1hcmMs
Cj4gCj4gTWFyYyBaeW5naWVyIDxtYXJjLnp5bmdpZXJAYXJtLmNvbSA8bWFpbHRvOm1hcmMuenlu
Z2llckBhcm0uY29tPj4g5LqOMjAxOAo+IOW5tDnmnIgyMuaXpeWRqOWFrSDkuIrljYg0OjAz5YaZ
6YGT77yaCj4gCj4gICAgIFRoZSBHSUN2MyBhcmNoaXRlY3R1cmUgaGFzIHRoZSByZW1hcmthYmxl
IGZlYXR1cmUgdGhhdCBvbmNlIExQSSB0YWJsZXMKPiAgICAgaGF2ZSBiZWVuIGFzc2lnbmVkIHRv
IHJlZGlzdHJpYnV0b3JzIGFuZCB0aGF0IExQSSBkZWxpdmVyeSBpcyBlbmFibGVkLAo+ICAgICB0
aGVyZSBpcyBubyBndWFyYW50ZWUgdGhhdCBMUElzIGNhbiBiZSB0dXJuZWQgb2ZmIChhbmQgbW9z
dAo+ICAgICBpbXBsZW1lbnRhdGlvbnMgZG8gbm90IGFsbG93IGl0KSwgbm9yIGNhbiBpdCBiZSBy
ZXByb2dyYW1tZWQgdG8gdXNlCj4gICAgIG90aGVyIHRhYmxlcy4KPiAKPiAgICAgVGhpcyBpcyBh
IGJpdCBvZiBhIHByb2JsZW0gZm9yIGtleGVjLCB3aGVyZSB0aGUgc2Vjb25kYXJ5IGtlcm5lbAo+
ICAgICBjb21wbGV0ZWx5IGxvb3NlcyB0cmFjayBvZiB0aGUgcHJldmlvdXMgYWxsb2NhdGlvbnMu
IElmIHRoZSBzZWNvbmRhcnkKPiAgICAga2VybmVsIGRvZXNuJ3QgYWxsb2NhdGUgdGhlIHRhYmxl
cyBleGFjdGx5IHRoZSBzYW1lIHdheSwgbm8gTFBJcyB3aWxsCj4gICAgIGJlIGRlbGl2ZXJlZCBi
eSB0aGUgR0lDICh3aGljaCBjb250aW51ZXMgdG8gdXNlIHRoZSBvbGQgdGFibGVzKSwgYW5kCj4g
ICAgIG1lbW9yeSBwcmV2aW91c2x5IGFsbG9jYXRlZCBmb3IgdGhlIHBlbmRpbmcgdGFibGVzIHdp
bGwgYmUgc2xvd2x5Cj4gICAgIGNvcnJ1cHRlZCwgb25lIGJpdCBhdCBhIHRpbWUuCj4gCj4gICAg
IFRoZSB3b3JrYXJvdW5kIGZvciB0aGlzIGlzIGJhc2VkIG9uIGEgc2VyaWVzWzFdIGJ5IEFyZCBC
aWVzaGV1dmVsLAo+ICAgICB3aGljaCBhZGRzIHRoZSByZXF1aXJlZCBpbmZyYXN0cnVjdHVyZSBm
b3IgbWVtb3J5IHJlc2VydmF0aW9ucyB0byBiZQo+ICAgICBwYXNzZWQgZnJvbSBvbmUga2VybmVs
IHRvIGFub3RoZXIgdXNpbmcgYW4gRUZJIHRhYmxlLgo+IAo+ICAgICBUaGlzIGluZnJhc3RydWN0
dXJlIGlzIHRoZW4gdXNlZCB0byByZWdpc3RlciB0aGUgYWxsb2NhdGlvbiBvZiBHSUMKPiAgICAg
dGFibGVzIHdpdGggRUZJLCBhbmQgYWxsb3cgdGhlIEdJQyBkcml2ZXIgdG8gc2FmZWx5IHJldXNl
IHRoZSBleGlzdGluZwo+ICAgICBwcm9ncmFtbWluZyBpZiBpdCBkZXRlY3RzIHRoYXQgdGhlIHRh
YmxlcyBoYXZlIGJlZW4gY29ycmVjdGx5Cj4gICAgIHJlZ2lzdGVyZWQuIE9uIG5vbi1FRkkgc3lz
dGVtcywgdGhlcmUgaXMgbm90IG11Y2ggd2UgY2FuIGRvLgo+IAo+IAo+IFNvcnJ5IHRvIHR1cm4g
dGhpcyBxdWVzdGlvbiBvdXQgYWdhaW4uCj4gRm9yIG90aGVycyBub24tRUZJIHN5c3RlbXMsIGp1
c3QgYXMgeW91ciBzYWlkIHRpbGwgbm93IHdlIGRpZCBkbwo+IGFueXRoaW5nLCByaWdodD8KCldl
IGRpZG4ndCBkbyBhbnl0aGluZywgYmVjYXVzZSB0aGVyZSBpcyBub3RoaW5nIHdlIGNhbiBkby4K
Cj4gSSBkaWQgc2VlIHRoZSBrZXhlYyBib290aW5nIGZhaWx1cmUgc2luY2UgcmUtc2V0dGluZwo+
IHRoZcKgR0lDUl9DVExSLkVuYWJsZUxQSSBmcm9tICIxIiB0byAiMCIgdW5zdWNjZXNzZnVsLgo+
IAo+IFRoZcKgIGJlbG93IGNvbW1pdCBhZGRzIHRoZcKganVkZ2VtZW50IGZvciBkaXNhYmxpbmcg
TFBJcywgYW5kIHJldHVybmVkCj4gZXJyb3IuIENhdXNlZCAia2V4ZWMiIGJvb3RpbmfCoGZhaWx1
cmUuCgpBbmQgSSBmdWxseSBleHBlY3RlZCB0aGlzLiBXaGVuIEkgc2FpZCAid2UgZG9uJ3QgZG8g
YW55dGhpbmciLCBJIG1lYW50CiJ3ZSBkb24ndCBkbyBhbnl0aGluZyB0byBtYWtlIExQSXMgd29y
ayIuCgo+IAo+IDZlYjQ4NmI2NmEgKGlycWNoaXAvZ2ljLXYzOiBFbnN1cmUgR0lDUl9DVExSLkVu
YWJsZUxQST0wIGlzIG9ic2VydmVkCj4gYmVmb3JlIGVuYWJsaW5nKS4KPiAKPiA8c25pcCBwYXRj
aD4KPiDCoGludCBpdHNfY3B1X2luaXQodm9pZCkKPiDCoHsKPiDCoCDCoCDCoCDCoCBpZiAoIWxp
c3RfZW1wdHkoJml0c19ub2RlcykpIHsKPiAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoIWdp
Y19yZGlzdHNfc3VwcG9ydHNfcGxwaXMoKSkgewo+IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHByX2luZm8oIkNQVSVkOiBMUElzIG5vdCBzdXBwb3J0ZWRcbiIsCj4gc21wX3By
b2Nlc3Nvcl9pZCgpKTsKPiAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1
cm4gLUVOWElPOwo+IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH0KPiArwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBpbnQgcmV0Owo+ICsKPiArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXQgPSByZWRp
c3RfZGlzYWJsZV9scGlzKCk7Cj4gK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHJldCkKPiAr
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gcmV0Owo+ICsKCkFuZCBJ
IG1haW50YWluIHRoYXQgdGhpcyBpcyB0aGUgcmlnaHQgdGhpbmcgdG8gZG8uIElmIExQSXMgYXJl
IG9uIGFuZAp0aGUgbWVtb3J5IGhhcyBub3QgYmVlbiByZXNlcnZlZCwgaXQgaXMgdGhlbiBsaWtl
bHkgdGhhdCB0aGlzIG1lbW9yeSBpcwpub3cgYmVpbmcgdXNlZCBieSB0aGUga2VybmVsIGZvciBz
b21ldGhpbmcgZWxzZS4gVGhlIHN5c3RlbSBpcyB0aHVzCmdvaW5nIHRvIHNlZSBzaW5nbGUtYml0
IGNvcnJ1cHRpb24gaW4gc29tZSByYW5kb20gcGxhY2VzLgoKQXQgdGhhdCBzdGFnZSwgeW91ciBz
eXN0ZW0gaXMgaG9ycmlibHkgdW5zYWZlLCBhbmQgSSB3aWxsIG5vdCBsZXQgaXQKYm9vdCB1bmRl
ciB0aGVzZSBjb25kaXRpb25zLiBJZiBpdCB3YXMgd29ya2luZyBiZWZvcmUsIHRoYXQncyBiZWNh
dXNlCnlvdSB3ZXJlIGx1Y2t5LCBhbmQgSSBwbGFjZSBubyBmYWl0aCBpbiBsdWNrLgoKTm93IHlv
dSBoYXZlIHR3byBhbHRlcm5hdGl2ZXM6CgotIFlvdSBzd2l0Y2ggdG8gYW4gRUZJLWJhc2VkIGZp
cm13YXJlLiBUaGVzZSBkYXlzLCBldmVuIHUtYm9vdCBoYXMgYW4KRUZJIGltcGxlbWVudGF0aW9u
LiBDT25zaWRlciBkb2luZyB0aGF0IGlmIHlvdSBjYW4uCgotIElmIHRoZXJlIGlzIG5vIEVGSSBp
bXBsZW1lbnRhdGlvbiBmb3IgeW91ciBTb0MsIHlvdSBjYW4gcGFzcyB0aGUKImlycWNoaXAuZ2lj
djNfbm9scGk9MSIgb3B0aW9uIHRvIHRoZSBmaXJzdCBrZXJuZWwuIFRoaXMgd2lsbCBrZWVwIExQ
SQpkaXNhYmxlZCwgYW5kIHlvdSdsbCBiZSBhYmxlIHRvIGtleGVjIGEgc2Vjb25kYXJ5IGtlcm5l
bCAoYW5kIGdldAp3b3JraW5nIExQSXMgdGhlcmUpLiBUaGlzIGlzIHdoYXQgSSBkbyBvbiBteSBD
aHJvbWVib29rLgoKVGhhbmtzLAoKCU0uCi0tIApKYXp6IGlzIG5vdCBkZWFkLiBJdCBqdXN0IHNt
ZWxscyBmdW5ueS4uLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtYXJtLWtlcm5lbAo=

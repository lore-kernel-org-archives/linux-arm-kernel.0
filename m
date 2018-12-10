Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B2DC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:25:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 787BE20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mGUeQw/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787BE20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iTJjxKFcua1IOHrP4/DmydGD00laQTBGEMsuI6yM2g0=; b=mGUeQw/npl6CTY
	7Aq7zhCvwHvXASOcRuwEn6X1SYu7hagpj67CcN1PnM+/1/EEtE7FKvbE/xBd79bYbsMCkIXs2EA7h
	op5qE8XPbW5zGkddGorD7lzej0hSkp/j5PsMOUU33+jlt9eX3J3UVNc1EYvZ/pBcaQIs4jx7DLiRY
	bxxjy/9DC0IeopMl1V0ry1refzDLcjZ8gz2imhS786zslkl2G/i6iBvGsgiaToz9Rt+u05Go29jbs
	sNz/epfi0VdanR7XQ7oe2SzxdphLFA260/huCF1yYZIIFQiSQEOzdLvbrq+ISmBNV/LtOFF3bDnHQ
	gfoWSmKmbWdJisKgRajg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWIkL-0003kD-GM; Mon, 10 Dec 2018 10:25:05 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWIk1-0003NP-Mi
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 10:24:50 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFB101596;
 Mon, 10 Dec 2018 02:24:34 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 B2F733F6A8; Mon, 10 Dec 2018 02:24:32 -0800 (PST)
Subject: Re: [PATCH v3 1/8] arm64: KVM: Make VHE Stage-2 TLB invalidation
 operations non-interruptible
To: Christoffer Dall <christoffer.dall@arm.com>
References: <20181206173126.139877-1-marc.zyngier@arm.com>
 <20181206173126.139877-2-marc.zyngier@arm.com>
 <20181210100356.GG30263@e113682-lin.lund.arm.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <d9219768-bbef-5d51-3bb4-84cf35714a4d@arm.com>
Date: Mon, 10 Dec 2018 10:24:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181210100356.GG30263@e113682-lin.lund.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_022446_321898_67396E3B 
X-CRM114-Status: GOOD (  17.85  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 James Morse <james.morse@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQ2hyaXN0b2ZmZXIsCgpPbiAxMC8xMi8yMDE4IDEwOjAzLCBDaHJpc3RvZmZlciBEYWxsIHdy
b3RlOgo+IE9uIFRodSwgRGVjIDA2LCAyMDE4IGF0IDA1OjMxOjE5UE0gKzAwMDAsIE1hcmMgWnlu
Z2llciB3cm90ZToKPj4gQ29udHJhcnkgdG8gdGhlIG5vbi1WSEUgdmVyc2lvbiBvZiB0aGUgVExC
IGludmFsaWRhdGlvbiBoZWxwZXJzLCB0aGUgVkhFCj4+IGNvZGUgIGhhcyBpbnRlcnJ1cHRzIGVu
YWJsZWQsIG1lYW5pbmcgdGhhdCB3ZSBjYW4gdGFrZSBhbiBpbnRlcnJ1cHQgaW4KPj4gdGhlIG1p
ZGRsZSBvZiBzdWNoIGEgc2VxdWVuY2UsIGFuZCBzdGFydCBydW5uaW5nIHNvbWV0aGluZyBlbHNl
IHdpdGgKPj4gSENSX0VMMi5UR0UgY2xlYXJlZC4KPiAKPiBEbyB3ZSBoYXZlIHRvIGNsZWFyIFRH
RSB0byBwZXJmb3JtIHRoZSBUTEIgaW52YWxpZGF0aW9uLCBvciBpcyB0aGF0IGp1c3QKPiBhIHNp
ZGUtZWZmZWN0IG9mIHJlLXVzaW5nIGNvZGU/CgpXZSByZWFsbHkgZG8gbmVlZCB0byBjbGVhciBU
R0UuIEZyb20gdGhlIGRlc2NyaXB0aW9uIG9mIFRMQkkgVk1BTExFMUlTOgoKPHF1b3RlPgpXaGVu
IEVMMiBpcyBpbXBsZW1lbnRlZCBhbmQgZW5hYmxlZCBpbiB0aGUgY3VycmVudCBTZWN1cml0eSBz
dGF0ZToK4oCUIElmIEhDUl9FTDIue0UySCwgVEdFfSBpcyBub3QgezEsIDF9LCB0aGUgZW50cnkg
d291bGQgYmUgdXNlZCB3aXRoIHRoZQpjdXJyZW50IFZNSUQgYW5kIHdvdWxkIGJlIHJlcXVpcmVk
IHRvIHRyYW5zbGF0ZSB0aGUgc3BlY2lmaWVkIFZBIHVzaW5nCnRoZSBFTDEmMCB0cmFuc2xhdGlv
biByZWdpbWUuCuKAlCBJZiBIQ1JfRUwyLntFMkgsIFRHRX0gaXMgezEsIDF9LCB0aGUgZW50cnkg
d291bGQgYmUgcmVxdWlyZWQgdG8KdHJhbnNsYXRlIHRoZSBzcGVjaWZpZWQgVkEgdXNpbmcgdGhl
IEVMMiYwIHRyYW5zbGF0aW9uIHJlZ2ltZS4KPC9xdW90ZT4KCj4gQWxzbywgZG8gd2UgZ2VuZXJh
bGx5IHBlcmZvcm0gVExCIGludmFsaWRhdGlvbnMgaW4gdGhlIGtlcm5lbCB3aXRoCj4gaW50ZXJy
dXB0cyBkaXNhYmxlZCwgb3IgaXMgdGhpcyBqdXN0IGEgcmVzdWx0IG9mIGNsZWFyaW5nIFRHRT8K
ClRoYXQncyBkZWZpbml0ZWx5IGEgcmVzdWx0IG9mIGNsZWFyaW5nIFRHRS4gV2UgY291bGQgYmUg
dGFraW5nIGFuCmludGVycnVwdCBoZXJlLCBhbmQgZXhlY3V0ZSBhIHVzZXIgYWNjZXNzIG9uIHRo
ZSBiYWNrIG9mIGl0IChwZXJmIHdpbGwKaGFwcGlseSB3YWxrIGEgdXNlci1zcGFjZSBzdGFjayBp
biB0aGF0IGNvbnRleHQsIGZvciBleGFtcGxlKS4gSGF2aW5nClRHRSBjbGVhciBpbiB0aGF0IGNv
bnRleHQuIEFuIGFsdGVybmF0aXZlIHNvbHV0aW9uIHdvdWxkIGJlIHRvCnNhdmUvcmVzdG9yZSBU
R0Ugb24gaW50ZXJydXB0IGVudHJ5L2V4aXQsIGJ1dCB0aGF0J3MgYSBiaXQgb3ZlcmtpbGwgd2hl
bgp5b3UgY29uc2lkZXIgaG93IHJhcmVseSB3ZSBpc3N1ZSBzdWNoIFRMQiBpbnZhbGlkYXRpb24u
Cgo+IFNvbWVob3cgSSBmZWVsIGxpa2UgdGhpcyBzaG91bGQgbG9vayBtb3JlIGxpa2UganVzdCBh
bm90aGVyIFRMQgo+IGludmFsaWRhdGlvbiBpbiB0aGUga2VybmVsLCBidXQgaWYgdGhlcmUncyBh
IGdvb2QgcmVhc29uIHdoeSBpdCBjYW4ndAo+IHRoZW4gdGhpcyBpcyBmaW5lLgoKVGhlIHJlc3Qg
b2YgdGhlIFRMQiBpbnZhbGlkYXRpb24gaW4gdGhlIGtlcm5lbCBkb2Vzbid0IG5lZWQgdG8Kc2F2
ZS9yZXN0b3JlIGFueSBjb250ZXh0LiBUaGV5IGFwcGx5IHRvIGEgc2V0IG9mIHBhcmFtZXRlcnMg
dGhhdCBhcmUKYWxyZWFkeSBsb2FkZWQgb24gdGhlIENQVS4gV2hhdCB3ZSBoYXZlIGhlcmUgaXMg
c3Vic3RhbnRpYWxseSBkaWZmZXJlbnQuCgpUaGFua3MsCgoJTS4KLS0gCkphenogaXMgbm90IGRl
YWQuIEl0IGp1c3Qgc21lbGxzIGZ1bm55Li4uCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==

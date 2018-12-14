Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBBCC6786C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:55:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A098B2080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j0QFUIIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A098B2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9Djtd4cMCWDquf9rGGYh8DWVp/0pfhsmCBcAVHoW2go=; b=j0QFUIIVncY50P
	PEXtmxKnGGG4ak1c8/JLFw27V+nrZ4j8Qa8z9yS7fENayn/eux6rVzXCVkLIsmZD8rudYTOabGvJ1
	KNqX3XF7ttQHS0iqmyhsvyxmFWWVWCi6bix2IzKEFH71qFRrJ9f3N8kjdpMsSTxa+oAb6efVYZiyC
	sgifP2+kFKtDFEOMRxJHGyXGtdY4a9st6WRvuIMLLyUUjb1RRtudr6WjOlGOtFNhb29+Zo++HU/jK
	insdFpQUT7plOEXhS2mknrt1IjrV+1KTrfzEmpg35wLeV4NgWJnBsEGuuT21LmLg37zP+++z2O2Zh
	N3hP0B38Dh0a3N2HcV3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXjGA-0006gH-T5; Fri, 14 Dec 2018 08:55:50 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXjG7-0006ei-HP
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 08:55:49 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D623E80D;
 Fri, 14 Dec 2018 00:55:35 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EEFB3F614;
 Fri, 14 Dec 2018 00:55:33 -0800 (PST)
Subject: Re: [PATCH 2/6] arm64: add sysfs vulnerability show for meltdown
To: Jeremy Linton <jeremy.linton@arm.com>, linux-arm-kernel@lists.infradead.org
References: <20181206234408.1287689-1-jeremy.linton@arm.com>
 <20181206234408.1287689-3-jeremy.linton@arm.com>
 <d1ad00a8-1b87-f234-aa41-c1f342cb28dc@arm.com>
 <af4f1e1e-673d-28e0-909d-f1e85b4d5b45@arm.com>
 <3dfed0e1-9819-ccfd-1024-b6f64f5fbffe@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <a1a8fcb8-6a13-285a-0308-ccac37e36c49@arm.com>
Date: Fri, 14 Dec 2018 08:55:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <3dfed0e1-9819-ccfd-1024-b6f64f5fbffe@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_005547_590848_6F00D97D 
X-CRM114-Status: GOOD (  23.40  )
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
Cc: mark.rutland@arm.com, suzuki.poulose@arm.com, marc.zyngier@arm.com,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 ykaukab@suse.de, dave.martin@arm.com, shankerd@codeaurora.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgSmVyZW15LAoKT24gMTIvMTIvMjAxOCAxNDo0OSwgSmVyZW15IExpbnRvbiB3cm90ZToKPiBI
aSBKdWxpZW4sCj4gCj4gVGhhbmtzIGZvciB0YWtpbmcgYSBsb29rIGF0IHRoaXMhCj4gCj4gT24g
MTIvMTMvMjAxOCAwNDo0NiBBTSwgSnVsaWVuIFRoaWVycnkgd3JvdGU6Cj4+Cj4+Cj4+IE9uIDEz
LzEyLzIwMTggMDk6MjMsIEp1bGllbiBUaGllcnJ5IHdyb3RlOgo+Pj4gSGkgSmVyZW15LAo+Pj4K
Pj4+IE9uIDA2LzEyLzIwMTggMjM6NDQsIEplcmVteSBMaW50b24gd3JvdGU6Cj4+Pj4gQWRkIGEg
c2ltcGxlIHN0YXRlIG1hY2hpbmUgd2hpY2ggd2lsbCB0cmFjayB3aGV0aGVyCj4+Pj4gYWxsIHRo
ZSBvbmxpbmUgY29yZXMgaW4gYSBtYWNoaW5lIGFyZSB2dWxuZXJhYmxlLgo+Pj4+Cj4+Pj4gT25j
ZSB0aGF0IGlzIGRvbmUgd2UgaGF2ZSBhIGZhaXJseSBhdXRob3JpdGF0aXZlIHZpZXcKPj4+PiBv
ZiB0aGUgbWFjaGluZSB2dWxuZXJhYmlsaXR5LCB3aGljaCBhbGxvd3MgdXMgdG8gbWFrZSBhCj4+
Pj4ganVkZ21lbnQgYWJvdXQgbWFjaGluZSBzYWZldHkgaWYgaXQgaGFzbid0IGJlZW4gbWl0aWdh
dGVkLgo+Pj4+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogSmVyZW15IExpbnRvbiA8amVyZW15LmxpbnRv
bkBhcm0uY29tPgo+Pj4+IC0tLQo+Pj4+IMKgIGFyY2gvYXJtNjQva2VybmVsL2NwdWZlYXR1cmUu
YyB8IDMxICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0KPj4+PiDCoCAxIGZpbGUgY2hh
bmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPj4+Pgo+Pj4+IGRpZmYgLS1n
aXQgYS9hcmNoL2FybTY0L2tlcm5lbC9jcHVmZWF0dXJlLmMKPj4+PiBiL2FyY2gvYXJtNjQva2Vy
bmVsL2NwdWZlYXR1cmUuYwo+Pj4+IGluZGV4IDI0Mjg5ODM5NWY2OC4uYmVhOWFkZmVmN2ZhIDEw
MDY0NAo+Pj4+IC0tLSBhL2FyY2gvYXJtNjQva2VybmVsL2NwdWZlYXR1cmUuYwo+Pj4+ICsrKyBi
L2FyY2gvYXJtNjQva2VybmVsL2NwdWZlYXR1cmUuYwo+Pj4+IEBAIC05MDUsNiArOTA1LDggQEAg
aGFzX3VzZWFibGVfY25wKGNvbnN0IHN0cnVjdAo+Pj4+IGFybTY0X2NwdV9jYXBhYmlsaXRpZXMg
KmVudHJ5LCBpbnQgc2NvcGUpCj4+Pj4gwqDCoMKgwqDCoCByZXR1cm4gaGFzX2NwdWlkX2ZlYXR1
cmUoZW50cnksIHNjb3BlKTsKPj4+PiDCoCB9Cj4+Pj4gwqAgK3N0YXRpYyBlbnVtIHsgQTY0X01F
TFRfVU5TRVQsIEE2NF9NRUxUX1NBRkUsIEE2NF9NRUxUX1VOS04gfQo+Pj4+IF9fbWVsdGRvd25f
c2FmZSA9IEE2NF9NRUxUX1VOU0VUOwo+Pj4+ICsKPj4+Cj4+PiBJJ20gd29uZGVyaW5nLCBkbyB3
ZSByZWFsbHkgbmVlZCB0aGF0IHRyaSBzdGF0ZT8KPj4+Cj4+PiBDYW4ndCB3ZSBjb25zaWRlciB0
aGF0IHdlIGFyZSBzYWZlIGFuIG1vdmUgdG8gdW5zYWZlL3Vua293biBpZiBhbnkgY3B1Cj4+PiBk
dXJpbmcgYnJpbmcgdXAgaXMgbm90IGluIHRoZSBzYWZlIGxpc3Q/Cj4+Pgo+Pj4gVGhlIG9ubHkg
dXNlciBvZiB0aGlzIGlzIGNwdV9zaG93X21lbHRkb3duLCBidXQgSSBkb24ndCBpbWFnaW5lIGl0
J2xsCj4+PiBnZXQgY2FsbGVkIGJlZm9yZSB1bm1hcF9rZXJuZWxfYXRfZWwwKCkgaXMgY2FsbGVk
IGZvciB0aGUgYm9vdCBDUFUgd2hpY2gKPj4+IHNob3VsZCBpbml0aWFsaXNlIHRoYXQgc3RhdGUu
Cj4+Pgo+Pj4gT3IgaXMgdGhlcmUgYW5vdGhlciByZWFzb24gZm9yIGhhdmluZyB0aGF0IFVOU0VU
IHN0YXRlPwo+Pj4KPj4KPj4gT2ssIEkgdGhpbmsgSSBnZXQgdGhlIHBvaW50IG9mIHRoZSBVTlNF
VCBhcyAjaWZuZGVmCj4+IENPTkZJR19VTk1BUF9LRVJORUxfQVRfRUwwIHdlIGRvbid0IHNldCB0
aGUgc3RhdGUuIEJ1dCBkb2VzIHRoYXQgbWVhbiB3ZQo+PiBhbHdheXMgZmFsbCBpbiB0aGUgIlVu
a25vd24iIGNhc2Ugd2hlbiB3ZSBkb24ndCBidWlsZCBrcHRpIGluPyBJcyB0aGF0Cj4+IGRlc2ly
YWJsZT8KPj4KPj4gSWYgc28sIEknZCBzdWdnZXN0IHJlcGxhY2luZyB0aGUgdHJpLXN0YXRlIHdp
dGggdGhlIGZvbGxvd2luZyBjaGFuZ2U6Cj4+Cj4+Cj4+Pj4gKwo+Pj4+ICsjaWZkZWYgQ09ORklH
X0dFTkVSSUNfQ1BVX1ZVTE5FUkFCSUxJVElFUwo+Pj4+ICtzc2l6ZV90IGNwdV9zaG93X21lbHRk
b3duKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0Cj4+Pj4gZGV2aWNlX2F0dHJpYnV0ZSAqYXR0
ciwKPj4+PiArwqDCoMKgwqDCoMKgwqAgY2hhciAqYnVmKQo+Pj4+ICt7Cj4+Pj4gK8KgwqDCoCBp
ZiAoYXJtNjRfa2VybmVsX3VubWFwcGVkX2F0X2VsMCgpKQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gc3ByaW50ZihidWYsICJNaXRpZ2F0aW9uOiBLUFRJXG4iKTsKPj4+PiArCj4+Cj4+IMKg
wqDCoMKgaWYgKCFJU19FTkFCTEVEKFVOTUFQX0tFUk5FTF9BVF9FTDApIHx8ICFtZWx0ZG93bl9z
YWZlKQo+PiDCoMKgwqDCoMKgwqDCoCBzcHJpbnRmKGJ1ZiwgIlVua25vd25cbiIpOwo+PiDCoMKg
wqDCoGVsc2UKPj4gwqDCoMKgwqDCoMKgwqAgc3ByaW50ZihidWYsICJOb3QgYWZmZWN0ZWRcbiIp
Owo+IAo+IElmIEknbSB1bmRlcnN0YW5kaW5nIHdoYXQgeW91ciBzdWdnZXN0aW5nOgo+IAo+IElz
bid0IHRoaXMgb25seSBjaGVja2luZyB0aGUgY3VycmVudCBjb3JlLCByYXRoZXIgdGhhbiB0aGUg
d2hvbGUKPiBtYWNoaW5lPyBJSVJDIHRoYXQgd2FzIHRoZSBmdW5kYW1lbnRhbCBjb21wbGFpbnQg
d2l0aCB0aGUgb3JpZ2luYWwgc2V0Lgo+IAoKU29ycnksIHllcywgSSBtZWFudCB0byBjaGVjayAi
IV9fbWVsdGRvd25fc2FmZSIuIEJhc2ljYWxseSBteSBzdWdnZXN0aW9uCmlzIHRvIHJlcGxhY2Ug
dGhlIHN0YXRpYyBlbnVtIHZhcmlhYmxlIHdpdGggYSBzdGF0aWMgYm9vbCBhbmQgaGFuZGxlIHRo
ZQoiVU5TRVQiIGNhc2Ugb24gd2hldGhlciB3ZSBidWlsdCB0aGUgbWl0aWdhdGlvbi4KCkRvZXMg
dGhhdCBtYWtlIHNlbnNlPwoKSG93ZXZlciwgdGhlcmUncyBzdGlsbCB0aGUgc2FtZSBpc3N1ZSBh
cyB3aXRoIHBhdGNoIDQuIElmIHdlIGRvbid0IGJ1aWxkCnRoZSBtaXRpZ2F0aW9uLCB3ZSBzYXkg
dGhhdCB3ZSBkb24ndCBrbm93IHRoZSBzdGF0dXMgb2YgdGhlIHN5c3RlbS4gSQp0aGluayBpdCB3
b3VsZCBiZSBuaWNlIHRvIGJlIGFibGUgdG8gc2F5IHRoYXQgYSBzeXN0ZW0gaXMgc2FmZSBldmVu
IHdoZW4KdGhlIG1pdGlnYXRpb24gaXMgbm90IGJ1aWx0LiBQZW9wbGUga25vd2luZyB0aGV5IGhh
dmUgYSBzYWZlIHN5c3RlbQptaWdodCBiZSBpbmNsaW5lZCB0byBub3QgYnVpbGQgYWRkaXRpb25h
bCBzdHVmZiB0aGV5IGRvbid0IG5lZWQuCgpDaGVlcnMuCgotLSAKSnVsaWVuIFRoaWVycnkKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1r
ZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJu
ZWwK

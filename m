Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66848C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:21:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36D7521901
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DcF/oCmY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PEcepZCU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D7521901
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZUijfnan4HhiXB1gHc2ovej6MrHxtx8YFdMc+RcXD48=; b=DcF/oCmYoxizCw
	PpIv04od0Gb+R1kkeO30CFDhc04aO7ff0ZDfapFqmPJxxLoI9CIdy2BSW70Sw03oIet56eEKa1U9u
	CbmgWT/Xiff60g12MfGIiDUTD8bv9inRC2BEdjrFUIgbaGGStlTSvbRhwwBot7DUzqQYqPn8PYlka
	b0T4i/ekfeB6DiqGGimDgUmrAXK3QmoFYhg0M/jn/qEszlJP9EFcaAC8F0vjwg8sbDxhns7X+e5c6
	UqYbKQfE+n+n7P2TenxH/cv1DfItPpICoxOryw5QZ7U6ZubDolkwYz/ufJIeMsNMC61pTO6fGCjjg
	AhSVSsMvJatXX6IT7g2Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvjnN-0000fM-5s; Mon, 18 Feb 2019 14:21:21 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvjnL-0000fF-V3
 for linux-arm-kernel@bombadil.infradead.org; Mon, 18 Feb 2019 14:21:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aDR+6/m3fM4uelL4pZ08ESUHaduq83b1KvuBZA/euds=; b=PEcepZCUwd1brbrLcY+mc2U5w2
 jJYvh/WeNQrqqk7YOUiABiSrN8amnX+HMHNN0e6d9+T/YgjESwyRFRTVH3zYHfzdc1CaWKFgPvCW6
 s6T7fvF2fC8QW6QxagMY63l4yKfTK2RsEoulgVtJ4PgHbJVZLX2LnQHyxpg4o7xuF++NXXHa2osp5
 pumFJWDpOUYWK0/jJY+VjIwvz56vrHGXWXA/Upc1jzi7nNcysOfyuh0k9vUoBJ9pKFCCyNXX3WSoX
 TbG5WeMCn0CM8aKn6b/f+7DS2jLC7mPKcsPVAjLbbBMUMoQ2lPB0mC26aU/vFcAGR5qLR11YrcuTm
 jfJ7LdPQ==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvjnD-0007OO-R6
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 14:21:17 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51406A78;
 Mon, 18 Feb 2019 06:16:04 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47CE83F589;
 Mon, 18 Feb 2019 06:15:58 -0800 (PST)
Date: Mon, 18 Feb 2019 14:15:45 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
To: =?UTF-8?B?QW5kcsOp?= Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH 1/2] KVM: arm/arm64: Add save/restore support for
 firmware workaround state
Message-ID: <20190218141545.2d677718@why.wild-wind.fr.eu.org>
In-Reply-To: <24383efc-795c-163b-0346-315f88f3774f@arm.com>
References: <20190107120537.184252-1-andre.przywara@arm.com>
 <20190107120537.184252-2-andre.przywara@arm.com>
 <20190122151714.GG3578@e103592.cambridge.arm.com>
 <20190125144657.3db91c91@donnerap.cambridge.arm.com>
 <20190129213223.GB3567@e103592.cambridge.arm.com>
 <20190130113900.10089070@donnerap.cambridge.arm.com>
 <20190215095857.2fd7e0fb@donnerap.cambridge.arm.com>
 <864l95s2fw.wl-marc.zyngier@arm.com>
 <20190215172558.GO3567@e103592.cambridge.arm.com>
 <20190218090731.3d313d81@why.wild-wind.fr.eu.org>
 <24383efc-795c-163b-0346-315f88f3774f@arm.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_092116_717462_5C44912C 
X-CRM114-Status: GOOD (  43.07  )
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
Cc: linux-arm-kernel@lists.infradead.org, Dave Martin <Dave.Martin@arm.com>,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCAxOCBGZWIgMjAxOSAxMToyOTo1NyArMDAwMApBbmRyw6kgUHJ6eXdhcmEgPGFuZHJl
LnByenl3YXJhQGFybS5jb20+IHdyb3RlOgoKPiBPbiAxOC8wMi8yMDE5IDA5OjA3LCBNYXJjIFp5
bmdpZXIgd3JvdGU6Cj4gPiBPbiBGcmksIDE1IEZlYiAyMDE5IDE3OjI2OjAyICswMDAwCj4gPiBE
YXZlIE1hcnRpbiA8RGF2ZS5NYXJ0aW5AYXJtLmNvbT4gd3JvdGU6ICAKPiAKPiBIaSwKPiAKPiA+
ICAgCj4gPj4gT24gRnJpLCBGZWIgMTUsIDIwMTkgYXQgMTE6NDI6MjdBTSArMDAwMCwgTWFyYyBa
eW5naWVyIHdyb3RlOiAgCj4gPj4+IE9uIEZyaSwgMTUgRmViIDIwMTkgMDk6NTg6NTcgKzAwMDAs
Cj4gPj4+IEFuZHJlIFByenl3YXJhIDxhbmRyZS5wcnp5d2FyYUBhcm0uY29tPiB3cm90ZTogICAg
Cj4gPj4+Pgo+ID4+Pj4gT24gV2VkLCAzMCBKYW4gMjAxOSAxMTozOTowMCArMDAwMAo+ID4+Pj4g
QW5kcmUgUHJ6eXdhcmEgPGFuZHJlLnByenl3YXJhQGFybS5jb20+IHdyb3RlOgo+ID4+Pj4KPiA+
Pj4+IFBldGVyLCBNYXJjLCBDaHJpc3RvZmZlciwKPiA+Pj4+Cj4gPj4+PiBjYW4gd2UgaGF2ZSBh
biBvcGluaW9uIG9uIHdoZXRoZXIgaXQncyB1c2VmdWwgdG8gaW50cm9kdWNlIHNvbWUKPiA+Pj4+
IGNvbW1vbiBzY2hlbWUgZm9yIGZpcm13YXJlIHdvcmthcm91bmQgc3lzdGVtIHJlZ2lzdGVycyAo
cGFydHMgb2YKPiA+Pj4+IEtWTV9SRUdfQVJNX0ZXX1JFRyh4KSksIHdoaWNoIHdvdWxkIGFsbG93
IGNoZWNraW5nIHRoZW0gZm9yCj4gPj4+PiBjb21wYXRpYmlsaXR5IGJldHdlZW4gdHdvIGtlcm5l
bHMgd2l0aG91dCBzcGVjaWZpY2FsbHkga25vd2luZyBhYm91dAo+ID4+Pj4gdGhlbT8KPiA+Pj4+
IERhdmUgc3VnZ2VzdGVkIHRvIGludHJvZHVjZSBzb21lIGtpbmQgb2Ygc2lnbmVkIGVuY29kaW5n
IGluIHRoZSA0Cj4gPj4+PiBMU0JzIGZvciBhbGwgdGhvc2UgcmVnaXN0ZXJzIChpbmNsdWRpbmcg
ZnV0dXJlIG9uZXMpLCB3aGVyZSAwIG1lYW5zCj4gPj4+PiBVTktOT1dOIGFuZCBncmVhdGVyIHZh
bHVlcyBhcmUgYmV0dGVyLiBTbyB3aXRob3V0IGtub3dpbmcgYWJvdXQgdGhlCj4gPj4+PiBwYXJ0
aWN1bGFyIHJlZ2lzdGVyLCBvbmUgY291bGQganVkZ2Ugd2hldGhlciBpdCdzIHNhZmUgdG8gbWln
cmF0ZS4KPiA+Pj4+IEkgYW0ganVzdCBub3Qgc3VyZSBob3cgdXNlZnVsIHRoaXMgaXMsIGdpdmVu
IHRoYXQgUUVNVSBzZWVtcyB0byBhc2sKPiA+Pj4+IHRoZSByZWNlaXZpbmcga2VybmVsIGFib3V0
IGFueSBzeXNyZWcsIGFuZCBkb2Vzbid0IHBhcnRpY3VsYXJseSBjYXJlCj4gPj4+PiBhYm91dCB0
aGUgbWVhbmluZyBvZiB0aG9zZSByZWdpc3RlcnMuIEFuZCBJIGFtIG5vdCBzdXJlIHdlIHJlYWxs
eQo+ID4+Pj4gd2FudCB0byBpbnRyb2R1Y2Ugc29tZSBraW5kIG9mIGZvcndhcmQgbG9va2luZyBz
Y2hlbWUgaW4gdGhlIGtlcm5lbAo+ID4+Pj4gaGVyZSwgc2hvcnQgb2YgYSB3b3JraW5nIGNyeXN0
YWwgYmFsbC4gSSB0aGluayB0aGUga2VybmVsIHBvbGljeSB3YXMKPiA+Pj4+IGFsd2F5cyB0byBi
ZSBhcyBzdHJpY3QgYXMgcG9zc2libGUgYWJvdXQgdGhvc2UgdGhpbmdzLiAgICAKPiA+Pj4KPiA+
Pj4gSSBob25lc3RseSBkb24ndCB1bmRlcnN0YW5kIGhvdyB1c2Vyc3BhY2UgY2FuIGRlY2lkZSB3
aGV0aGVyIGEgZ2l2ZW4KPiA+Pj4gY29uZmlndXJhdGlvbiBpcyBtaWdyYXRhYmxlIG9yIG5vdCBz
b2xlbHkgYmFzZWQgb24gdGhlIHZhbHVlIG9mIHN1Y2ggYQo+ID4+PiByZWdpc3Rlci4gSW4gbXkg
ZXhwZXJpZW5jZSwgdGhlIHRhcmdldCBzeXN0ZW0gaGFzIGEgcm9sZSB0byBwbGF5LCBhbmQKPiA+
Pj4gaXMgdGhlIG9ubHkgcGxhY2Ugd2hlcmUgd2UgY2FuIGZpbmQgb3V0IGFib3V0IHdoZXRoZXIg
bWlncmF0aW9uIGlzCj4gPj4+IGFjdHVhbGx5IHBvc3NpYmxlLiAgICAKPiA+Pgo+ID4+IEJvdGgg
b3JpZ2luIGFuZCB0YXJnZXQgc3lzdGVtIG5lZWQgdG8gYmUgdGFrZW4gaW50byBhY2NvdW50LiAg
SSBkb24ndAo+ID4+IHRoaW5rIHRoYXQncyBhbnl0aGluZyBuZXcuICAKPiA+IAo+ID4gV2VsbCwg
dGhhdCB3YXMgd2hhdCBJIHVuZGVyc3Rvb2QgZnJvbSBBbmRyZSdzIHF1ZXN0aW9uLgo+ID4gICAK
PiA+PiAgCj4gPj4+IEFzIHlvdSBzYWlkLCB1c2Vyc3BhY2UgZG9lc24ndCBpbnRlcnByZXQgdGhl
IGRhdGEsIG5vciBzaG91bGQgaXQuIEl0Cj4gPj4+IGlzIG9ubHkgb24gdGhlIHJlY2VpdmluZyBl
bmQgdGhhdCBjb21wYXRpYmlsaXR5IGlzIGFzc2Vzc2VkIGFuZAo+ID4+PiB3aGV0aGVyIHNvbWUg
bGV2ZWwgb2YgY29tcGF0aWJpbGl0eSBjYW4gYmUgc2FmZWx5IGVuc3VyZWQuCj4gPj4+Cj4gPj4+
IFNvIHRvIHN1bSBpdCB1cCwgSSBkb24ndCBiZWxpZXZlIGluIHRoaXMgYXBwcm9hY2ggYXMgYSBn
ZW5lcmFsIHdheSBvZgo+ID4+PiBkZXNjcmliaW5nIHRoZSBoYW5kbGluZyBvciBlcnJhdGEuICAg
IAo+ID4+Cj4gPj4gRm9yIGNvbnRleHQsIG15IGlkZWEgYXR0ZW1wdGVkIHRvIHB1dCBLVk0sIG5v
dCB1c2Vyc3BhY2UsIGluIGNoYXJnZSBvZgo+ID4+IHRoZSBkZWNpc2lvbjogdXNlcnNwYWNlIGFw
cGxpZXMgZml4ZWQgY29tcGFyaXNvbiBydWxlcyBkZXRlcm1pbmVkIGFoZWFkCj4gPj4gb2YgdGlt
ZSwgYnV0IEtWTSBzdXBwbGllcyB0aGUgdmFsdWVzIGNvbXBhcmVkIChhbmQgaGVuY2UgZGV0ZXJt
aW5lcyB0aGUKPiA+PiByZXN1bHQpLgo+ID4+Cj4gPj4gTXkgd29ycnkgd2FzIHRoYXQgb3RoZXJ3
aXNlIHdlIG1heSBlbmQgdXAgd2l0aCBhIHdpbGQtd2VzdCB0YW5nbGUgb2YKPiA+PiBhcmJpdHJh
cnkgcHJvcGVydGllcyB0aGF0IHVzZXJzcGFjZSBuZWVkcyBzcGVjaWZpYyBrbm93bGVkZ2UgYWJv
dXQuICAKPiA+IAo+ID4gQW5kIHRoaXMgaXMgd2hlcmUgb3VyIHVuZGVyc3RhbmRpbmcgZGlmZmVy
cy4gSSBkbyBub3QgdGhpbmsgdXNlcnNwYWNlCj4gPiBoYXMgdG8gY2FyZSBhdCBhbGwuIEFsbCBp
dCBoYXMgdG8gZG8gaXMgdG8gcHJvdmlkZSB0aGUgc2F2ZWQgcmVnaXN0ZXIKPiA+IHZhbHVlcyB0
byB0aGUgdGFyZ2V0IHN5c3RlbSwgYW5kIGxldCBLVk0gYWNjZXB0IG9yIHJlZnVzZSB0aGVzZQo+
ID4gc2V0dGluZ3MuIEkgY2FuJ3Qgc2VlIHdoYXQgcHJvdmlkaW5nIGEgc2V0IG9mIHByZWRlZmlu
ZWQgdmFsdWVzIGJhY2sgdG8KPiA+IHVzZXJzcGFjZSBnYWlucyB1cy4KPiA+IAo+ID4gQW4gdW5r
bm93biByZWdpc3RlciBvbiB0aGUgdGFyZ2V0IHN5c3RlbSBmYWlscyB0aGUgcmVzdG9yZSBwaGFz
ZToKPiA+IHRoYXQncyBhYnNvbHV0ZWx5IGZpbmUsIGFzIHdlIGRvbid0IHdhbnQgdG8gcnVuIG9u
IGEgc3lzdGVtIHRoYXQKPiA+IGRvZXNuJ3Qga25vdyBhYm91dCB0aGUgbWl0aWdhdGlvbi4KPiA+
IAo+ID4gQW4gaW5jb21wYXRpYmxlIHZhbHVlIGZhaWxzIHRoZSByZXN0b3JlIGFzIHdlbGwsIGFz
IEtWTSBpdHNlbGYgZmluZHMKPiA+IHRoYXQgdGhpcyBpcyBhIHNlcnZpY2UgaXQgY2Fubm90IHNh
ZmVseSBwcm92aWRlLgo+ID4gCj4gPiBObyB1c2Vyc3BhY2UgaW52b2x2ZW1lbnQsIG5vIFFFTVUg
dXBncmFkZSByZXF1aXJlZC4gT25seSB0aGUga2VybmVsCj4gPiBrbm93cyBhYm91dCBpdC4gIAo+
IAo+IFllcywgdGhpcyBpcyB3aGF0IEkgdW5kZXJzdGFuZCBhcyB3ZWxsLiBGcm9tIGV4cGVyaWVu
Y2UsIG1hbnkgdGltZXMgd2hlbgo+IHdlIHdlcmUgbm90IHN0cmljdCBlbm91Z2ggYWJvdXQgc29t
ZSB1c2VybGFuZCBpbnRlcmZhY2UsIGl0IGJhY2tmaXJlZC4KPiAKPiBUaGUgb25seSBjYXNlIHdo
ZXJlIHN1Y2ggYSBmb3J3YXJkLWxvb2tpbmcgc2NoZW1lIHdvdWxkIG1ha2Ugc2Vuc2UgaXMKPiB0
aGUgY2FzZSB3aGVyZSB0aGUgc291cmNlIHN5c3RlbSBoYXMgYSBuZXcga2VybmVsLCBhZHZlcnRp
c2luZyBhIG5ldwo+IGZpcm13YXJlIHdvcmthcm91bmQgcmVnaXN0ZXIsIGluIGFuIHVua25vd24g
b3IgbWlzc2luZyBzdGF0ZSAoMCBvciAtMSkuCj4gQW4gb2xkZXIga2VybmVsIG9uIHRoZSB0YXJn
ZXQgc3lzdGVtIG1pZ2h0IG5vdCBrbm93IGFib3V0IHRoaXMgcmVnaXN0ZXIuCj4gVGhhdCB3b3Vs
ZCB0cmFuc2xhdGUgaW50byAidW5rbm93biIsIHdoaWNoIGlzIGNvbXBhdGlibGUgd2l0aCAwIG9y
IC0xCj4gZnJvbSB0aGUgc291cmNlLiBTbyBtaWdyYXRpb24gd291bGQgYmUgZmluZSwgYnV0IHdl
IGRlbnkgaXQgYmVjYXVzZSB0aGUKPiBuZXcga2VybmVsIHJldHVybnMgLUVJTlZBTC4KPiAKPiBC
dXQgSSBhbSBub3Qgc3VyZSB0aGlzIGNvbnN0cnVjdCBpcyB3b3J0aCBpbXBsZW1lbnRpbmcgaW4g
dGhlIGtlcm5lbC4gSWYKPiBwZW9wbGUgY2FyZSBhYm91dCB0aGlzIGNhc2UsIHRoZXkgY291bGQg
aW1wbGVtZW50IGEgd29ya2Fyb3VuZCBpbgo+IHVzZXJsYW5kIGluc3RlYWQuIE9yIGp1c3QgdXBn
cmFkZSB0aGUgdGFyZ2V0IGtlcm5lbCBiZWZvcmUgbWlncmF0aW9uLgoKVXBncmFkaW5nIHRoZSB0
YXJnZXQgbWF5IG5vdCBiZSBjb252ZW5pZW50LiBCdXQgbW9yZSBpbXBvcnRhbnRseSwgSQpkb24n
dCB0aGluayB3ZSBleHBlY3QgZG93bmdyYWRlcyB0byBiZSBzdXBwb3J0ZWQuIFRoaXMgY2FuIGJy
ZWFrIGZvciBhbgppbmZpbml0eSBvZiByZWFzb25zLCBzdWNoIGFzIHRoZSBmZWF0dXJlIHNldCBp
bXBsZW1lbnRlZCBvbiB0aGUgc291cmNlCm5vdCBiZWluZyB0aGVyZSBvbiB0aGUgdGFyZ2V0LgoK
QXMgeW91IHNhaWQsIGlmIHVzZXJzcGFjZSB3YW50cyB0byBieXBhc3MgdGhlc2UgcmVzdHJpY3Rp
b25zLCBpdCBjYW4KYWx0ZXIgdGhlIGRhdGEgYmVmb3JlIHJlc3RvcmluZy4KCj4gCj4gPj4gV2Ug
Y2FuIHRvbGVyYXRlIGEgZmV3IHRob3VnaC4gIElmIHdlIGFjY3VtdWxhdGUgYSBzaWduaWZpY2Fu
dCBudW1iZXIKPiA+PiBvZiBlcnJhdGEvdnVsbmVyYWJpbGl0eSBwcm9wZXJ0aWVzIHRoYXQgbmVl
ZCB0byBiZSByZXBvcnRlZCB0bwo+ID4+IHVzZXJzcGFjZSwgdGhpcyBtYXkgYmUgd29ydGggcmV2
aXNpdGluZy4gIElmIG5vdCwgaXQgZG9lc24ndCBtYXR0ZXIuICAKPiA+IAo+ID4gQW5kcmU6IGlm
IHlvdSB3YW50IHRoaXMgdG8gbWFrZSBpdCBpbnRvIDUuMSwgdGhlIHRpbWUgaXMgbm93LiAgCj4g
Cj4gT0suIFNvIGlzIHYyIFsxXSBmaW5lIHRoZW4/IFRoaXMgaW1wbGVtZW50cyB0aGUgbXVjaCBl
YXNpZXIgImJpZ2dlciBpcwo+IGJldHRlciIgc2NoZW1lLCBidXQgYmVpbmcgMCBiYXNlZCBpbnN0
ZWFkIG9mIHVzaW5nIGEgNC1iaXQgc2lnbmVkIGVuY29kaW5nLgo+IExldCBtZSBrbm93IGlmIHRo
ZXJlIGlzIHNvbWV0aGluZyB0byByZXdvcmsgaW4gdGhlcmUuCj4gCj4gQ2hlZXJzLAo+IEFuZHJl
Lgo+IAo+IFsxXQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL3BpcGVybWFpbC9saW51eC1h
cm0ta2VybmVsLzIwMTktSmFudWFyeS82Mjc3MzkuaHRtbAoKU29ycnksIEkndmUgbG9zdCB0cmFj
ayBvZiB3aGljaCBpcyB3aGljaC4gUGxlYXNlIHBvc3Qgc29tZXRoaW5nIHRoYXQgaXMKY29uc2lz
dGVudCwgIGFuZCBhZGRyZXNzZXMgU3RldmUncyBjb25jZXJucyBpZiB0aGVyZSBpcyBzdGlsbCBh
bnkuIE1ha2UKc3VyZSBpdCBhcHBsaWVzIG9uIHRvcCBvZiB0aGUgY3VycmVudCBrdm1hcm0vbmV4
dCwgYW5kIHByb3ZpZGUKZXZpZGVuY2VzIHRoYXQgeW91J3ZlIHRlc3RlZCBtaWdyYXRpb24gb24g
dGhlIGV4cGVjdGVkIHdvcmtpbmcgYW5kCmV4cGVjdGVkIGZhaWxpbmcgY29uZmlndXJhdGlvbnMu
CgpUaGFua3MsCgoJTS4KLS0gCldpdGhvdXQgZGV2aWF0aW9uIGZyb20gdGhlIG5vcm0sIHByb2dy
ZXNzIGlzIG5vdCBwb3NzaWJsZS4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK

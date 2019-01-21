Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED8FC31681
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:59:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E321F2089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rJDSngua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E321F2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A/84NJHN3C3AZOtljUwA+1gAcbi46sXKxcEyIz27U3A=; b=rJDSngua8SvGvP
	uNqAv7euqgkAQTvTxZ4JHwTbVorM5U3NPEqD6EqrBPDyHLbrrj0sMuCmCy/EIOKBJdvMMYz/t1cDD
	BBNhhrki8Ixw/Xqw/MnawI4mBz263uhcjU6L3fpqZtRtMJMd+17qWIMq8LH/5JZBqUAuF1tKoJLZs
	VGWTo4icEYFDo+gofk3CnjkqK1YJf1aw7BYelBs8E13TRnHSmVtgEjHFJOJ3bKwPo0dthDlAZ11BW
	P6XjTnvTkQxJ64IjqelhFHkEYi984Mj+Bi1Xf96gs/03DUgiVsGePX5Mx7xnPYC5NsjsH86DsFq2Y
	GxOzfz/4YlJmIwlG3XuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gldrR-0007YF-Ky; Mon, 21 Jan 2019 17:59:49 +0000
Received: from mailoutvs63.siol.net ([185.57.226.254] helo=mail.siol.net)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gldrN-0007XR-FO
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 17:59:47 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail.siol.net (Postfix) with ESMTP id 9D51B5208D6;
 Mon, 21 Jan 2019 18:59:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
 by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new,
 port 10032)
 with ESMTP id YWnJiO7hhOen; Mon, 21 Jan 2019 18:59:42 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
 by mail.siol.net (Postfix) with ESMTPS id 1C4065208D5;
 Mon, 21 Jan 2019 18:59:42 +0100 (CET)
Received: from jernej-laptop.localnet (cpe1-8-82.cable.triera.net
 [213.161.8.82]) (Authenticated sender: 031275009)
 by mail.siol.net (Postfix) with ESMTPA id 7C424520265;
 Mon, 21 Jan 2019 18:59:41 +0100 (CET)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 1/3] media: dt: bindings: sunxi-ir: Add A64 compatible
Date: Mon, 21 Jan 2019 18:59:41 +0100
Message-ID: <11138144.2AFLRTQIGB@jernej-laptop>
In-Reply-To: <CAGb2v65t6kO9HfSTuXZsBu6Pyc+mueLq-5tsYsw9vxwg5o=v4A@mail.gmail.com>
References: <20190111173015.12119-1-jernej.skrabec@siol.net>
 <3128239.8RYQUhiYef@jernej-laptop>
 <CAGb2v65t6kO9HfSTuXZsBu6Pyc+mueLq-5tsYsw9vxwg5o=v4A@mail.gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_095945_838130_32049B14 
X-CRM114-Status: GOOD (  32.78  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Rob Herring <robh+dt@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RG5lIHBvbmVkZWxqZWssIDIxLiBqYW51YXIgMjAxOSBvYiAxODozOToyNiBDRVQgamUgQ2hlbi1Z
dSBUc2FpIG5hcGlzYWwoYSk6Cj4gT24gVHVlLCBKYW4gMjIsIDIwMTkgYXQgMTozMyBBTSBKZXJu
ZWogxaBrcmFiZWMgPGplcm5lai5za3JhYmVjQHNpb2wubmV0PiAKd3JvdGU6Cj4gPiBEbmUgcG9u
ZWRlbGplaywgMjEuIGphbnVhciAyMDE5IG9iIDEwOjU3OjU3IENFVCBqZSBDaGVuLVl1IFRzYWkg
Cm5hcGlzYWwoYSk6Cj4gPiA+IE9uIE1vbiwgSmFuIDIxLCAyMDE5IGF0IDU6NTAgUE0gTWF4aW1l
IFJpcGFyZAo+ID4gPiA8bWF4aW1lLnJpcGFyZEBib290bGluLmNvbT4KPiA+IAo+ID4gd3JvdGU6
Cj4gPiA+ID4gSGksCj4gPiA+ID4gCj4gPiA+ID4gSSdtIGEgYml0IGxhdGUgdG8gdGhlIHBhcnR5
LCBzb3JyeSBmb3IgdGhhdC4KPiA+ID4gPiAKPiA+ID4gPiBPbiBTYXQsIEphbiAxMiwgMjAxOSBh
dCAwOTo1NjoxMUFNICswODAwLCBDaGVuLVl1IFRzYWkgd3JvdGU6Cj4gPiA+ID4gPiBPbiBTYXQs
IEphbiAxMiwgMjAxOSBhdCAxOjMwIEFNIEplcm5laiBTa3JhYmVjCj4gPiA+ID4gPiA8amVybmVq
LnNrcmFiZWNAc2lvbC5uZXQ+Cj4gPiAKPiA+IHdyb3RlOgo+ID4gPiA+ID4gPiBBNjQgSVIgaXMg
Y29tcGF0aWJsZSB3aXRoIEExMywgc28gYWRkIEE2NCBjb21wYXRpYmxlIHdpdGggQTEzIGFzIGEK
PiA+ID4gPiA+ID4gZmFsbGJhY2suCj4gPiA+ID4gPiAKPiA+ID4gPiA+IFdlIGFzayBwZW9wbGUg
dG8gYWRkIHRoZSBTb0Mtc3BlY2lmaWMgY29tcGF0aWJsZSBhcyBhIGNvbnRpZ2VuY3ksCj4gPiA+
ID4gPiBpbiBjYXNlIHRoaW5ncyB0dXJuIG91dCB0byBiZSBub3Qgc28gImNvbXBhdGlibGUiLgo+
ID4gPiA+ID4gCj4gPiA+ID4gPiBUbyBiZSBjb25zaXN0ZW50IHdpdGggYWxsIHRoZSBvdGhlciBT
b0NzIGFuZCBvdGhlciBwZXJpcGhlcmFscywKPiA+ID4gPiA+IHVubGVzcyB5b3UgYWxyZWFkeSBz
cG90dGVkIGEgImNvbXBhdGlibGUiIGRpZmZlcmVuY2UgaW4gdGhlCj4gPiA+ID4gPiBoYXJkd2Fy
ZSwgaS5lLiB0aGUgaGFyZHdhcmUgaXNuJ3QgY29tcGxldGVseSB0aGUgc2FtZSwgdGhpcwo+ID4g
PiA+ID4gcGF0Y2ggaXNuJ3QgbmVlZGVkLiBPbiB0aGUgb3RoZXIgaGFuZCwgaWYgeW91IGRpZCwg
cGxlYXNlIG1lbnRpb24KPiA+ID4gPiA+IHRoZSBkaWZmZXJlbmNlcyBpbiB0aGUgY29tbWl0IGxv
Zy4KPiA+ID4gPiAKPiA+ID4gPiBFdmVuIGlmIHdlIGRvbid0IHNwb3QgdGhpbmdzLCBzaW5jZSB3
ZSBoYXZlIHRoZSBzdGFibGUgRFQgbm93LCBpZiB3ZQo+ID4gPiA+IGV2ZXIgaGFkIHRoYXQgY29t
cGF0aWJsZSBpbiB0aGUgRFQgZnJvbSBkYXkgMSwgaXQncyBtdWNoIGVhc2llciB0bwo+ID4gPiA+
IGRlYWwgd2l0aC4KPiA+ID4gPiAKPiA+ID4gPiBJJ2QgcmVhbGx5IGxpa2UgdG8gaGF2ZSB0aGF0
IHBhdHRlcm4gZm9yIGFsbCB0aGUgSVBzIGV2ZW4gaWYgd2UgZGlkbid0Cj4gPiA+ID4gc3BvdCBh
bnkgaXNzdWUsIHNpbmNlIHdlIGNhbid0IHJlYWxseSBzYXkgdGhhdCB0aGUgZGF0YXNoZWV0IGFy
ZQo+ID4gPiA+IGNvbXBsZXRlLCBhbmQgb25lIGNhbiBhbHdheXMgbWFrZSBhIG1pc3Rha2UgYW5k
IG92ZXJsb29rIHNvbWV0aGluZy4KPiA+ID4gPiAKPiA+ID4gPiBJJ20gZmluZSB3aXRoIHRoaXMg
dmVyc2lvbiwgYW5kIGNhbiBhcHBseSBpdCBhcyBpcyBpZiB3ZSBhbGwgYWdyZWUuCj4gPiA+IAo+
ID4gPiBJJ20gT0sgd2l0aCBoYXZpbmcgdGhlIGZhbGxiYWNrIGNvbXBhdGlibGUuIEknbSBqdXN0
IHBvaW50aW5nIG91dAo+ID4gPiB0aGF0IHRoZXJlIGFyZSBhbmQgd2lsbCBiZSBhIHdob2xlIGJ1
bmNoIG9mIHRoZW0sIGFuZCB3ZSBkb24ndCBuZWVkCj4gPiA+IHRvIGRvY3VtZW50IGFsbCBvZiB0
aGVtIHVubGVzcyB3ZSBhcmUgYWN0dWFsbHkgZG9pbmcgc29tZXRoaW5nIHRvCj4gPiA+IHN1cHBv
cnQgdGhlbS4KPiA+IAo+ID4gSWYgeW91IGRvbid0IGRvY3VtZW50IHRoZW0sIGNoZWNrcGF0Y2gg
d2lsbCBjb21wbGFpbi4gQnV0IGlmIHlvdSBjYW4gbGl2ZQo+ID4gd2l0aCB0aGlzIHdhcm5pbmcs
IHRoYXQncyBmaW5lIGJ5IG1lLgo+ID4gCj4gPiA+IE9uIHRoZSBvdGhlciBoYW5kLCB0aGUgY29t
cGF0aWJsZSBzdHJpbmcgc2l0dWF0aW9uIGZvciBJUiBuZWVkcyBhCj4gPiA+IGJpdCBvZiBjbGVh
bmluZyB1cCBhdCB0aGUgbW9tZW50LiBSaWdodCBub3cgd2UgaGF2ZSBzdW40aS1hMTAgYW5kCj4g
PiA+IHN1bjVpLWExMy4gQXMgSmVybmVqIHBvaW50ZWQgb3V0LCB0aGUgQTEzJ3MgcmVnaXN0ZXIg
ZGVmaW5pdGlvbiBpcwo+ID4gPiBkaWZmZXJlbnQgZnJvbSBBNjQgKG9yIGFueSBvdGhlciBTb0Nz
IGxhdGVyIHRoYW4gc3VuNmkpLiBTbyB3ZSBuZWVkCj4gPiA+IHNvbWVvbmUgd2l0aCBhbiBBMTBz
L0ExMyBkZXZpY2UgdGhhdCBoYXMgSVIgdG8gdGVzdCBpdCBhbmQgc2VlIGlmCj4gPiA+IHRoZSBk
cml2ZXIgb3IgdGhlIG1hbnVhbCBpcyB3cm9uZywgYW5kIHdlJ2QgbGlrZWx5IGFkZCBhIGNvbXBh
dGlibGUKPiA+ID4gZm9yIHRoZSBBMjAuCj4gPiA+IAo+ID4gPiBBbHNvLCB0aGUgZWFybGllciBT
b0NzIChBMTAvc3VuNWkvQTIwKSBoYXZlIElSIFRYIGNhcGFiaWxpdHkuIFRoaXMKPiA+ID4gd2Fz
IGxvc3QgaW4gQTMxLCBhbmQgYWxzbyBhbGwgb2Ygc3VuOGkgLyBzdW41MGkuIFNvIHdlJ3JlIGdv
aW5nIHRvCj4gPiA+IG5lZWQgdG8gYWRkIGFuIEEzMSBjb21wYXRpYmxlIHRoYXQgYWxsIGxhdGVy
IHBsYXRmb3JtcyB3b3VsZCBuZWVkCj4gPiA+IHRvIHN3aXRjaCB0by4KPiA+IAo+ID4gSDYgaGFz
IElSIFRYIHBlcmlwaGVyYWwgdG9vLCBidXQgaXQncyBkaWZmZXJlbnQgSVAgYmxvY2suLi4KPiA+
IAo+ID4gRG8geW91IHdhbnQgbWUgdG8gc3dpdGNoIGFsbCBBMzEgYW5kIG5ld2VyIHRvIGRpZmZl
cmVudCBjb21wYXRpYmxlIGluIHRoaXMKPiA+IHNlcmllcz8gSSBjYW4gZG8gdGhpcywgYnV0IEkg
aGF2ZW4ndCBhbnkgQTEzIGRldmljZSB0byB0ZXN0IGlmIHRoaXMgaXMKPiA+IHJlYWxseSBuZWVk
ZWQuIE9yIHlvdSBjYW4gYXJndWUgdGhhdCB0aGlzIGlzIG5lZWRlZCBhbnl3YXkgZHVlIHRvIG1p
c3NpbmcKPiA+IFRYIGNhcGFiaWxpdHkuCj4gCj4gVGhlIGxhY2sgb2YgVFggY2FwYWJpbGl0eSBk
b2VzIG5lY2Vzc2l0YXRlIHN3aXRjaGluZyB0byBhbiBBMzEgY29tcGF0aWJsZS4KPiBTbyB5ZXMs
IHBsZWFzZSBzd2l0Y2guIExldHMgbGVhdmUgdGhlIEExMHMvQTEzIGFsb25lIGZvciBub3csIHVu
bGVzcwo+IHNvbWVvbmUgY29tcGxhaW5zLiBJIHRoaW5rIHRoaXMgd2FzIGRvbmUgZnJvbSBpbmNl
cHRpb24sIHNvIGlmIGl0IHdhcwo+IGJyb2tlbiwgc29tZW9uZSBzaG91bGQndmUgY29tcGxhaW5l
ZCBhIGxvbmcgdGltZSBhZ28uIEkganVzdCB3YW50IHRvCj4gYmUgc3VyZSB3aGVyZSB0aGUgZXJy
b3IgaXMsIGFuZCBwdXQgaW4gYSBjb21tZW50IGV4cGxhaW5pbmcgaXQuIEhvd2V2ZXIKPiBJIGRv
bid0IGhhdmUgdGhlIGhhcmR3YXJlIGVpdGhlci4KCkhvdyBkbyB5b3Ugd2FudCBtZSB0byBzcGxp
dCBwYXRjaGVzPyBJIHByb3Bvc2UgZm9sbG93aW5nOgoxLiBvbmUgcGF0Y2ggdG8gYWRkIGFsbCBj
b21wYXRpYmxlcyB0byBEVCBiaW5kaW5nIGRvY3VtZW50YXRpb24KMi4gb25lIHBhdGNoIHRvIGFk
ZCBBMzEgY29tcGF0aWJsZSB0byBkcml2ZXIKMy4gb25lIHBhdGNoIGZvciBhbGwgMzIgYml0IFNv
Q3MgRFQgY2hhbmdlcwo0LiBvbmUgcGF0Y2ggdG8gYWRkIEE2NCBjb21wYXRpYmxlCjUuIG9uZSBw
YXRjaCB0byBlbmFibGUgT3JhbmdlUGkgV2luIElSIG5vZGUKCkkgZG9uJ3QgdGhpbmsgaXQncyBz
ZW5zaWJsZSB0byBoYXZlIG11bHRpcGxlIHBhdGNoZXMgKG9uZSBwZXIgU29DKSBmb3Igc3RlcCAx
IAphbmQgMy4KCkJlc3QgcmVnYXJkcywKSmVybmVqCgoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cmxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK

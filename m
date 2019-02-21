Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B52AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:46:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2943C20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NCLb+Pyg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2943C20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pkylZPo58tMmcpN4gOlHcAYly6/vFEpCPqS6b+XkLWs=; b=NCLb+PygYbvdp8
	NtPyNW+13DwVQ+YXBXDVJc2SLyS5rsqefJbYAnluv8W1mITqtueEaHwGsQls6ZrKCvx+0RWKXRfGC
	JeL5Zt5yl5mQa62lbM/B8Q6++Aju/s36Nacqx1p81d8+5/OYNLaGDRNBA4lATxRn39iyJP5rOI03D
	YvAh+G18cgu4JVHMlJ2nZYdBJLZ/hd/wSXUa/x5UbjKJ+9CpsvFk0TF4WVkZ2R5xPNdimWe4glh+s
	MBD0CzG6t1qcp1POgtjE8EMMrp51+Ly6iftuYRyiOt1K8VDWCc1h7XKgYh6MUo5Hx12eelpt3GqNK
	sX76P0hXqBHkwUY7lXkQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwmoV-0003oT-7r; Thu, 21 Feb 2019 11:46:51 +0000
Received: from relay7-d.mail.gandi.net ([217.70.183.200])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwmoQ-0003kI-Cn; Thu, 21 Feb 2019 11:46:48 +0000
X-Originating-IP: 90.88.23.190
Received: from xps13 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr
 [90.88.23.190]) (Authenticated sender: miquel.raynal@bootlin.com)
 by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 1908020005;
 Thu, 21 Feb 2019 11:46:28 +0000 (UTC)
Date: Thu, 21 Feb 2019 12:46:28 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [RFC PATCH 02/27] mtd: nand: Compile in the NAND core by default
Message-ID: <20190221124628.3538ecb0@xps13>
In-Reply-To: <20190221121437.7c551bc5@kernel.org>
References: <20190221100216.25255-1-miquel.raynal@bootlin.com>
 <20190221100216.25255-3-miquel.raynal@bootlin.com>
 <20190221115554.315fbd9b@kernel.org>
 <20190221120610.5abb49ae@xps13>
 <20190221121437.7c551bc5@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_034646_812254_9E5F7E46 
X-CRM114-Status: GOOD (  24.34  )
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
Cc: Mason Yang <masonccyang@mxic.com.tw>, Vignesh R <vigneshr@ti.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>, Julien Su <juliensu@mxic.com.tw>,
 Richard Weinberger <richard@nod.at>,
 Schrempf Frieder <frieder.schrempf@kontron.de>,
 Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQm9yaXMsCgpCb3JpcyBCcmV6aWxsb24gPGJicmV6aWxsb25Aa2VybmVsLm9yZz4gd3JvdGUg
b24gVGh1LCAyMSBGZWIgMjAxOQoxMjoxNDozNyArMDEwMDoKCj4gT24gVGh1LCAyMSBGZWIgMjAx
OSAxMjowNjoxMCArMDEwMAo+IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5j
b20+IHdyb3RlOgo+IAo+ID4gSGkgQm9yaXMsCj4gPiAKPiA+IEJvcmlzIEJyZXppbGxvbiA8YmJy
ZXppbGxvbkBrZXJuZWwub3JnPiB3cm90ZSBvbiBUaHUsIDIxIEZlYiAyMDE5Cj4gPiAxMTo1NTo1
NCArMDEwMDoKPiA+ICAgCj4gPiA+IE9uIFRodSwgMjEgRmViIDIwMTkgMTE6MDE6NTEgKzAxMDAK
PiA+ID4gTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4gd3JvdGU6Cj4g
PiA+ICAgICAKPiA+ID4gPiBGb3JjZSB0aGUgTkFORCBjb3JlIGJlIGNvbXBpbGVkLWluIHdoZW4g
dXNpbmcgYW55IGtpbmQgb2YgTkFORC4gICAgICAKPiA+ID4gCj4gPiA+IFdoeT8gICAgCj4gPiAK
PiA+IEJlY2F1c2UgYWxsIHRoZSBsb2dpYyB0aGF0IGNvbWVzIGxhdGVyIGluIHRoZSBzZXJpZXMg
cmVsaWVzIG9uIHRoaXMKPiA+IGNoYW5nZS4gSSBuZWVkIHRoZSBOQU5EIGNvcmUgdG8gYmUgY29t
cGlsZWQtaW4sICAKPiAKPiBIbSwgbm90IGV4YWN0bHkgY29tcGlsZWQtaW4gYXMgaXQgY2FuIHN0
aWxsIGJlIHNlbGVjdGVkIGFzIGEgbW9kdWxlLgoKWWVzLCBkbyB5b3UgdGhpbmsgaXQgaXMgYSBw
cm9ibGVtPwoKPiAKPiA+IGFzIHdlbGwgdGhlIEVDQyBlbmdpbmUKPiA+IGNvcmUsIGFzIHdlbGwg
YXMgZXZlcnl0aGluZyB0aGF0IGlzIHNoYXJlZCBiZXR3ZWVuIHJhdyBOQU5EIGFuZAo+ID4gU1BJ
LU5BTkQgd2hpY2ggSSBtb3ZlIGluIHRoZSBOQU5EIGNvcmUuICAKPiAKPiBZZXMsIHRoZSBjb3Jl
IGlzIHJlcXVpcmVkIGZvciBTUEkgTkFORCBhbmQgc29vbiB3aWxsIGJlIGZvciBSQVcgTkFORCwK
PiBidXQgSSBzdGlsbCBkb24ndCBzZWUgdGhlIHByb2JsZW0gd2l0aCB0aGUgInNlbGVjdCBOQU5E
X0NPUkUiIGFwcHJvYWNoLAo+IHNvcnJ5Lgo+IAo+ID4gICAKPiA+ID4gICAgIAo+ID4gPiA+IAo+
ID4gPiA+IEFsc28gcmVtb3ZlIHRoZSByZWR1bmRhbnQgZGVwZW5kZW5jaWVzIG9uIE1URCB3aGlj
aCBpcyBlbmZvcmNlZCBieSB0aGUKPiA+ID4gPiBnYW1lIG9mIHRoZSBpZi9lbmRpZiBibG9jcy4K
PiA+ID4gPiAKPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5
bmFsQGJvb3RsaW4uY29tPgo+ID4gPiA+IC0tLQo+ID4gPiA+ICBkcml2ZXJzL210ZC9uYW5kL0tj
b25maWcgICAgICAgICB8IDEyICsrKysrKysrKystLQo+ID4gPiA+ICBkcml2ZXJzL210ZC9uYW5k
L29uZW5hbmQvS2NvbmZpZyB8ICAxIC0KPiA+ID4gPiAgZHJpdmVycy9tdGQvbmFuZC9yYXcvS2Nv
bmZpZyAgICAgfCAgMSAtCj4gPiA+ID4gIGRyaXZlcnMvbXRkL25hbmQvc3BpL0tjb25maWcgICAg
IHwgIDEgLQo+ID4gPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDUgZGVs
ZXRpb25zKC0pCj4gPiA+ID4gCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL25hbmQv
S2NvbmZpZyBiL2RyaXZlcnMvbXRkL25hbmQvS2NvbmZpZwo+ID4gPiA+IGluZGV4IDQ5NTc1MWVk
M2ZkNy4uZThkMjZhNzE1OTIyIDEwMDY0NAo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvbXRkL25hbmQv
S2NvbmZpZwo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbXRkL25hbmQvS2NvbmZpZwo+ID4gPiA+IEBA
IC0xLDYgKzEsMTQgQEAKPiA+ID4gPiAtY29uZmlnIE1URF9OQU5EX0NPUkUKPiA+ID4gPiAtCXRy
aXN0YXRlCj4gPiA+ID4gK21lbnVjb25maWcgTVREX05BTkRfQ09SRQo+ID4gPiA+ICsJdHJpc3Rh
dGUgIk5BTkQiICAgICAgCj4gPiA+IAo+ID4gPiBEZWZpbml0ZWx5IG5vdCBzb21ldGhpbmcgd2Ug
d2FudCB0byBleHBvc2UgaW4gbWVudWNvbmZpZy4gICAgCj4gPiAKPiA+IEkgY29uc2lkZXJlZCB0
aGUgTkFORCBjb3JlIGFzIGVzc2VudGlhbCB3aGVuIHVzaW5nIHJhdyBOQU5EIGFuZAo+ID4gU1BJ
LU5BTkQuICAKPiAKPiBJdCBpcyBuZWVkZWQgZm9yIFNQSSBOQU5ELCBhbmQgd2lsbCBiZSBmb3Ig
cmF3IE5BTkQgZm9yIHN1cmUsIGJ1dCBJCj4gc3RpbGwgc2VlIG5vIHJlYXNvbnMgZm9yIHR1cm5p
bmcgaXQgaW50byBhIHVzZXItdmlzaWJsZSBvcHRpb24uCj4gCj4gPiBIZW5jZSwgdHVybmluZyBp
dCBpbnRvIGEgbWVudWNvbmZpZyBvcHRpb24gbWFrZSB0aGUgd2hvbGUKPiA+IE5BTkQgc3Vic3lz
dGVtIGF2YWlsYWJsZSAob3Igbm90KSBhbmQgd2lsbCBhcHBlYXIgaW4gYSBkaWZmZXJlbnQKPiA+
ICJtZW51Y29uZmlnIHBhZ2UiLCB3aGljaCByZWFsbHkgZW5oYW5jZXMgdGhlIHJlYWRhYmlsaXR5
LiAgCj4gCj4gVGhhdCdzIGEgZGlmZmVyZW50IHRoaW5nLCBhbmQgSSBoYXZlIG5vIHByb2JsZW0g
d2l0aCBhZGRpbmcgYW4gZXh0cmEKPiBsZXZlbCBpbiB0aGUgS2NvbmZpZyBoaWVyYXJjaHkuCgpU
aGVuIHdoeSBub3QgdXNpbmcgdGhpcyBzeW1ib2w/IEkgZG9uJ3QgZ2V0IHdoeSB5b3UgYXJlIG9w
cG9zZWQuCgpTbyB5b3Ugd291bGQgbGlrZSBhIGNvbmZpZyBOQU5EX0NPUkUgKGludmlzaWJsZSkg
YW5kIGEgdmlzaWJsZQptZW51Y29uZmlnIE5BTkQ/IEFuZCBhbGwgZW50cmllcyBpbiB0aGUgTkFO
RCBtZW51IHNlbGVjdGluZyBOQU5EX0NPUkU/Cgo+IAo+ID4gICAKPiA+ID4gICAgIAo+ID4gPiA+
ICsJZGVmYXVsdCB5ICAgICAgCj4gPiA+IAo+ID4gPiBJIGRvbid0IHNlZSB3aGF0J3MgdGhlIHBy
b2JsZW0gd2l0aCBsZXR0aW5nIFNQSU5BTkQsIFJBV05BTkQgYW5kCj4gPiA+IE9ORU5BTkQgc2Vs
ZWN0IHRoaXMgb3B0aW9ucyBpZiB0aGV5IGFjdHVhbGx5IG5lZWQgaXQuICAgIAo+ID4gCj4gPiBT
ZWUgdGhlIHJlYXNvbiBhYm92ZSwgaGVuY2UgaGF2aW5nIGl0ICJkZWZhdWx0IHkiIGlzIG5lZWRl
ZCB0byBkbyBub3QKPiA+IGJyZWFrIGV4aXN0aW5nIGRlZmNvbmZpZ3MuICAKPiAKPiBOb3QgaWYg
eW91IG1ha2UgUkFXX05BTkQgc2VsZWN0IE5BTkRfQ09SRS4KCgpUaGFua3MsCk1pcXXDqGwKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1r
ZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJu
ZWwK

Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32565C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:53:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEB8520855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OuiSH3/W";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bqy4qLIA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB8520855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QyTega6jsPY3Mim7jaVVqjmICwbR/LVYVUPQy/AtW7I=; b=OuiSH3/WoCj8rn
	X04UcFC7D4zpW5OpH+9edqQpfk3Bq70IxivXsgKpYei9o6r5tdI7ktW45KwdksgaVI0LFYB7h4UMZ
	HvFKWVSyEybwKwsItSyGUDajIMQwxcPstxCofB2v981epYY+VwLUelt0LPxqV2NvK9RoANOSupy0J
	qcxaYqH2rkXo64W9lrI12s7DJjwOJePK8+rlE+lE/my5CLysWNijVEMA0GEHpgdx8ucZrqHvffqbW
	Civ3TGoigfH+QWIrbAEQirCYyW4ze5ejdvxBcH9/GcHNXDiyVVxSqLn/za9+FAfykkA3/pMUj7jnU
	PTqgrQLrNwIBx9dyhCfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwnqe-0000KP-DW; Thu, 21 Feb 2019 12:53:08 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwnqc-0000Js-7T; Thu, 21 Feb 2019 12:53:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PZYk1BwV28OKA6O+Z4M7COC6pdDJ0/A4MyhlP6e5tHE=; b=bqy4qLIAnhMEX6JUN0EdjlTv+O
 8uNv2wHISrFIBucoOzVV7QTArXunluessRFFfMUOLX5a2n+z0ga5jQ0bGqwXZNfv3W1tNfY96V7+e
 ZInFKGXsKHGHvPStLoJZq6/AHNa8UQ4aG14Rof3fvuTTzzLC/N0QpxZgEDfo3DjjYGNw7ZSDVar6X
 FqMEBGWUNBX8JBbTZ/pZuEa0/Q1e/piKbY8LOidxqFl3s/oqm/foZahnrw6lGOfxKUBgDS4FftV6J
 fq0jWpZ0pjdUGAB4oxcFEZsgz//7blHDMz5uqlpywGe/cj536FlP1wraAMyOdx5uZk6s4NqO+ZTwE
 UVxn7pig==;
Received: from relay10.mail.gandi.net ([217.70.178.230])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwnqZ-00006N-2t; Thu, 21 Feb 2019 12:53:04 +0000
Received: from xps13 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr
 [90.88.23.190]) (Authenticated sender: miquel.raynal@bootlin.com)
 by relay10.mail.gandi.net (Postfix) with ESMTPSA id 44F47240013;
 Thu, 21 Feb 2019 12:52:28 +0000 (UTC)
Date: Thu, 21 Feb 2019 13:52:27 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [RFC PATCH 02/27] mtd: nand: Compile in the NAND core by default
Message-ID: <20190221135227.48cbeb2d@xps13>
In-Reply-To: <20190221130815.7bd550dd@kernel.org>
References: <20190221100216.25255-1-miquel.raynal@bootlin.com>
 <20190221100216.25255-3-miquel.raynal@bootlin.com>
 <20190221115554.315fbd9b@kernel.org>
 <20190221120610.5abb49ae@xps13>
 <20190221121437.7c551bc5@kernel.org>
 <20190221124628.3538ecb0@xps13>
 <20190221130815.7bd550dd@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_125303_200619_3807B196 
X-CRM114-Status: GOOD (  42.24  )
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
b24gVGh1LCAyMSBGZWIgMjAxOQoxMzowODoxNSArMDEwMDoKCj4gT24gVGh1LCAyMSBGZWIgMjAx
OSAxMjo0NjoyOCArMDEwMAo+IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5j
b20+IHdyb3RlOgo+IAo+ID4gSGkgQm9yaXMsCj4gPiAKPiA+IEJvcmlzIEJyZXppbGxvbiA8YmJy
ZXppbGxvbkBrZXJuZWwub3JnPiB3cm90ZSBvbiBUaHUsIDIxIEZlYiAyMDE5Cj4gPiAxMjoxNDoz
NyArMDEwMDoKPiA+ICAgCj4gPiA+IE9uIFRodSwgMjEgRmViIDIwMTkgMTI6MDY6MTAgKzAxMDAK
PiA+ID4gTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4gd3JvdGU6Cj4g
PiA+ICAgICAKPiA+ID4gPiBIaSBCb3JpcywKPiA+ID4gPiAKPiA+ID4gPiBCb3JpcyBCcmV6aWxs
b24gPGJicmV6aWxsb25Aa2VybmVsLm9yZz4gd3JvdGUgb24gVGh1LCAyMSBGZWIgMjAxOQo+ID4g
PiA+IDExOjU1OjU0ICswMTAwOgo+ID4gPiA+ICAgICAgIAo+ID4gPiA+ID4gT24gVGh1LCAyMSBG
ZWIgMjAxOSAxMTowMTo1MSArMDEwMAo+ID4gPiA+ID4gTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJh
eW5hbEBib290bGluLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiAgICAgICAgIAo+ID4gPiA+ID4gPiBG
b3JjZSB0aGUgTkFORCBjb3JlIGJlIGNvbXBpbGVkLWluIHdoZW4gdXNpbmcgYW55IGtpbmQgb2Yg
TkFORC4gICAgICAgICAgCj4gPiA+ID4gPiAKPiA+ID4gPiA+IFdoeT8gICAgICAgIAo+ID4gPiA+
IAo+ID4gPiA+IEJlY2F1c2UgYWxsIHRoZSBsb2dpYyB0aGF0IGNvbWVzIGxhdGVyIGluIHRoZSBz
ZXJpZXMgcmVsaWVzIG9uIHRoaXMKPiA+ID4gPiBjaGFuZ2UuIEkgbmVlZCB0aGUgTkFORCBjb3Jl
IHRvIGJlIGNvbXBpbGVkLWluLCAgICAgIAo+ID4gPiAKPiA+ID4gSG0sIG5vdCBleGFjdGx5IGNv
bXBpbGVkLWluIGFzIGl0IGNhbiBzdGlsbCBiZSBzZWxlY3RlZCBhcyBhIG1vZHVsZS4gICAgCj4g
PiAKPiA+IFllcywgZG8geW91IHRoaW5rIGl0IGlzIGEgcHJvYmxlbT8gIAo+IAo+IFllcywgaXQg
aXMsIGF0IGxlYXN0IGZvciB0aGUgU1BJIE5BTkQgY2FzZSAoYW5kIHNvb24gdGhlIFJBVyBOQU5E
IGNhc2UKPiB0b28pIHNpbmNlIHlvdSByZW1vdmUgdGhlIHNlbGVjdCBidXQgZG9uJ3QgYWRkIGEg
ZGVwZW5kcyBvbi4gSWYgeW91Cj4gc2VsZWN0IE5BTkRfQ09SRSBhcyBhIG1vZHVsZSBhbmQgU1BJ
X05BTkQgY29tcGlsZWQtaW4gPT4gQk9PTSEKCkkgYW0gbm90IGVudGlyZWx5IHN1cmUgYnV0IEkg
dGhpbmsgU1BJIE5BTkQgY2Fubm90IGJlIGNvbXBpbGVkLWluIGlmIGl0CmlzICJ1bmRlciIgYSBt
ZW51IHRoYXQgaGFzIGJlZW4gc2VsZWN0ZWQgYXMgYSBtb2R1bGUuIEJ1dCBhbnl3YXksIGl0J3MK
anVzdCBhIG1hdHRlciBvZiBzZWVpbmcgdGhpbmdzLCBhbmQgdGhlIG9uZW5hbmQgYXJndW1lbnQg
aXMgdmFsaWQgdG8KbWUuIEkgd2lsbCBjaGFuZ2UgaXQgdG8gdGhlIGJlbG93IHByb3Bvc2FsIHlv
dSBhY2NlcHRlZC4KCj4gCj4gPiAgIAo+ID4gPiAgICAgCj4gPiA+ID4gYXMgd2VsbCB0aGUgRUND
IGVuZ2luZQo+ID4gPiA+IGNvcmUsIGFzIHdlbGwgYXMgZXZlcnl0aGluZyB0aGF0IGlzIHNoYXJl
ZCBiZXR3ZWVuIHJhdyBOQU5EIGFuZAo+ID4gPiA+IFNQSS1OQU5EIHdoaWNoIEkgbW92ZSBpbiB0
aGUgTkFORCBjb3JlLiAgICAgIAo+ID4gPiAKPiA+ID4gWWVzLCB0aGUgY29yZSBpcyByZXF1aXJl
ZCBmb3IgU1BJIE5BTkQgYW5kIHNvb24gd2lsbCBiZSBmb3IgUkFXIE5BTkQsCj4gPiA+IGJ1dCBJ
IHN0aWxsIGRvbid0IHNlZSB0aGUgcHJvYmxlbSB3aXRoIHRoZSAic2VsZWN0IE5BTkRfQ09SRSIg
YXBwcm9hY2gsCj4gPiA+IHNvcnJ5Lgo+ID4gPiAgICAgCj4gPiA+ID4gICAgICAgCj4gPiA+ID4g
PiAgICAgICAgIAo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gQWxzbyByZW1vdmUgdGhlIHJlZHVu
ZGFudCBkZXBlbmRlbmNpZXMgb24gTVREIHdoaWNoIGlzIGVuZm9yY2VkIGJ5IHRoZQo+ID4gPiA+
ID4gPiBnYW1lIG9mIHRoZSBpZi9lbmRpZiBibG9jcy4KPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+
IFNpZ25lZC1vZmYtYnk6IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+
Cj4gPiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4gPiAgZHJpdmVycy9tdGQvbmFuZC9LY29uZmlnICAg
ICAgICAgfCAxMiArKysrKysrKysrLS0KPiA+ID4gPiA+ID4gIGRyaXZlcnMvbXRkL25hbmQvb25l
bmFuZC9LY29uZmlnIHwgIDEgLQo+ID4gPiA+ID4gPiAgZHJpdmVycy9tdGQvbmFuZC9yYXcvS2Nv
bmZpZyAgICAgfCAgMSAtCj4gPiA+ID4gPiA+ICBkcml2ZXJzL210ZC9uYW5kL3NwaS9LY29uZmln
ICAgICB8ICAxIC0KPiA+ID4gPiA+ID4gIDQgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygr
KSwgNSBkZWxldGlvbnMoLSkKPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL210ZC9uYW5kL0tjb25maWcgYi9kcml2ZXJzL210ZC9uYW5kL0tjb25maWcKPiA+ID4g
PiA+ID4gaW5kZXggNDk1NzUxZWQzZmQ3Li5lOGQyNmE3MTU5MjIgMTAwNjQ0Cj4gPiA+ID4gPiA+
IC0tLSBhL2RyaXZlcnMvbXRkL25hbmQvS2NvbmZpZwo+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJz
L210ZC9uYW5kL0tjb25maWcKPiA+ID4gPiA+ID4gQEAgLTEsNiArMSwxNCBAQAo+ID4gPiA+ID4g
PiAtY29uZmlnIE1URF9OQU5EX0NPUkUKPiA+ID4gPiA+ID4gLQl0cmlzdGF0ZQo+ID4gPiA+ID4g
PiArbWVudWNvbmZpZyBNVERfTkFORF9DT1JFCj4gPiA+ID4gPiA+ICsJdHJpc3RhdGUgIk5BTkQi
ICAgICAgICAgIAo+ID4gPiA+ID4gCj4gPiA+ID4gPiBEZWZpbml0ZWx5IG5vdCBzb21ldGhpbmcg
d2Ugd2FudCB0byBleHBvc2UgaW4gbWVudWNvbmZpZy4gICAgICAgIAo+ID4gPiA+IAo+ID4gPiA+
IEkgY29uc2lkZXJlZCB0aGUgTkFORCBjb3JlIGFzIGVzc2VudGlhbCB3aGVuIHVzaW5nIHJhdyBO
QU5EIGFuZAo+ID4gPiA+IFNQSS1OQU5ELiAgICAgIAo+ID4gPiAKPiA+ID4gSXQgaXMgbmVlZGVk
IGZvciBTUEkgTkFORCwgYW5kIHdpbGwgYmUgZm9yIHJhdyBOQU5EIGZvciBzdXJlLCBidXQgSQo+
ID4gPiBzdGlsbCBzZWUgbm8gcmVhc29ucyBmb3IgdHVybmluZyBpdCBpbnRvIGEgdXNlci12aXNp
YmxlIG9wdGlvbi4KPiA+ID4gICAgIAo+ID4gPiA+IEhlbmNlLCB0dXJuaW5nIGl0IGludG8gYSBt
ZW51Y29uZmlnIG9wdGlvbiBtYWtlIHRoZSB3aG9sZQo+ID4gPiA+IE5BTkQgc3Vic3lzdGVtIGF2
YWlsYWJsZSAob3Igbm90KSBhbmQgd2lsbCBhcHBlYXIgaW4gYSBkaWZmZXJlbnQKPiA+ID4gPiAi
bWVudWNvbmZpZyBwYWdlIiwgd2hpY2ggcmVhbGx5IGVuaGFuY2VzIHRoZSByZWFkYWJpbGl0eS4g
ICAgICAKPiA+ID4gCj4gPiA+IFRoYXQncyBhIGRpZmZlcmVudCB0aGluZywgYW5kIEkgaGF2ZSBu
byBwcm9ibGVtIHdpdGggYWRkaW5nIGFuIGV4dHJhCj4gPiA+IGxldmVsIGluIHRoZSBLY29uZmln
IGhpZXJhcmNoeS4gICAgCj4gPiAKPiA+IFRoZW4gd2h5IG5vdCB1c2luZyB0aGlzIHN5bWJvbD8g
SSBkb24ndCBnZXQgd2h5IHlvdSBhcmUgb3Bwb3NlZC4gIAo+IAo+IEJlY2F1c2UsIG5vdCBvbmx5
IHlvdSdyZSBmb3JjaW5nIG9uZW5hbmQgdXNlcnMgdG8gcHVsbCB0aGUgbmFuZCBjb3JlCj4gY29k
ZSBpbiwgd2hpY2ggaXMgbm90IG5lZWRlZCB1bnRpbCB0aGUgY29udmVyc2lvbiB0byB0aGUgZ2Vu
ZXJpYyBOQU5ECj4gbGF5ZXIgaXMgZG9uZSwgYnV0IHlvdSdyZSBhY3R1YWxseSBmb3JjaW5nIHRo
YXQgZm9yIGFsbCBleGlzdGluZwo+IGRlZmNvbmZpZ3MgYmVjYXVzZSBvZiB5b3VyICJkZWZhdWx0
IHkiIGFwcHJvYWNoLiBBbHNvLCBJIGRvbid0IHNlZQo+IHdoYXQncyB0aGUgYmVuZWZpdCBvZiBs
ZXR0aW5nIHVzZXJzIGtub3cgYWJvdXQgdGhpcyBpbnRlcm1lZGlhdGUKPiBmcmFtZXdvcmsgd2hl
biBhbGwgdGhleSBjYXJlIGFib3V0IGlzIHN1cHBvcnRpbmcgYSBzcGVjaWZpYyBjbGFzcyBvZgo+
IGRldmljZXMuCj4gCj4gPiAKPiA+IFNvIHlvdSB3b3VsZCBsaWtlIGEgY29uZmlnIE5BTkRfQ09S
RSAoaW52aXNpYmxlKSBhbmQgYSB2aXNpYmxlCj4gPiBtZW51Y29uZmlnIE5BTkQ/IEFuZCBhbGwg
ZW50cmllcyBpbiB0aGUgTkFORCBtZW51IHNlbGVjdGluZyBOQU5EX0NPUkU/ICAKPiAKPiBOb3Qg
YWxsIGVudHJpZXMsIGp1c3QgU1BJIE5BTkQsIGFuZCBzb29uLCByYXcgTkFORC4gQW5kIHllcywg
SSdkIHByZWZlcgo+IHRoYXQuCgoKVGhhbmtzLApNaXF1w6hsCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==

Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BDEC282F6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:24:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1308721726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="chgGXBWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1308721726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Qdw+8RpJ6cCe4o0nPoc9DvwZio++vNRfJhLGgPri05A=; b=chgGXBWh/V6ek8
	HvyER3xvxeAkU03ByosRXWca9RWk4nGO+949nBD65BRRbA6FBJreieRBe03dqDFB1cuFsuidT/GJ+
	tyPZQjSHo9IiRdpW4KCs1A4iRlNBvCsq0FT8BnrO/jrTKsyfXXp3NhHtDQ5hAkRx4JfB8O7SvhPe1
	8fpSWW1k8Q18UK8b3Igz/Cr2gDYfZm3aO1cLNJLSke43B6I13Em95rJBdMZ+OSVdycEVqMKe3P0rm
	zntUZPFZNVUmLXsGhtYELIn7TGJVrsETYXT+7ieF14U/WBFJVNNFyHMefNDawlInSTO29WwNbS/bc
	WdxGmrE4LRX9WB+XaFCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glWkl-0005ok-HV; Mon, 21 Jan 2019 10:24:27 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glWki-0005oB-Fr
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 10:24:26 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 79F4B207B2; Mon, 21 Jan 2019 11:24:22 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr
 [90.88.156.87])
 by mail.bootlin.com (Postfix) with ESMTPSA id ECDB2206A7;
 Mon, 21 Jan 2019 11:24:11 +0100 (CET)
Date: Mon, 21 Jan 2019 11:24:12 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH v2 05/10] phy: add A3700 UTMI PHY driver
Message-ID: <20190121112412.24d5c64a@xps13>
In-Reply-To: <87zhrxly7f.fsf@FE-laptop>
References: <20190111133133.24803-1-miquel.raynal@bootlin.com>
 <20190111133133.24803-6-miquel.raynal@bootlin.com>
 <87zhrxly7f.fsf@FE-laptop>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_022424_802833_01D1B935 
X-CRM114-Status: GOOD (  21.18  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, Mathias Nyman <mathias.nyman@intel.com>,
 devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 Kishon Vijay Abraham I <kishon@ti.com>, Nadav Haklai <nadavh@marvell.com>,
 Rob Herring <robh+dt@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 Igal Liberman <igall@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgR3JlZ29yeSwKCkdyZWdvcnkgQ0xFTUVOVCA8Z3JlZ29yeS5jbGVtZW50QGJvb3RsaW4uY29t
PiB3cm90ZSBvbiBGcmksIDE4IEphbiAyMDE5CjE3OjM2OjM2ICswMTAwOgoKPiBIaSBNaXF1ZWws
Cj4gCj4gSSBoYXZlIG9ubHkgYSBmZXcgc21hbGxpc2ggcmVtYXJrczoKPiAKPiAgT24gdmVuLiwg
amFudi4gMTEgMjAxOSwgTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4g
d3JvdGU6Cj4gCj4gPiBNYXJ2ZWxsIEFybWFkYSAzNzAwIFNvQyBoYXMgdHdvIFVTQiBjb250cm9s
bGVycywgZWFjaCBvZiB0aGVtIGJlaW5nCj4gPiB3aXJlZCB0byBhbiBpbnRlcm5hbCBVVE1JIFBI
WS4gQWRkIGEgZHJpdmVyIHRvIGNvbnRyb2wgdGhlbS4KPiA+Cj4gPiBJZ2FsIExpYmVybWFuIHdv
cmtlZCBvbiBzdXBwb3J0aW5nIHRoZSBQSFksIEkgdG9vayB0aGUgd2hpbGUgJ3JlZ2lzdGVyCj4g
PiBjb25maWd1cmF0aW9uJyBmcm9tIGhpcyB3b3JrIGFuZCByZXdyb3RlIGFsbW9zdCBlbnRpcmVs
eSB0aGUKPiA+IGRyaXZlci9iaW5kaW5ncyBhcm91bmQgaXQuCj4gPgo+ID4gQ28tZGV2ZWxvcGVk
LWJ5OiBJZ2FsIExpYmVybWFuIDxpZ2FsbEBtYXJ2ZWxsLmNvbT4KPiA+IFNpZ25lZC1vZmYtYnk6
IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+Cj4gPiBTaWduZWQtb2Zm
LWJ5OiBJZ2FsIExpYmVybWFuIDxpZ2FsbEBtYXJ2ZWxsLmNvbT4KPiA+IC0tLSAgCj4gWy4uLl0K
PiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS9tYXJ2ZWxsL3BoeS1tdmVidS1hMzcwMC11
dG1pLmMgYi9kcml2ZXJzL3BoeS9tYXJ2ZWxsL3BoeS1tdmVidS1hMzcwMC11dG1pLmMKPiA+IG5l
dyBmaWxlIG1vZGUgMTAwNjQ0Cj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjk3ZDgyMzVkNjYxZAo+
ID4gLS0tIC9kZXYvbnVsbAo+ID4gKysrIGIvZHJpdmVycy9waHkvbWFydmVsbC9waHktbXZlYnUt
YTM3MDAtdXRtaS5jCj4gPiBAQCAtMCwwICsxLDI5NyBAQAo+ID4gKy8vIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiBHUEwtMi4wCj4gPiArLyoKPiA+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMTggTWFy
dmVsbAo+ID4gKyAqCj4gPiArICogQXV0aG9yczoKPiA+ICsgKiAgIEV2YW4gV2FuZyA8eHN3YW5n
QG1hcnZlbGwuY29tPgo+ID4gKyAqICAgTWlxdcOobCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9v
dGxpbi5jb20+ICAKPiAKPiBJZiBpdCBpcyBjby1kZXZlbG9wZWQgd2l0aCBJZ2FsIExpYmVybWFu
LCBzaG91bGRuJ3QgYmUgYWRkZWQgaGVyZSB0b28/CgpJbiB0aGUgb3JpZ2luYWwgcGF0Y2gsIHRo
ZSBhdXRob3IgaW4gdGhlIGNvbW1pdCBsb2cgd2FzIElnYWwgYW5kIHRoZQpNT0RVTEVfQVVUSE9S
IG1hY3JvIHdhcyBzYXlpbmcgRXZhbi4gSSB0aGluayB0aGUgbWFjcm8gaXMgd3JvbmcsIEkgd2ls
bAprZWVwIElnYWwuCgo+IFsuLi5dCj4gCj4gPiArc3RhdGljIGludCBtdmVidV9hMzcwMF91dG1p
X3BoeV9wb3dlcl9vbihzdHJ1Y3QgcGh5ICpwaHkpCj4gPiArewo+ID4gKwlzdHJ1Y3QgbXZlYnVf
YTM3MDBfdXRtaSAqdXRtaSA9IHBoeV9nZXRfZHJ2ZGF0YShwaHkpOwo+ID4gKwlzdHJ1Y3QgZGV2
aWNlICpkZXYgPSAmcGh5LT5kZXY7Cj4gPiArCWludCB1c2IzMiA9IHV0bWktPmNhcHMtPnVzYjMy
Owo+ID4gKwlpbnQgcmV0ID0gMDsKPiA+ICsJdTMyIHJlZzsKPiA+ICsKPiA+ICsJaWYgKCF1dG1p
KQo+ID4gKwkJcmV0dXJuIC1FTk9ERVY7Cj4gPiArCj4gPiArCS8qCj4gPiArCSAqIFNldHVwIFBM
TC4gNDBNSHogY2xvY2sgdXNlZCB0byBiZSB0aGUgZGVmYXVsdCwgYmVpbiAyNU1IeiBub3cuICAK
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgYmVpbj8KPiA+ICsJICogU2VlICJQTEwgU2V0dGluZ3MgZm9yIFR5cGljYWwgUkVGQ0xLIiB0
YWJsZS4gIAo+IAo+IFsuLi5dCj4gCj4gPiArCj4gPiArCS8qIFdhaXQgZm9yIHNxdWV0Y2ggY2Fs
aWJyYXRpb24gKi8gIAo+ICAgICAgICAgICAgICAgICAgICAgc3F1ZXRjaD8KCkdvb2QgY2F0Y2gu
IEl0J3Mgd3JpdHRlbiAic3F1ZWxjaCIgaW4gdGhlIGRhdGFzaGVldCwgYnV0IEkgZG9uJ3Qga25v
dwp3aGF0IGl0IG1lYW5zIGV4YWN0bHkuCgoKVGhhbmtzLApNaXF1w6hsCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxp
bmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==

Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CD7C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:36:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 984D7218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a09LOhwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984D7218D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vMuDWuHtNWNB03TEdzszHXPpt6m3h34DY5qRt6dx06k=; b=a09LOhwh0OWNq/
	91WyCMuJaZ88g6ogoLeHDWDUEp7O/JXwZ/H+nnxrFZ5mANQNUNBuStV/LM8PLc0WWBmGxFqkuX9+i
	ujvHIdK/sKhPJKpbJajLNF78KgSwqRm2hQHZGCwx9HYbmEuyBS1/ey9jXLlu76lSeXBl5oyS6Oxlq
	JWRRUZYChpI8dtri9bYUS9PT1uPA0CNRMTHhVgvUNl1yaH65TaXh1GyUE0KfbEYGveNz6al7rMByl
	GImQwD1u69OOcbV0KPCNAn23xNbtaYH5GYp2X7j0/1Zg6ioOHClCtJJ4h5J1lehB04C9xrBqJ4cHs
	T27/AELUrHjXLZKjFlew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmyps-0003dt-38; Fri, 25 Jan 2019 10:35:44 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmypo-0003dS-Im
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 10:35:42 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id AB70320798; Fri, 25 Jan 2019 11:35:38 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr
 [90.88.29.206])
 by mail.bootlin.com (Postfix) with ESMTPSA id 3495A206A6;
 Fri, 25 Jan 2019 11:35:38 +0100 (CET)
Date: Fri, 25 Jan 2019 11:35:38 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v3 04/10] usb: ehci-orion: add S2RAM support
Message-ID: <20190125113538.24d5ca02@xps13>
In-Reply-To: <Pine.LNX.4.44L0.1901231456060.1564-100000@iolanthe.rowland.org>
References: <20190121112336.23489-5-miquel.raynal@bootlin.com>
 <Pine.LNX.4.44L0.1901231456060.1564-100000@iolanthe.rowland.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_023540_754159_0931CEBE 
X-CRM114-Status: GOOD (  18.10  )
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Gregory Clement <gregory.clement@bootlin.com>, linux-usb@vger.kernel.org,
 Kishon Vijay Abraham I <kishon@ti.com>, Nadav Haklai <nadavh@marvell.com>,
 Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQWxhbiwKCkFsYW4gU3Rlcm4gPHN0ZXJuQHJvd2xhbmQuaGFydmFyZC5lZHU+IHdyb3RlIG9u
IFdlZCwgMjMgSmFuIDIwMTkKMTQ6NTg6NDQgLTA1MDAgKEVTVCk6Cgo+IE9uIE1vbiwgMjEgSmFu
IDIwMTksIE1pcXVlbCBSYXluYWwgd3JvdGU6Cj4gCj4gPiBBZGQgc3VzcGVuZC9yZXN1bWUgY2Fs
bGJhY2tzIHRvIHJlc2V0IHRoZSBob3N0IGNvbnRyb2xsZXIgcHJvcGVybHkKPiA+IGR1cmluZyBT
MlJBTSBvcGVyYXRpb24uCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IE1pcXVlbCBSYXluYWwgPG1p
cXVlbC5yYXluYWxAYm9vdGxpbi5jb20+Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL3VzYi9ob3N0L2Vo
Y2ktb3Jpb24uYyB8IDI1ICsrKysrKysrKysrKysrKysrKysrKysrKysKPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMjUgaW5zZXJ0aW9ucygrKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2Iv
aG9zdC9laGNpLW9yaW9uLmMgYi9kcml2ZXJzL3VzYi9ob3N0L2VoY2ktb3Jpb24uYwo+ID4gaW5k
ZXggMzEwOWYwODI5NDllLi5kYWIyMmFhNTdjMGIgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3Vz
Yi9ob3N0L2VoY2ktb3Jpb24uYwo+ID4gKysrIGIvZHJpdmVycy91c2IvaG9zdC9laGNpLW9yaW9u
LmMKPiA+IEBAIC0xODIsNiArMTgyLDMwIEBAIHN0YXRpYyBpbnQgZWhjaV9vcmlvbl9kcnZfcmVz
ZXQoc3RydWN0IHVzYl9oY2QgKmhjZCkKPiA+ICAJcmV0dXJuIHJldDsKPiA+ICB9Cj4gPiAgCj4g
PiArc3RhdGljIGludCBfX21heWJlX3VudXNlZCBlaGNpX29yaW9uX2Rydl9zdXNwZW5kKHN0cnVj
dCBkZXZpY2UgKmRldikKPiA+ICt7Cj4gPiArCXN0cnVjdCB1c2JfaGNkICpoY2QgPSBkZXZfZ2V0
X2RydmRhdGEoZGV2KTsKPiA+ICsJc3RydWN0IGVoY2lfaGNkICplaGNpID0gaGNkX3RvX2VoY2ko
aGNkKTsKPiA+ICsKPiA+ICsJZWhjaV9wcmVwYXJlX3BvcnRzX2Zvcl9jb250cm9sbGVyX3N1c3Bl
bmQoZWhjaSwKPiA+ICsJCQkJCQkgIGRldmljZV9tYXlfd2FrZXVwKGRldikpOwo+ID4gKwo+ID4g
KwlyZXR1cm4gZWhjaV9zdXNwZW5kKGhjZCwgZmFsc2UpOyAgCj4gCj4gVGhpcyBpcyBhIGxpdHRs
ZSBvZGQuICBXaHkgbm90IGp1c3QgY2FsbAo+IAo+IAllaGNpX3N1c3BlbmQoaGNkLCBkZXZpY2Vf
bWF5X3dha2V1cChkZXYpKTsKPiAKPiBkaXJlY3RseSBhbmQgbGV0IGl0IHRha2UgY2FyZSBvZiBj
YWxsaW5nCj4gZWhjaV9wcmVwYXJlX3BvcnRzX2Zvcl9jb250cm9sbGVyX3N1c3BlbmQoKSBmb3Ig
eW91PyAgSWYgeW91IGhhdmUgYQo+IGdvb2QgcmVhc29uIGZvciBkb2luZyB0aGluZ3MgdGhpcyB3
YXksIHBsZWFzZSBtZW50aW9uIHRoYXQgcmVhc29uIGluCj4gdGhlIENoYW5nZWxvZy4KClRoZXJl
IGlzIG5vIHJlYXNvbiwgSSB0aGluayBJIGdvdCB0aGUgaW5zcGlyYXRpb24gZnJvbSBhbiBvdGhl
ciBkcml2ZXIKY2FsbGluZyBtYW51YWxseSBlaGNpX3ByZXBhcmVfcG9ydHNfZm9yX2NvbnRyb2xs
ZXJfc3VzcGVuZCgpLCBidXQgSSBkaWQKbm90IGNoZWNrIGl0IHdhcyBhbHJlYWR5IHRha2VuIGNh
cmUgb2YgYnkgZWhjaV9zdXNwZW5kL3Jlc3VtZSgpLgoKQ2FsbCByZW1vdmVkIGluIGJvdGggcGF0
aHMsIHRoYW5rcyEKTWlxdcOobAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=

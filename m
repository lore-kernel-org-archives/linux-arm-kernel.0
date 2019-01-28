Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBD4C282CF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:34:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D205214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a2hBK1Vz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D205214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sV/tZ6fkzIxlIFuPBjmIUIYpQOvX0fqDBJREaW9pgy4=; b=a2hBK1VzUkxzxA
	2FcoSCAojrEKmDL5wbpU4ovx5ofr2nXdEexbZrQ53LsKthEYF4GmdQSqjiOFUazOVMSI1ErcGF6Vp
	hf05hVhpDnkPV72mtDbyhjJOO7hJQOdPJg6cBQwWhZG40/sNSHDJ5KFL9GeFW9qZ4w1FeRD2+Z+Li
	SKqpKWu/nzkuNpJ4zDXS7TzJzYyyDoBvZWyum3LCBdIJVLfGuOOoKnP/sZ/SMEHNp5IheRql4Q0/s
	B+n8tSxzp1uARn0QihsBpANHZoHpDykwmi762eWN4NtFisqtvjAB2+Sf5zZYWLW4Oe8y0Dodmdnxi
	Xw6EC28M9G8mPN3MyKdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go4Er-0008A7-H9; Mon, 28 Jan 2019 10:34:01 +0000
Received: from relay2-d.mail.gandi.net ([217.70.183.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go4En-00089d-U7
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 10:33:59 +0000
X-Originating-IP: 90.88.29.206
Received: from xps13 (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr
 [90.88.29.206]) (Authenticated sender: miquel.raynal@bootlin.com)
 by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id AE4D440009;
 Mon, 28 Jan 2019 10:33:51 +0000 (UTC)
Date: Mon, 28 Jan 2019 11:33:50 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v4 04/10] usb: ehci-orion: add S2RAM support
Message-ID: <20190128113350.603b2be3@xps13>
In-Reply-To: <Pine.LNX.4.44L0.1901252152190.18583-100000@netrider.rowland.org>
References: <20190125103925.15753-5-miquel.raynal@bootlin.com>
 <Pine.LNX.4.44L0.1901252152190.18583-100000@netrider.rowland.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_023358_133453_163FA51F 
X-CRM114-Status: GOOD (  18.75  )
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
IEZyaSwgMjUgSmFuIDIwMTkKMjE6NTY6MjcgLTA1MDAgKEVTVCk6Cgo+IE9uIEZyaSwgMjUgSmFu
IDIwMTksIE1pcXVlbCBSYXluYWwgd3JvdGU6Cj4gCj4gPiBBZGQgc3VzcGVuZC9yZXN1bWUgY2Fs
bGJhY2tzIHRvIHJlc2V0IHRoZSBob3N0IGNvbnRyb2xsZXIgcHJvcGVybHkKPiA+IGR1cmluZyBT
MlJBTSBvcGVyYXRpb24uCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IE1pcXVlbCBSYXluYWwgPG1p
cXVlbC5yYXluYWxAYm9vdGxpbi5jb20+Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL3VzYi9ob3N0L2Vo
Y2ktb3Jpb24uYyB8IDE4ICsrKysrKysrKysrKysrKysrKwo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAx
OCBpbnNlcnRpb25zKCspCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L2Vo
Y2ktb3Jpb24uYyBiL2RyaXZlcnMvdXNiL2hvc3QvZWhjaS1vcmlvbi5jCj4gPiBpbmRleCAzMTA5
ZjA4Mjk0OWUuLjBkYWIwOTliNWQxNSAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2hvc3Qv
ZWhjaS1vcmlvbi5jCj4gPiArKysgYi9kcml2ZXJzL3VzYi9ob3N0L2VoY2ktb3Jpb24uYwo+ID4g
QEAgLTE4Miw2ICsxODIsMjMgQEAgc3RhdGljIGludCBlaGNpX29yaW9uX2Rydl9yZXNldChzdHJ1
Y3QgdXNiX2hjZCAqaGNkKQo+ID4gIAlyZXR1cm4gcmV0Owo+ID4gIH0KPiA+ICAKPiA+ICtzdGF0
aWMgaW50IF9fbWF5YmVfdW51c2VkIGVoY2lfb3Jpb25fZHJ2X3N1c3BlbmQoc3RydWN0IGRldmlj
ZSAqZGV2KQo+ID4gK3sKPiA+ICsJc3RydWN0IHVzYl9oY2QgKmhjZCA9IGRldl9nZXRfZHJ2ZGF0
YShkZXYpOwo+ID4gKwo+ID4gKwlyZXR1cm4gZWhjaV9zdXNwZW5kKGhjZCwgZGV2aWNlX21heV93
YWtldXAoZGV2KSk7ICAKPiAKPiBPa2F5LCBnb29kLgo+IAo+ID4gK30KPiA+ICsKPiA+ICtzdGF0
aWMgaW50IF9fbWF5YmVfdW51c2VkIGVoY2lfb3Jpb25fZHJ2X3Jlc3VtZShzdHJ1Y3QgZGV2aWNl
ICpkZXYpCj4gPiArewo+ID4gKwlzdHJ1Y3QgdXNiX2hjZCAqaGNkID0gZGV2X2dldF9kcnZkYXRh
KGRldik7Cj4gPiArCj4gPiArCXJldHVybiBlaGNpX3Jlc3VtZShoY2QsIGRldmljZV9tYXlfd2Fr
ZXVwKGRldikpOyAgCj4gCj4gTm90IHNvIGdvb2QuICBUaGUgc2Vjb25kIGFyZ3VtZW50IGhlcmUg
aXMgZm9yY2VfcmVzZXQ7IHByZXN1bWFibHkgeW91IAo+IHdhbnQgaXQgYWx3YXlzIHRvIGJlIGZh
bHNlLiAgKE5vdGUgdGhhdCB0aGUgdjMgdmVyc2lvbiBvZiB0aGlzIHBhdGNoIAo+IGRpZCBub3Qg
Y2FsbCBkZXZpY2VfbWF5X3dha2V1cCgpIGluIGVoY2lfb3Jpb25fZHJ2X3Jlc3VtZS4pCj4gCj4g
WWVzLCB0aGUgQVBJIGlzIG5vdCBzeW1tZXRyaWNhbC4gIFNvIHN1ZSBtZS4uLgoKT2ggcmlnaHQs
IEkgY29tcGxldGVseSBvdmVybG9va2VkIHRoYXQgb25lLiBJbmRlZWQgdGhlIHNlY29uZCBwYXJh
bWV0ZXIKc2hvdWxkIGJlICJmYWxzZSIsIGFzIGluIHRoZSB2My4gRG8geW91IG1pbmQgaWYgSSBz
ZW5kIGEgdjUgb25seSBmb3IKdGhpcyBwYXRjaD8gSWYgdGhlIHJlc3QgbG9va3MgZ29vZCB0byB5
b3Ugb2YgY291cnNlLgoKClRoYW5rcywKTWlxdcOobAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=

Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B12BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:37:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E2082087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R/gspj5t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2082087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z8cjDkF49uG074Rfr9x+SUFWmh1hEHNorESdOZ0O7nY=; b=R/gspj5tcBToMT
	RRZuxLR/tkzfAeeVIRKOlWLcwKMdX10OMyw/RnlNaYXbhbYWNIZoTWBtU8fZPwBNlKxHCNmpxkucU
	0473V5qoG5C5a1mYl8mXssPPpQ7AOgiTJVSaSGjyN1ZwxQvv/V/3UYWPR3BShOCyJKhYmw68Oai7L
	+vm+kYuMh2ww3jZwtGtXBEO6wvzwGVXryGobPNVYwsbssvhJtGJ461Qp44m/JM9fMhNb9tyajNOph
	P1CCygpTOpNe499vUj5c2PEn7bYlzZ4EUuz9DstLs+JpYjS9s0axe40flz8EJmch5TJsoBW/IurJi
	WDDMdYPHsebtN8Foj7eQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkX94-0002AY-2q; Fri, 18 Jan 2019 16:37:26 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkX8T-0001nm-4U
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:37:09 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 18F7B20C13; Fri, 18 Jan 2019 17:36:47 +0100 (CET)
Received: from localhost (alyon-652-1-26-46.w109-213.abo.wanadoo.fr
 [109.213.9.46])
 by mail.bootlin.com (Postfix) with ESMTPSA id A266C20A7A;
 Fri, 18 Jan 2019 17:36:36 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 05/10] phy: add A3700 UTMI PHY driver
References: <20190111133133.24803-1-miquel.raynal@bootlin.com>
 <20190111133133.24803-6-miquel.raynal@bootlin.com>
Date: Fri, 18 Jan 2019 17:36:36 +0100
In-Reply-To: <20190111133133.24803-6-miquel.raynal@bootlin.com> (Miquel
 Raynal's message of "Fri, 11 Jan 2019 14:31:28 +0100")
Message-ID: <87zhrxly7f.fsf@FE-laptop>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_083649_694531_2EFA27BD 
X-CRM114-Status: GOOD (  17.82  )
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

SGkgTWlxdWVsLAoKSSBoYXZlIG9ubHkgYSBmZXcgc21hbGxpc2ggcmVtYXJrczoKCiBPbiB2ZW4u
LCBqYW52LiAxMSAyMDE5LCBNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29t
PiB3cm90ZToKCj4gTWFydmVsbCBBcm1hZGEgMzcwMCBTb0MgaGFzIHR3byBVU0IgY29udHJvbGxl
cnMsIGVhY2ggb2YgdGhlbSBiZWluZwo+IHdpcmVkIHRvIGFuIGludGVybmFsIFVUTUkgUEhZLiBB
ZGQgYSBkcml2ZXIgdG8gY29udHJvbCB0aGVtLgo+Cj4gSWdhbCBMaWJlcm1hbiB3b3JrZWQgb24g
c3VwcG9ydGluZyB0aGUgUEhZLCBJIHRvb2sgdGhlIHdoaWxlICdyZWdpc3Rlcgo+IGNvbmZpZ3Vy
YXRpb24nIGZyb20gaGlzIHdvcmsgYW5kIHJld3JvdGUgYWxtb3N0IGVudGlyZWx5IHRoZQo+IGRy
aXZlci9iaW5kaW5ncyBhcm91bmQgaXQuCj4KPiBDby1kZXZlbG9wZWQtYnk6IElnYWwgTGliZXJt
YW4gPGlnYWxsQG1hcnZlbGwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IE1pcXVlbCBSYXluYWwgPG1p
cXVlbC5yYXluYWxAYm9vdGxpbi5jb20+Cj4gU2lnbmVkLW9mZi1ieTogSWdhbCBMaWJlcm1hbiA8
aWdhbGxAbWFydmVsbC5jb20+Cj4gLS0tClsuLi5dCgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Bo
eS9tYXJ2ZWxsL3BoeS1tdmVidS1hMzcwMC11dG1pLmMgYi9kcml2ZXJzL3BoeS9tYXJ2ZWxsL3Bo
eS1tdmVidS1hMzcwMC11dG1pLmMKPiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+IGluZGV4IDAwMDAw
MDAwMDAwMC4uOTdkODIzNWQ2NjFkCj4gLS0tIC9kZXYvbnVsbAo+ICsrKyBiL2RyaXZlcnMvcGh5
L21hcnZlbGwvcGh5LW12ZWJ1LWEzNzAwLXV0bWkuYwo+IEBAIC0wLDAgKzEsMjk3IEBACj4gKy8v
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wCj4gKy8qCj4gKyAqIENvcHlyaWdodCAo
QykgMjAxOCBNYXJ2ZWxsCj4gKyAqCj4gKyAqIEF1dGhvcnM6Cj4gKyAqICAgRXZhbiBXYW5nIDx4
c3dhbmdAbWFydmVsbC5jb20+Cj4gKyAqICAgTWlxdcOobCBSYXluYWwgPG1pcXVlbC5yYXluYWxA
Ym9vdGxpbi5jb20+CgpJZiBpdCBpcyBjby1kZXZlbG9wZWQgd2l0aCBJZ2FsIExpYmVybWFuLCBz
aG91bGRuJ3QgYmUgYWRkZWQgaGVyZSB0b28/ClsuLi5dCgo+ICtzdGF0aWMgaW50IG12ZWJ1X2Ez
NzAwX3V0bWlfcGh5X3Bvd2VyX29uKHN0cnVjdCBwaHkgKnBoeSkKPiArewo+ICsJc3RydWN0IG12
ZWJ1X2EzNzAwX3V0bWkgKnV0bWkgPSBwaHlfZ2V0X2RydmRhdGEocGh5KTsKPiArCXN0cnVjdCBk
ZXZpY2UgKmRldiA9ICZwaHktPmRldjsKPiArCWludCB1c2IzMiA9IHV0bWktPmNhcHMtPnVzYjMy
Owo+ICsJaW50IHJldCA9IDA7Cj4gKwl1MzIgcmVnOwo+ICsKPiArCWlmICghdXRtaSkKPiArCQly
ZXR1cm4gLUVOT0RFVjsKPiArCj4gKwkvKgo+ICsJICogU2V0dXAgUExMLiA0ME1IeiBjbG9jayB1
c2VkIHRvIGJlIHRoZSBkZWZhdWx0LCBiZWluIDI1TUh6IG5vdy4KICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJlaW4/Cj4gKwkgKiBTZWUg
IlBMTCBTZXR0aW5ncyBmb3IgVHlwaWNhbCBSRUZDTEsiIHRhYmxlLgoKWy4uLl0KCj4gKwo+ICsJ
LyogV2FpdCBmb3Igc3F1ZXRjaCBjYWxpYnJhdGlvbiAqLwogICAgICAgICAgICAgICAgICAgIHNx
dWV0Y2g/CgpHcmVnb3J5CgotLSAKR3JlZ29yeSBDbGVtZW50LCBCb290bGluCkVtYmVkZGVkIExp
bnV4IGFuZCBLZXJuZWwgZW5naW5lZXJpbmcKaHR0cDovL2Jvb3RsaW4uY29tCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1h
aWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==

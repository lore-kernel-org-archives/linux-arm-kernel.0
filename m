Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C25C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:56:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45E9120C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ANfSVUs4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E9120C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6R1l+W2X+OHai1FQwtE618q+VlG7/PdvHKRgM7U+uM0=; b=ANfSVUs4e+2MZy
	VHJLlPCs7y0z4jLOhidKhChSh2jY+Xl9ILdE6veuToIBTZUrZccK/WzJU5FQQ+H9Zs2U6aBU8Up/E
	/UapjLDjW+z8dlqQi529t1l2qKyr+r9ZtN6t0epDobIipyebjDV+EkspnjwBKXtlzSk6p0I9hRWSN
	+xXEwQXQK9Jm6cKzTlZ2CXnuLGMATgRRy9X9LopooSSNsBCZFgIdMg4R3sMXr55QRsVhpFhOs4PpG
	PPJNQ63B+sQAI7cXAnTwsuQoo/KRf/YiChW6sB0880KkJcgdRlKj0o/FmEdn/S6HsrnZdXx/8Pb+H
	TV6iKpfTTbKQDiL8xyhQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyzhB-0000vh-37; Wed, 27 Feb 2019 13:56:25 +0000
Received: from relay2-d.mail.gandi.net ([217.70.183.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyzh7-0000vI-0l; Wed, 27 Feb 2019 13:56:23 +0000
X-Originating-IP: 90.88.147.150
Received: from xps13 (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr
 [90.88.147.150]) (Authenticated sender: miquel.raynal@bootlin.com)
 by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 777E040008;
 Wed, 27 Feb 2019 13:56:08 +0000 (UTC)
Date: Wed, 27 Feb 2019 14:56:07 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [RFC PATCH 03/27] mtd: nand: Introduce the ECC engine abstraction
Message-ID: <20190227145607.24e49014@xps13>
In-Reply-To: <20190225195543.27799e77@kernel.org>
References: <20190221100216.25255-1-miquel.raynal@bootlin.com>
 <20190221100216.25255-4-miquel.raynal@bootlin.com>
 <20190225195543.27799e77@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_055621_209034_69A99F42 
X-CRM114-Status: GOOD (  14.73  )
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
b24gTW9uLCAyNSBGZWIgMjAxOQoxOTo1NTo0MyArMDEwMDoKCj4gT24gVGh1LCAyMSBGZWIgMjAx
OSAxMTowMTo1MiArMDEwMAo+IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5j
b20+IHdyb3RlOgo+IAo+ID4gKwo+ID4gKy8qKgo+ID4gKyAqIHN0cnVjdCBuYW5kX2VjY19lbmdp
bmVfb3BzIC0gR2VuZXJpYyBFQ0MgZW5naW5lIG9wZXJhdGlvbnMKPiA+ICsgKgo+ID4gKyAqIEBp
bml0X2N0eDogZ2l2ZW4gYSBkZXNpcmVkIHVzZXIgY29uZmlndXJhdGlvbiBmb3IgdGhlIHBvaW50
ZWQgTkFORCBkZXZpY2UsCj4gPiArICogICAgICAgICAgICByZXF1ZXN0cyB0aGUgRUNDIGVuZ2lu
ZSBkcml2ZXIgdG8gc2V0dXAgYSBjb25maWd1cmF0aW9uIHdpdGgKPiA+ICsgKiAgICAgICAgICAg
IHZhbHVlcyBpdCBzdXBwb3J0cy4KPiA+ICsgKiBAY2xlYW51cF9jdHg6IGNsZWFuIHRoZSBjb250
ZXh0IGluaXRpYWxpemVkIGJ5IEBpbml0X2N0eC4KPiA+ICsgKiBAcHJlcGFyZV9pb19yZXE6IGlz
IGNhbGxlZCBiZWZvcmUgcmVhZGluZy93cml0aW5nIGEgcGFnZSB0byBwcmVwYXJlIHRoZSBJL08K
PiA+ICsgKiAgICAgICAgICAgICAgICAgIHJlcXVlc3QgdG8gYmUgcGVyZm9ybWVkIHdpdGggRUND
IGNvcnJlY3Rpb24uCj4gPiArICogQGZpbmlzaF9pb19yZXE6IGlzIGNhbGxlZCBhZnRlciByZWFk
aW5nL3dyaXRpbmcgYSBwYWdlIHRvIHRlcm1pbmF0ZSB0aGUgSS9PCj4gPiArICogICAgICAgICAg
ICAgICAgIHJlcXVlc3QgYW5kIGVuc3VyZSBwcm9wZXIgRUNDIGNvcnJlY3Rpb24uCj4gPiArICov
Cj4gPiArc3RydWN0IG5hbmRfZWNjX2VuZ2luZV9vcHMgeyAgCj4gCj4gV2UgbWlnaHQgd2FudCB0
byBhZGQgYQo+IAo+IAl2b2lkICgqcHV0X2VuZ2luZSkoc3RydWN0IG5hbmRfZWNjX2VuZ2luZSAq
ZW5naW5lKTsKPiAKPiBoZXJlIGlmIHdlIHdhbnQgdGhlIG5hbmRkZXYgY2xlYW51cCBwYXRoIHRv
IGJlIGdlbmVyaWMuCj4gVGhpcyBob29rIHdvdWxkIGJlIGltcGxlbWVudGVkIGJ5IGRyaXZlcnMg
d2hlcmUgdGhlIEVDQyBlbmdpbmUgb2JqZWN0IGlzCj4gcmVmY291bnRlZCAodHlwaWNhbGx5IHRo
ZSBjYXNlIGZvciBIVyBFQ0MgZW5naW5lcyBzaGFyZWQgYnkgdGhlIHJhdyBOQU5ECj4gY29udHJv
bGxlciBhbmQgdGhlIFNQSSBjb250cm9sbGVyKS4KPiAKPiBBbHRlcm5hdGl2ZWx5LCB5b3UgY2Fu
IGp1c3QgYWRkIG9uZSBuYW5kX3B1dF94eHhfZWNjX2VuZ2luZSgpIGZ1bmMgcGVyCj4gZW5naW5l
IGNsYXNzIChTVywgb25kaWUgYW5kIEhXKS4KCkNhbid0IHRoaXMgYmUgaGFuZGxlZCBpbiB0aGUg
aW5pdC9jbGVhbnVwX2N0eCgpIHBhdGggZGlyZWN0bHk/CgpGdXJ0aGVybW9yZSBpZiB0aGlzIGlz
IGp1c3QgYSBob29rIHRvIGRvIHJlZmVyZW5jZSBjb3VudGluZy4KCgpUaGFua3MsCk1pcXXDqGwK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFy
bS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1r
ZXJuZWwK

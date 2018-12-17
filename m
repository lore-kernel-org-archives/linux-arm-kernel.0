Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B72C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:55:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72550206A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pw9Jv/9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72550206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ta6KO57mncCbRXrgaOZ4jN5ZcMMgwEQZNnziKLnYIIM=; b=pw9Jv/9K5rWy0z
	MP2hWZJzaYHn9B9jYqk03zVapnGpXIyxpKcgPeOkHiRbhjWCOgRpPOek26NGt+doxGt5neCx6CHEi
	I35ptIn0gyAEj0eQQ5PYVIbRzGdLYncbc5mjZMt5aR2RiwIbBqxOA4hy7CwQhPZFFbTdUlMGQWyae
	kdaMWITW1BXTXnXee1YSJq6JCiyvkC3mJ3PTlcckeALnEvY6ziYseDH+GaD58uPQYqsh2ONUBNS8V
	wQ3taWdUkuvLDGapq1RGC2ZUQg43EK0wRrUcSUPuiRHTffQbDaoiZZpWE5ZDM+U0pjVRx33QMtW5X
	1mrxYqOafH0NZb2c4gyg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYuIc-00051t-38; Mon, 17 Dec 2018 14:55:14 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYuIY-0003lR-9I
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 14:55:12 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id B0A5A20510; Mon, 17 Dec 2018 15:54:58 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr
 [90.88.30.7])
 by mail.bootlin.com (Postfix) with ESMTPSA id 5509120CDF;
 Mon, 17 Dec 2018 15:54:26 +0100 (CET)
Date: Mon, 17 Dec 2018 15:54:26 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 05/12] PCI: aardvark: add suspend to RAM support
Message-ID: <20181217155426.71058a03@xps13>
In-Reply-To: <61805564.abKDZ2rVK7@aspire.rjw.lan>
References: <20181123141831.8214-1-miquel.raynal@bootlin.com>
 <20181213105302.GA5330@e107981-ln.cambridge.arm.com>
 <20181213153000.245d7d5f@xps13>
 <61805564.abKDZ2rVK7@aspire.rjw.lan>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_065510_600974_5ED7AB7B 
X-CRM114-Status: GOOD (  21.46  )
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
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Antoine Tenart <antoine.tenart@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, sudeep.holla@arm.com,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgUmFmYWVsLAoKIlJhZmFlbCBKLiBXeXNvY2tpIiA8cmp3QHJqd3lzb2NraS5uZXQ+IHdyb3Rl
IG9uIFRodSwgMTMgRGVjIDIwMTgKMjI6NTA6NTEgKzAxMDA6Cgo+IE9uIFRodXJzZGF5LCBEZWNl
bWJlciAxMywgMjAxOCAzOjMwOjAwIFBNIENFVCBNaXF1ZWwgUmF5bmFsIHdyb3RlOgo+ID4gSGkg
TG9yZW56bywKPiA+ICAgCj4gPiA+ID4gSWYgdGhhdCdzIHJlYWxseSB0aGUgY2FzZSwgdGhlbiBJ
IGNhbiBzZWUgaG93IG9uZSBkZXZpY2UgYW5kIGl0J3MKPiA+ID4gPiBjaGlsZHJlbiBhcmUgc3Vz
cGVuZGVkIGFuZCB0aGUgaXJxIGZvciBpdCBpcyBkaXNhYmxlZCBidXQgdGhlIHByb3ZpZGluZwo+
ID4gPiA+IGRldmljZXMgKGNsaywgcmVndWxhdG9yLCBidXMgY29udHJvbGxlciwgZXRjLikgYXJl
IHN0aWxsIGZ1bGx5IGFjdGl2ZQo+ID4gPiA+IGFuZCBub3Qgc3VzcGVuZGVkIGJ1dCBpbiBmYWN0
IGNvbXBsZXRlbHkgdXNhYmxlIGFuZCBhYmxlIHRvIHNlcnZpY2UKPiA+ID4gPiBpbnRlcnJ1cHRz
LiBJZiB0aGF0IGFsbCBtYWtlcyBzZW5zZSwgdGhlbiBJIHdvdWxkIGFuc3dlciB0aGUgcXVlc3Rp
b24KPiA+ID4gPiB3aXRoIGEgZGVmaW5pdGl2ZSAieWVzIGl0J3MgYWxsIGZpbmUiIGJlY2F1c2Ug
dGhlIGNsayBjb25zdW1lciBjb3VsZCBiZQo+ID4gPiA+IGluIHRoZSBOT0lSUSBwaGFzZSBvZiBp
dHMgc3VzcGVuZCBidXQgdGhlIGNsayBwcm92aWRlciB3b3VsZG4ndCBoYXZlCj4gPiA+ID4gZXZl
biBzdGFydGVkIHN1c3BlbmRpbmcgeWV0IHdoZW4gY2xrX2Rpc2FibGVfdW5wcmVwYXJlKCkgaXMg
Y2FsbGVkLiAgICAKPiA+ID4gCj4gPiA+IFRoYXQncyBhIHZlcnkgZ29vZCBzdW1tYXJ5IGFuZCBh
ZGRyZXNzIG15IGNvbmNlcm4sIEkgc3RpbGwgcXVlc3Rpb24gdGhpcwo+ID4gPiBwYXRjaCBjb3Jy
ZWN0bmVzcyAoYW5kIG1hbnkgb3RoZXJzIHRoYXQgY2Fycnkgb3V0IGNsayBvcGVyYXRpb25zIGlu
IFMyUgo+ID4gPiBOT0lSUSBwaGFzZSksIHRoZXkgbWF5IHdvcmsgYnV0IGRvIG5vdCB0ZWxsIG1l
IHRoZXkgYXJlIHJvY2sgc29saWQgZ2l2ZW4KPiA+ID4geW91ciBhY2N1cmF0ZSBzdW1tYXJ5IGFi
b3ZlLiAgCj4gPiAKPiA+IEkgdW5kZXJzdGFuZCB5b3VyIGNvbmNlcm4gYnV0IEkgZG9uJ3Qgc2Vl
IGFueSBhbHRlcm5hdGl2ZSByaWdodCBub3cKPiA+IGFuZCBhIGRlZXAgcmV3b3JrIG9mIHRoZSBQ
TSBjb3JlIHRvIHJlc3BlY3Qgc3VjaCBkZXBlbmRlbmN5IGlzIG5vdAo+ID4gc29tZXRoaW5nIHRo
YXQgY2FuIGJlIGRvbmUgaW4gYSByZWFzb25hYmxlIGFtb3VudCBvZiB0aW1lLiAgCj4gCj4gTWF5
YmUgeW91IGRvbid0IG5lZWQgdG8gcmV3b3JrIGFueXRoaW5nLiA6LSkKPiAKPiBIYXZlIHlvdSBj
b25zaWRlcmVkIHVzaW5nIGRldmljZSBsaW5rcz8KCkFic29sdXRlbHksIHllcyA6KSBJIGFtIGFj
dGl2ZWx5IHdvcmtpbmcgb24gaXQgaW4gcGFyYWxsZWwsIHlvdSBjYW4KY2hlY2sgdGhlIHRoaXJk
IHZlcnNpb24gdGhlcmUgWzFdLiBTdGVwaGVuIEJveWQgaGFzIGEgc2xpZ2h0bHkKZGlmZmVyZW50
IGlkZWEgb2YgaG93IGl0IHNob3VsZCBiZSBkb25lLCBJIHdpbGwgcHJvcG9zZSBhIHY0IHRoaXMg
d2VlaywKSSBjYW4gYWRkIHlvdSBpbiBjb3B5IGlmIHlvdSBhcmUgaW50ZXJlc3RlZCEKCkFueXdh
eSwgdGhlcmUgaXMgb25lIHRoaW5nIHRoYXQgaXMgc3RpbGwgbWlzc2luZzoKKiBMZXQncyBoYXZl
IGRldmljZSBBIHRoYXQgcmVxdWVzdHMgY2xvY2sgQgoqIFdpdGggdGhlIGRldmljZSBsaW5rIHNl
cmllcywgQSBpcyBsaW5rZWQgKGFzIGEgY2hpbGQpIHRvIEIuCiogQSBzdXNwZW5kL3Jlc3VtZSBo
b29rcyBoYW5kbGUgdGhpbmdzIGluIHRoZSBOT0lSUSBwaGFzZS4KKiBCIHN1c3BlbmQvcmVzdW1l
IGhvb2tzIGhhbmRsZSB0aGluZ3MgaW4gdGhlIGRlZmF1bHQgcGhhc2UuCgpXaGF0IEkgZXhwZWN0
ZWQgZHVyaW5nIGEgc3VzcGVuZDoKMS8gLT5zdXNwZW5kX25vaXJxKGRldmljZSBBKQoyLyAtPnN1
c3BlbmQoY2xvY2sgQikKClVuZm9ydHVuYXRlbHksIGRldmljZSBsaW5rcyBkbyBub3Qgc2VlbSB0
byBlbmZvcmNlIGFueSBwcmlvcml0eSBiZXR3ZWVuCnBoYXNlcyAoZGVmYXVsdC9sYXRlL25vaXJx
KSBhbmQgd2hhdCBoYXBwZW5zIGlzOgoxLyAtPnN1c3BlbmQoQikKMi8gLT5zdXNwZW5kX25vaXJx
KEEpCldoaWNoIGhhcyBubyBzZW5zZSBpbiBteSBjYXNlLiBIZW5jZSwgSSBoYWQgdG8gcmVxdWVz
dCB0aGUgY2xvY2sKc3VzcGVuZC9yZXN1bWUgY2FsbGJhY2tzIHRvIGJlIHVwZ3JhZGVkIHRvIHRo
ZSBOT0lSUSBwaGFzZSBhcyB3ZWxsIChJCmRvbid0IGhhdmUgYSBiZXR0ZXIgc29sdXRpb24gZm9y
IG5vdykuIFRoaXMgaXMgc3RpbGwgdW5kZXIgZGlzY3Vzc2lvbgppbiBhIHRocmVhZCB5b3UgaGF2
ZSBiZWVuIHJlY2VudGx5IGFkZGVkIHRvIGJ5IEJqb3JuLCBzZWUgWzJdLgoKU28gd2hlbiBJIHRv
bGQgeW91IEkgd2FzIG5vdCBjb25maWRlbnQgaW4gInJld29ya2luZyB0aGUgUE0gY29yZSB0bwpy
ZXNwZWN0IHN1Y2ggZGVwZW5kZW5jeSIsIHRoaXMgaXMgd2hhdCBJIHdhcyByZWZlcnJpbmcgdG8u
IEkgYW0KZGVmaW5pdGVseSByZWFkeSB0byBoZWxwLCBidXQgSSBkb24ndCBmZWVsIEkgY2FuIGRv
IGl0IGFsb25lLgoKWzFdIGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2xpbnV4LWNsay9t
c2czMjgyNC5odG1sClsyXSBodHRwczovL21hcmMuaW5mby8/bD1saW51eC1wbSZtPTE1NDQ2NTE5
ODUxMDczNSZ3PTIKCgpUaGFua3MsCk1pcXXDqGwKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK

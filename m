Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DCAC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:39:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 044D22087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YmUPDakb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044D22087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=krSpy3cGE8JH3/sE0VNIQm9lvJ55DjxOSMWQ9LJAkMM=; b=YmUPDakb6CDQml
	tEMQxOFo66q6/9RX/qUGltgn6QM856vpOh+WboqdsLJGglzAFrziWmdAYxOW943kGt3AG0HH/GmGB
	b+sUZAM+QQTVj+Xqi2Bef7yFlIsZ6rVmTVh00FjRj9bzwjLDMO3UALo/DLZjXuDlqLTkhzb2GuqdW
	DUXsaXWSQ7iOta0qgl+E0grXCg0yt6S4WFT6waW/lG4ZdofgAJkhFBYc9rtUxR/SFrldmpB0jCHUf
	MaFX8nMRr17vVq2gD2GGuBj9EhxOubHsM31mQ8g2F6F/PJVTarZ5JTi4Om7QhDkrDkjPnqyPmY5sM
	BFZ8IFvQWaXS/pBGM+6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTqJK-0002ZG-CN; Mon, 03 Dec 2018 15:39:02 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTqJG-0002YG-B2
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 15:39:00 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id E06C72072A; Mon,  3 Dec 2018 16:38:46 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr
 [90.88.18.158])
 by mail.bootlin.com (Postfix) with ESMTPSA id 702282037D;
 Mon,  3 Dec 2018 16:38:46 +0100 (CET)
Date: Mon, 3 Dec 2018 16:38:46 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 05/12] PCI: aardvark: add suspend to RAM support
Message-ID: <20181203163846.494904f9@xps13>
In-Reply-To: <20181203102708.GA6090@e107981-ln.cambridge.arm.com>
References: <20181123141831.8214-1-miquel.raynal@bootlin.com>
 <20181123141831.8214-6-miquel.raynal@bootlin.com>
 <20181203102708.GA6090@e107981-ln.cambridge.arm.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_073858_512702_C6925C4F 
X-CRM114-Status: GOOD (  18.61  )
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
 Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org,
 Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, sudeep.holla@arm.com,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgTG9yZW56bywKCkxvcmVuem8gUGllcmFsaXNpIDxsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29t
PiB3cm90ZSBvbiBNb24sIDMgRGVjIDIwMTgKMTA6Mjc6MDggKzAwMDA6Cgo+IFsrUmFmYWVsLCBT
dWRlZXBdCj4gCj4gT24gRnJpLCBOb3YgMjMsIDIwMTggYXQgMDM6MTg6MjRQTSArMDEwMCwgTWlx
dWVsIFJheW5hbCB3cm90ZToKPiA+IEFkZCBzdXNwZW5kIGFuZCByZXN1bWUgY2FsbGJhY2tzLiBU
aGUgcHJpb3JpdHkgb2YgdGhlc2UgYXJlCj4gPiAiX25vaXJxKCkiLCB0byB3b3JrYXJvdW5kIGVh
cmx5IGFjY2VzcyB0byB0aGUgcmVnaXN0ZXJzIGRvbmUgYnkgdGhlCj4gPiBQQ0kgY29yZSB0aHJv
dWdoIHRoZSAtPnJlYWQoKS8tPndyaXRlKCkgY2FsbGJhY2tzIGF0IHJlc3VtZSB0aW1lLgo+ID4g
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4u
Y29tPgo+ID4gLS0tCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktYWFyZHZhcmsuYyB8
IDUyICsrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1MiBp
bnNlcnRpb25zKCspCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L3BjaS1hYXJkdmFyay5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktYWFyZHZhcmsuYwo+
ID4gaW5kZXggMTA4YjNmMTVjNDEwLi43ZWNmMWFjNDAzNmIgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1hYXJkdmFyay5jCj4gPiArKysgYi9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL3BjaS1hYXJkdmFyay5jCj4gPiBAQCAtMTEwOCw2ICsxMTA4LDU1IEBAIHN0YXRp
YyBpbnQgYWR2a19wY2llX3NldHVwX2NsayhzdHJ1Y3QgYWR2a19wY2llICpwY2llKQo+ID4gIAly
ZXR1cm4gcmV0Owo+ID4gIH0KPiA+ICAKPiA+ICtzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIGFk
dmtfcGNpZV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikKPiA+ICt7Cj4gPiArCXN0cnVjdCBh
ZHZrX3BjaWUgKnBjaWUgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsKPiA+ICsKPiA+ICsJYWR2a19w
Y2llX2Rpc2FibGVfcGh5KHBjaWUpOwo+ID4gKwo+ID4gKwljbGtfZGlzYWJsZV91bnByZXBhcmUo
cGNpZS0+Y2xrKTsgIAo+IAo+IEkgaGF2ZSBub3RpY2VkIGl0IGlzIGNvbW1vbiBwcmFjdGljZSwg
c3RpbGwsIEkgd291bGQgbGlrZSB0byBjaGVjayB3aGV0aGVyCj4gaXQgaXMgYWxsb3dlZCB0byBj
YWxsIGZ1bmN0aW9ucyB0aGF0IG1heSBzbGVlcCBpbiBhIE5PSVJRIHN1c3BlbmQvcmVzdW1lCj4g
Y2FsbGJhY2sgPwoKWW91IGFyZSByaWdodCB0aGlzIGlzIHdlaXJkLiBJIGRvdWJsZSBjaGVja2Vk
IGFuZCBmb3IgaW5zdGFuY2UsCnBjaWUtbWVkaWF0ZWsuYywgcGNpLXRlZ3JhLmMgYW5kIHBjaS1p
bXg2LmMgZG8gdGhlIGV4YWN0IHNhbWUgdGhpbmcuIFRoZXJlIGFyZQpwcm9iYWJseSBvdGhlciBj
YXNlcyB3aGVyZSBkcml2ZXJzIGNhbGwgZnVuY3Rpb25zIHRoYXQgbWF5IHNsZWVwIGZyb20gYSBO
T0lSUQpjb250ZXh0LiBJIGFtIGludGVyZXN0ZWQgdG8ga25vdyBpZiB0aGlzIGlzIHZhbGlkIGFu
ZCBpZiBub3QsIHdoYXQgaXMgdGhlCmFsdGVybmF0aXZlPwoKClRoYW5rcywKTWlxdcOobAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bAo=

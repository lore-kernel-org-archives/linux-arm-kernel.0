Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FA1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 10:58:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E4AA20663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 10:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WOZgPokT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E4AA20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XV+NfH9NXmdOH4z3krCWh2X/0Gi2Np9vRkp1ZLVETDI=; b=WOZgPokTjp3sXA
	zJki8Ci4z/sPC0vvuwuOIWgp3k+WHjtVm45f2utD3m5MihMDEBZm6J4PqJijw/BR/Yj27ivQIEx9O
	yowJNnyRM/p/GpJXTaNASam7k3ctCqmThG8r1lleZFHBHbRByx701oO5f/JbddcZTLXI70dm5/dg7
	R4nDKBdmzZ60CoHcJOJTuBN47fdDDkLc5DGAx5bu0NiPjCThBMv9S3i/jhRtQvxh44bwU8kmsqXjj
	79E0DBjKD9FOCjT82p181cuvgeTxBb01qLIC+e9GRJRXdHuPoBtKj2UCLrh1oswb7qSrE42pcCLOn
	/ZORakvO2WOe+t1c/++w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyDyB-0008KH-82; Mon, 25 Feb 2019 10:58:47 +0000
Received: from relay2-d.mail.gandi.net ([217.70.183.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyDy7-0008Jb-FV
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 10:58:45 +0000
X-Originating-IP: 90.88.23.190
Received: from xps13 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr
 [90.88.23.190]) (Authenticated sender: miquel.raynal@bootlin.com)
 by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 5386540005;
 Mon, 25 Feb 2019 10:58:26 +0000 (UTC)
Date: Mon, 25 Feb 2019 11:58:26 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH 4/5] arm64: dts: marvell: armada-8040-clearfog: Drop
 non-existent SATA port
Message-ID: <20190225115826.5bc17f6d@xps13>
In-Reply-To: <87tvgt7o0q.fsf@tarshish>
References: <20190222145356.23072-1-miquel.raynal@bootlin.com>
 <20190222145356.23072-5-miquel.raynal@bootlin.com>
 <87tvgt7o0q.fsf@tarshish>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_025843_666619_2714F8FB 
X-CRM114-Status: GOOD (  15.23  )
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
 Marc Zyngier <marc.zyngier@arm.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Hans de Goede <hdegoede@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Antoine Tenart <antoine.tenart@bootlin.com>,
 Jens Axboe <axboe@kernel.dk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-ide@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQmFydWNoLAoKQmFydWNoIFNpYWNoIDxiYXJ1Y2hAdGtvcy5jby5pbD4gd3JvdGUgb24gU3Vu
LCAyNCBGZWIgMjAxOSAwNzoyOTowOQorMDIwMDoKCj4gSGkgTWlxdWVsLAo+IAo+IE9uIEZyaSwg
RmViIDIyIDIwMTksIE1pcXVlbCBSYXluYWwgd3JvdGU6Cj4gCj4gPiBUaGVyZSBpcyBubyBDUDEx
MCBTQVRBIHBvcnQgYXZhaWxhYmxlIG9uIHRoZSA4MDQwIENsZWFyZm9nIEE4aywgU0FUQQo+ID4g
bWF5IGJlIHVzZWQgdGhhbmtzIHRvIGEgbVBDSWUgLT4gU0FUQSBleHRlbnNpb24gYm9hcmQgb25s
eS4gSGVuY2UsIHRoZQo+ID4gY3AxX3NhdGEwIG5vZGUgbXVzdCBiZSByZW1vdmVkIGZyb20gdGhl
IGRldmljZSB0cmVlLiAgCj4gCj4gTm90IHRydWUuIFlvdSBjYW4gdXNlIHRoZSBtaW5pIFBDSWUg
c2VyZGVzIGFzIFNBVEEgZGlyZWN0bHkgaWYgeW91Cj4gY29uZmlndXJlIGl0IGFzIHN1Y2guIFlv
dSBvbmx5IG5lZWQgdG8gaW52ZXJ0IHRoZSBzZXJkZXMgUnggcGFpcgo+IHBvbGFyaXR5LiBUaGlz
IGlzIHRoZSBkZWZhdWx0IGNvbmZpZ3VyYXRpb24gZm9yIHRoZSBDbGVhcmZvZyBHVC04SyBDT04z
Cj4gbWluaS1QQ0llIHNsb3QgKENQMSwgbGFuZSAjMCkgaW4gY3VycmVudCBtYWlubGluZSBVLUJv
b3QuIEkgdmVyaWZpZWQKPiB0aGF0IHRoaXMgc2V0dXAgd29ya3Mgb24gQ2xlYXJmb2cgR1QtOEsu
Cj4gCj4gVGhpcyBwYXRjaCB3b3VsZCBicmVhayBtaW5pIFBDSWUgZGlyZWN0IFNBVEEuCgpUaGFu
a3MgZm9yIGV4cGxhaW5pbmcsIEkgYW0gYSBsaXR0bGUgYml0IHN1cnByaXNlZCB0aGF0IGl0IGFj
dHVhbGx5CnVzZXMgdGhlIFNBVEEgaG9zdCBJUCBvbiBDUDExMCBidXQgZmluZS4gU28gY2FuIHlv
dSB0ZWxsIG1lIHdoaWNoIFNBVEEKcG9ydCBpcyB1c2VkIGluIHRoaXMgY2FzZT8gQmVjYXVzZSBJ
IHdpbGwgaGF2ZSB0byB1cGRhdGUgdGhlIERUCnJlcHJlc2VudGF0aW9uIGFsb25nIHdpdGggdGhl
IENQMTEwIGNoYW5nZXMuCgpUaGFua3MsCk1pcXXDqGwKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cmxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK

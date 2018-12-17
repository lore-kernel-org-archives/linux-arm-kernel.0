Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A76C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:07:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E99CA2145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FSJhI51Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99CA2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AJEVedY98fUWtFXU9Ek86wPpUxEQuQdDGQ26A98N330=; b=FSJhI51YhPqpbn
	C+hzgkDkDs+qHIGPYS7eRCwsdBENTh9KZ6hxzg2Fy6YdLk5Qfr2m19PJGhvtSy97byANMZJ3vUKsM
	18Zzwqqsmq7cUDC1QI9LMKePkTkSK7CV5pjank33t2cBFIy9HKdEEqCsxS9HeQQJjT6rkzq90ibyU
	0Axjqw4aymc008n1YZd6I2mZXD08gr/hlr3ORbKRdyuYBbXDrVDwGHYi2eqvb7zlqrTPVxWQfyCt7
	JQ1c95342uWTWy2gah1fFdOqRxlVLvPYwYxnz6mSeiVLaymatYQKa80IfHirr0MZ3XTL8Ag0K4rIk
	lN1on2Ko7NE3Xjkfo9lw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYvQs-0005Je-3Z; Mon, 17 Dec 2018 16:07:50 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYvQo-0005Hl-NT
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 16:07:48 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 499682072D; Mon, 17 Dec 2018 17:07:35 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr
 [90.88.30.7])
 by mail.bootlin.com (Postfix) with ESMTPSA id D8C2A20723;
 Mon, 17 Dec 2018 17:07:24 +0100 (CET)
Date: Mon, 17 Dec 2018 17:07:24 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Marek Behun <marek.behun@nic.cz>, Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH v2 03/12] PCI: aardvark: Add PHY support
Message-ID: <20181217170724.58421a29@xps13>
In-Reply-To: <20181214015712.31f749ea@nic.cz>
References: <20181212102142.16053-1-miquel.raynal@bootlin.com>
 <20181212102142.16053-4-miquel.raynal@bootlin.com>
 <20181214014701.373b220b@nic.cz> <20181214015712.31f749ea@nic.cz>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_080746_900028_E14A7F41 
X-CRM114-Status: GOOD (  15.27  )
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
 Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgTWFyZWssCgpNYXJlayBCZWh1biA8bWFyZWsuYmVodW5AbmljLmN6PiB3cm90ZSBvbiBGcmks
IDE0IERlYyAyMDE4IDAxOjU3OjEyCiswMTAwOgoKPiBPbiBGcmksIDE0IERlYyAyMDE4IDAxOjQ3
OjAxICswMTAwCj4gTWFyZWsgQmVodW4gPG1hcmVrLmJlaHVuQG5pYy5jej4gd3JvdGU6Cj4gCj4g
PiBIaSBNaXF1ZWwsCj4gPiBhcmUgdGhlcmUgYWxyZWFkeSBwYXRjaGVzIGZvciB0aGUgQTM3eHgg
Y29tcGh5IGRyaXZlcj8gIAoKUGxlYXNlIHRyeSB0aGUgbGF0ZXN0IHBhdGNoZXMgb24gdG9wIG9m
IHBoeSAtbmV4dCAod2l0aCBQSFkgaW50ZXJmYWNlCm1vZGUpLCBhdmFpbGFibGUgdGhlcmUgWzFd
LiBZb3UgY2FuIHBpY2sgb25seSB0aGUgQ09NUEhZIHBhdGNoZXMsIGJ1dAprZWVwIHRoZW0gb3Zl
ciB0aGUgcGh5IC1uZXh0IGJyYW5jaC4KClBsZWFzZSBub3RlIHRoYXQgZm9yIHRoZSBTTUMgY2Fs
bHMgdG8gc3VjY2VlZCB5b3UgbXVzdCB1c2UgYSByZWNlbnQKQVRGLiBQZXJzb25hbGx5IEkgdXNl
ZCB0byB3b3JrIHdpdGggdGhlICdhdGYtdjEuNS1kZXZlbCcgYnJhbmNoIG9mCk1hcnZlbGwncyBt
aXNsLWF0ZiByZXBvc2l0b3J5IGJ1dCBpdCBpcyBub3QgYXZhaWxhYmxlIGFueW1vcmUuIElmIHlv
dQphbHJlYWR5IGhhdmUgYSBjbG9uZSwgdGhlbiB5b3UgYXJlIGdvb2QgdG8gZ28sIG90aGVyd2lz
ZSBpdCBtaWdodCBiZQpncmVhdCBpZiBzb21lb25lIGZyb20gTWFydmVsbCBjb3VsZCBzaGFyZSBh
IHB1YmxpYyBHaXRodWIgbGluaz8KCj4gTmV2ZXIgbWluZCwgSSBmb3VuZCB0aGVtLiBJIHNoYWxs
IHRlc3QgdGhpcyBvbiBUdXJyaXMgTW94Lgo+IElzIHRoZSBjb21waHkgZHJpdmVyIHN1cHBvc2Vk
IHRvIGJlIGFibGUgdG8gY2hhbmdlIGV0aCBtb2RlIGZyb20KPiAxMDAwQkFTRS1YIHRvIDI1MDBC
QVNFLVggYW5kIGJhY2sgd2l0aG91dCByZWJvb3Q/CgpJbiB0aGVvcnkgeWVzLCB1bmZvcnR1bmF0
ZWx5IEkgYW0gd29ya2luZyBvbiBhbiBFc3ByZXNzb0JpbiB3aGljaCB1c2VzCnRoZSBTQVRBLCBQ
Q0llIGFuZCBTQVRBIGNvbmZpZ3VyYXRpb25zIG9mIHRoZSBDT01QSFksIGJ1dCBub3QgdGhlCkV0
aGVybmV0IG9uZXMgKFNHTUlJLzEwMDBCQVNFLVggYW5kIEhTX1NHTUlJLzI1MDBCQVNFLVgpLiBT
byB0aGUKc3VwcG9ydCBpcyByZWFkeSB0byBiZSB0ZXN0ZWQhCgo+IAo+IFRoaXMgd291bGQgYmUg
Y29vbCBmb3Igb3VyIFNGUCBjYWdlIG1vZHVsZSBvZiBUdXJyaXMgTW94LCBqdXN0IHRvIGFkZAo+
IHN1cHBvcnQgZm9yIGNvbXBoeSBpbnRvIG12bmV0YS4KPiAKPiBNYXJlawoKWzFdIGh0dHBzOi8v
Z2l0aHViLmNvbS9taXF1ZWxyYXluYWwvbGludXguZ2l0IGJyYW5jaCBtYXJ2ZWxsL3BoeS1uZXh0
L3BtCgoKVGhhbmtzLApNaXF1w6hsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==

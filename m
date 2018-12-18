Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508A7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:23:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BF7421841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bFzabjN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BF7421841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GSuTQGrnIpPyVkE5AbOFiB98zOPEM/1M+gbVAxn5Y/Y=; b=bFzabjN3VLWog4
	nWeWsQ+khBYzUwfH6rgpHI9m2cv7+rdQitUhqFCJHR53dHnJfOgsyUIL3c67IHzBdYLYjn7r5qvAF
	Vy65kZ6VChqQPkwZ+Pi6PNL6ccSGB4ZxZMFx4YKsDK5a1XUx+Bb6nIqhUzS+noGPZLRAMb3YhWG3W
	KcvnN4FXcnRP99ZrOplBUbOn9OjehLS/bkAdPKo+/5sr91SuRi+ssnnEZvDkDnJvLP1eB8mlAVEK7
	KtMPBzGFRRk5GuM658UGQbw1NLm72BYc+Whvr/XEp6QfdQsNwZa+Baw6FTKqNR4Vb5qVpLuuPHFyW
	KLegR97LiM+GdY9EHRBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZAfE-0000WN-23; Tue, 18 Dec 2018 08:23:40 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZAfA-0000V5-F5
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 08:23:38 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 0E52A20824; Tue, 18 Dec 2018 09:23:25 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr
 [90.88.30.7])
 by mail.bootlin.com (Postfix) with ESMTPSA id 8F8AF206A7;
 Tue, 18 Dec 2018 09:23:14 +0100 (CET)
Date: Tue, 18 Dec 2018 09:23:14 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Marek Behun <marek.behun@nic.cz>
Subject: Re: [PATCH v2 03/12] PCI: aardvark: Add PHY support
Message-ID: <20181218092314.725af970@xps13>
In-Reply-To: <20181218091817.4a8a5d42@xps13>
References: <20181212102142.16053-1-miquel.raynal@bootlin.com>
 <20181212102142.16053-4-miquel.raynal@bootlin.com>
 <20181214014701.373b220b@nic.cz> <20181214015712.31f749ea@nic.cz>
 <20181217170724.58421a29@xps13> <20181217223430.182d01d8@nic.cz>
 <20181218091817.4a8a5d42@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_002336_638926_3867BE0F 
X-CRM114-Status: GOOD (  17.08  )
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
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGVsbG8sCgpNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPiB3cm90ZSBv
biBUdWUsIDE4IERlYyAyMDE4CjA5OjE4OjE3ICswMTAwOgoKPiBIaSBNYXJlaywKPiAKPiBNYXJl
ayBCZWh1biA8bWFyZWsuYmVodW5AbmljLmN6PiB3cm90ZSBvbiBNb24sIDE3IERlYyAyMDE4IDIy
OjM0OjMwCj4gKzAxMDA6Cj4gCj4gPiBNaXF1ZWwsCj4gPiAKPiA+IEkgdHJpZWQgdGhlIHBhdGNo
ZXMgYW5kIHRoZXkgYXJlIHdvcmtpbmcsIHdpdGggdGhlIGV4Y2VwdGlvbiBvZiBDb21wZXgKPiA+
IFdMRTkwMFggY2FyZCwgYnV0IHdlIGtub3cgdGhhdCB0aGlzIGNhcmQgaXMgcHJvYmxlbWF0aWMu
ICAKPiAKPiBIb3cgZGlkIHlvdSB0ZXN0IHRoZW0/IEkgYW0gc3VycHJpc2VkIHRoYXQgQ09NUEhZ
IGNhbGxzIHdvcmtlZCBmb3IgeW91Cj4gb3V0IG9mIHRoZSBib3guIEkgYW0gbm90IHN1cmUgeW91
IGhhdmUgQTM3MDAgQ09NUEhZIHN1cHBvcnQgaW4geW91ciBBVEYKPiBidXQgaXQgcHJvYmFibHkg
d29yayBiZWNhdXNlIFUtQm9vdCBpcyBkb2luZyB0aGUgaW5pdGlhbCBjb25maWd1cmF0aW9uLgoK
TGV0IG1lIGNvcnJlY3QgbXlzZWxmOiBhY3R1YWxseSB0aGUgZmVhdHVyZSBpcyBhbHJlYWR5IG1h
aW5saW5lISBTZWUKWzJdLiBJdCB3aWxsIGJlIGFkZGVkIHRvIE1hcnZlbGwncyBCU1AgYnkgdGhl
IGVuZCBvZiB0aGUgeWVhci4gU28gaWYKeW91IGFyZSBydW5uaW5nIGEgcmVjZW50IG1haW5saW5l
IEFURiB5b3UgYXJlIGdvb2QgdG8gZ28hCgo+IAo+ID4gSSBhbSBpbnRlcmVzdGluZyBpZiB0aGVy
ZSBpcyBhIGtub3duIHdheSB0byB0dXJuIG9mIHRoZSBjb21waHkgb24KPiA+IEEzNzIwLCBvciBh
dCBsZWFzdCBjaGFuZ2UgdGhlIFNHTUlJIG1vZGUgZnJvbSAxR2JwcyB0byAyLjVHYnBzIGFuZAo+
ID4gYmFjay4gTWFydmVsbCBkb2N1bWVudGF0aW9uIGRvZXMgbm90IHByb3ZpZGUgdGhpcyBpbmZv
cm1hdGlvbiBhbmQgdGhlCj4gPiBjb2RlIGluIEFURiBwcm92aWRpbmcgdGhlIFNNQyBjYWxscyBk
b2VzIG5vdCBkbyB0aGlzIGVpdGhlci4KPiA+IERvIHlvdSBrbm93IGhvdyB0aGlzIGNhbiBiZSBh
Y2hpZXZlZD8gIAo+IAo+IFRoZSBkcml2ZXIgYWxyZWFkeSBoYW5kbGVzIHRoZXNlIGNhbGxzIChz
ZWUgWzFdKSwgbWFraW5nIHVzZSBvZgo+IHRoZW0gaXMganVzdCBhIG1hdHRlciBvZiBoYWNraW5n
IGludG8gZHJpdmVycyAoaW4geW91ciBjYXNlLCBJCj4gc3VwcG9zZSBpdCBpcyBtdm5ldGEpIGFu
ZCBhZGQgcGh5X3NldF9tb2RlKCkvcGh5X3Bvd2VyX29uKCkgY2FsbHMuCj4gCj4gWzFdIGh0dHBz
Oi8vZ2l0aHViLmNvbS9taXF1ZWxyYXluYWwvbGludXgvYmxvYi9tYXJ2ZWxsL3BoeS1uZXh0L3Bt
L2RyaXZlcnMvcGh5L21hcnZlbGwvcGh5LW12ZWJ1LWEzNzAwLWNvbXBoeS5jI0wxODkKPiAKPiAK
PiBUaGFua3MsCj4gTWlxdcOobAoKWzJdIGh0dHBzOi8vZ2l0aHViLmNvbS9BUk0tc29mdHdhcmUv
YXJtLXRydXN0ZWQtZmlybXdhcmUvYmxvYi9tYXN0ZXIvZHJpdmVycy9tYXJ2ZWxsL2NvbXBoeS9w
aHktY29tcGh5LTM3MDAuYwoKClRoYW5rcywKTWlxdcOobAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QK
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=

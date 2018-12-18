Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED75C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:18:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF53721841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iMnqQ5ZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF53721841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fCqxaBoVD/uwSudHatcxdK7423LzxV3mus3MIxAh4d4=; b=iMnqQ5ZV+a5a9e
	WVAjWrg5E7D1C8jY2vcYi+G5JV/GEls9eNEY6YOHNqglVRXN4uFIOScTcyQ6IPNruSHGmWwbSYKN4
	UDFVGkjwhqE8ocMXIJ9/DuQrXIOrG17WYUSZPPFqrCZ6Mo9Hdg/8flNtaUiCgruPRrkxzMzmGE/+/
	8nKoYy0PWsYiuymeshU8XT489ZdNNAIJH/2A3y3kdrVxxPbaz2diQCuIsVmjVdGxOTBg/R5nS77DG
	TfDNRzxdziK9nqDYKpeDN+dCU+kajNIx8bx213bmkOczqFf1InkTowH2G0WErIR9eU1gX2x62yIsg
	uUyyGUBT/0EPRWWNm6XA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZAaR-0006JK-Ua; Tue, 18 Dec 2018 08:18:43 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZAaO-0006IA-C2
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 08:18:41 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 5040420834; Tue, 18 Dec 2018 09:18:28 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr
 [90.88.30.7])
 by mail.bootlin.com (Postfix) with ESMTPSA id DB906206A7;
 Tue, 18 Dec 2018 09:18:17 +0100 (CET)
Date: Tue, 18 Dec 2018 09:18:17 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Marek Behun <marek.behun@nic.cz>
Subject: Re: [PATCH v2 03/12] PCI: aardvark: Add PHY support
Message-ID: <20181218091817.4a8a5d42@xps13>
In-Reply-To: <20181217223430.182d01d8@nic.cz>
References: <20181212102142.16053-1-miquel.raynal@bootlin.com>
 <20181212102142.16053-4-miquel.raynal@bootlin.com>
 <20181214014701.373b220b@nic.cz> <20181214015712.31f749ea@nic.cz>
 <20181217170724.58421a29@xps13> <20181217223430.182d01d8@nic.cz>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_001840_555998_E4F915EE 
X-CRM114-Status: GOOD (  12.70  )
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

SGkgTWFyZWssCgpNYXJlayBCZWh1biA8bWFyZWsuYmVodW5AbmljLmN6PiB3cm90ZSBvbiBNb24s
IDE3IERlYyAyMDE4IDIyOjM0OjMwCiswMTAwOgoKPiBNaXF1ZWwsCj4gCj4gSSB0cmllZCB0aGUg
cGF0Y2hlcyBhbmQgdGhleSBhcmUgd29ya2luZywgd2l0aCB0aGUgZXhjZXB0aW9uIG9mIENvbXBl
eAo+IFdMRTkwMFggY2FyZCwgYnV0IHdlIGtub3cgdGhhdCB0aGlzIGNhcmQgaXMgcHJvYmxlbWF0
aWMuCgpIb3cgZGlkIHlvdSB0ZXN0IHRoZW0/IEkgYW0gc3VycHJpc2VkIHRoYXQgQ09NUEhZIGNh
bGxzIHdvcmtlZCBmb3IgeW91Cm91dCBvZiB0aGUgYm94LiBJIGFtIG5vdCBzdXJlIHlvdSBoYXZl
IEEzNzAwIENPTVBIWSBzdXBwb3J0IGluIHlvdXIgQVRGCmJ1dCBpdCBwcm9iYWJseSB3b3JrIGJl
Y2F1c2UgVS1Cb290IGlzIGRvaW5nIHRoZSBpbml0aWFsIGNvbmZpZ3VyYXRpb24uCgo+IEkgYW0g
aW50ZXJlc3RpbmcgaWYgdGhlcmUgaXMgYSBrbm93biB3YXkgdG8gdHVybiBvZiB0aGUgY29tcGh5
IG9uCj4gQTM3MjAsIG9yIGF0IGxlYXN0IGNoYW5nZSB0aGUgU0dNSUkgbW9kZSBmcm9tIDFHYnBz
IHRvIDIuNUdicHMgYW5kCj4gYmFjay4gTWFydmVsbCBkb2N1bWVudGF0aW9uIGRvZXMgbm90IHBy
b3ZpZGUgdGhpcyBpbmZvcm1hdGlvbiBhbmQgdGhlCj4gY29kZSBpbiBBVEYgcHJvdmlkaW5nIHRo
ZSBTTUMgY2FsbHMgZG9lcyBub3QgZG8gdGhpcyBlaXRoZXIuCj4gRG8geW91IGtub3cgaG93IHRo
aXMgY2FuIGJlIGFjaGlldmVkPwoKVGhlIGRyaXZlciBhbHJlYWR5IGhhbmRsZXMgdGhlc2UgY2Fs
bHMgKHNlZSBbMV0pLCBtYWtpbmcgdXNlIG9mCnRoZW0gaXMganVzdCBhIG1hdHRlciBvZiBoYWNr
aW5nIGludG8gZHJpdmVycyAoaW4geW91ciBjYXNlLCBJCnN1cHBvc2UgaXQgaXMgbXZuZXRhKSBh
bmQgYWRkIHBoeV9zZXRfbW9kZSgpL3BoeV9wb3dlcl9vbigpIGNhbGxzLgoKWzFdIGh0dHBzOi8v
Z2l0aHViLmNvbS9taXF1ZWxyYXluYWwvbGludXgvYmxvYi9tYXJ2ZWxsL3BoeS1uZXh0L3BtL2Ry
aXZlcnMvcGh5L21hcnZlbGwvcGh5LW12ZWJ1LWEzNzAwLWNvbXBoeS5jI0wxODkKCgpUaGFua3Ms
Ck1pcXXDqGwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LWFybS1rZXJuZWwK

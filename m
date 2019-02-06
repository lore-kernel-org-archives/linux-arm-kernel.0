Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC70C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:47:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8CCD20844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VZzWc3Re"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8CCD20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xWvDt5tUXa3Q73dud+kyb+zLhpYpI/7oHvomKbb/+l4=; b=VZzWc3Rei+50n6
	4/mFZyeyUb7JqVoavemxas5+JWqV0mAjzPLQklcXT4KUgBaAJM82jdcBI958pma+n9fbTtbvno1cO
	jedJCEUAPyZ8RvdBj5qPhqheWCvjcGxz3wRSggJ5XTFkohHUO1NUYML/nec9VFYPG3QbmIbux9lBQ
	RTCRYkijqkaPNcbUvMcM5xN85HdJGFvHfWBBO1UGUtPk6P++dnTIDT7yhN7pAxU8EMSGcNTVXB1Bw
	5PV/M+Gex0YOr+zsQaRRfxhY71SdG72DRAjI7jAxdAfnljA0Stc2C6dM2k1EImSan8SlFKSZ79lui
	k4Uaf1DFe4RPK/+jgAPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grJnD-00062d-2u; Wed, 06 Feb 2019 09:46:55 +0000
Received: from relay9-d.mail.gandi.net ([217.70.183.199])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grJn5-0005u5-QA
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 09:46:52 +0000
X-Originating-IP: 109.213.164.40
Received: from localhost (alyon-652-1-53-40.w109-213.abo.wanadoo.fr
 [109.213.164.40]) (Authenticated sender: gregory.clement@bootlin.com)
 by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 8C1D1FF803;
 Wed,  6 Feb 2019 09:46:33 +0000 (UTC)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jens Axboe <axboe@kernel.dk>, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 6/7] ARM64: dts: marvell: armada-37xx: declare SATA
 clock
In-Reply-To: <20181204192831.12440-7-miquel.raynal@bootlin.com>
References: <20181204192831.12440-1-miquel.raynal@bootlin.com>
 <20181204192831.12440-7-miquel.raynal@bootlin.com>
Date: Wed, 06 Feb 2019 10:46:32 +0100
Message-ID: <8736p18d1j.fsf@FE-laptop>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_014648_413617_2D898C47 
X-CRM114-Status: GOOD (  12.85  )
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
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgTWlxdWVsLAogCiBPbiBtYXIuLCBkw6ljLiAwNCAyMDE4LCBNaXF1ZWwgUmF5bmFsIDxtaXF1
ZWwucmF5bmFsQGJvb3RsaW4uY29tPiB3cm90ZToKCj4gVGhlIFNBVEEgSVAgZ2V0IGl0cyBjbG9j
ayBmcm9tIHRoZSBub3J0aC1icmlkZ2UuCj4KPiBTaWduZWQtb2ZmLWJ5OiBNaXF1ZWwgUmF5bmFs
IDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPgoKQXBwbGllZCB0byBtdmVidS9kdDY0CgpUaGFu
a3MsCgpHcmVnb3J5Cj4gLS0tCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEt
Mzd4eC5kdHNpIHwgMSArCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+Cj4gZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtMzd4eC5kdHNpIGIv
YXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS0zN3h4LmR0c2kKPiBpbmRleCAwMzZk
NmZkNmM5ZWYuLjY1YmY3NzQ1MTZlYyAxMDA2NDQKPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRz
L21hcnZlbGwvYXJtYWRhLTM3eHguZHRzaQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFy
dmVsbC9hcm1hZGEtMzd4eC5kdHNpCj4gQEAgLTM4OSw2ICszODksNyBAQAo+ICAJCQkJY29tcGF0
aWJsZSA9ICJtYXJ2ZWxsLGFybWFkYS0zNzAwLWFoY2kiOwo+ICAJCQkJcmVnID0gPDB4ZTAwMDAg
MHgxNzg+Owo+ICAJCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDI3IElSUV9UWVBFX0xFVkVMX0hJ
R0g+Owo+ICsJCQkJY2xvY2tzID0gPCZuYl9wZXJpcGhfY2xrIDE+Owo+ICAJCQkJc3RhdHVzID0g
ImRpc2FibGVkIjsKPiAgCQkJfTsKPiAgCj4gLS0gCj4gMi4xOS4xCj4KCi0tIApHcmVnb3J5IENs
ZW1lbnQsIEJvb3RsaW4KRW1iZWRkZWQgTGludXggYW5kIEtlcm5lbCBlbmdpbmVlcmluZwpodHRw
Oi8vYm9vdGxpbi5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LWFybS1rZXJuZWwK

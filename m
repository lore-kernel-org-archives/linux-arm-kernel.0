Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB82C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:39:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A973208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CLQaHQPg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A973208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=imnLcYlVr8e35hxMEDPiRLIl6XMu1GNsEEXrS7JEBH8=; b=CLQaHQPgFvaquC
	pJ/rmeibM6K6EHW+rEVTFLhsASAA2GyCwwFEd9xCtViOJ3Z0FtwytndvEm3ajx28rzpHlDZJyqXBx
	11Sv/653wGKkmAgdFEVX6d8hPs8tPaMrUaAj9HiCrXIRFvGzCQBbiiJxT+/Aqx30sOwpuiIQPDvy/
	Ya415zENojPWBJM2+D7sBOwx+d/qexMl6yS8W4t3wmab6SnLfPmT713LJYnN1E9yEhdfT/qaXya+9
	pWUMTEgJ8jtyD7e9ilqsrl1QRBUOyO3e5AhsN1XBjuo00+bf+QDs6Sb0E0jZ/hKkhTD+eEIyGuK8n
	QDc7d8CN1HJK2qYlp2xg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf49H-00018a-Fq; Thu, 03 Jan 2019 14:39:03 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf49E-00017p-LN
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 14:39:02 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id A5686207BE; Thu,  3 Jan 2019 15:38:57 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-29-148.w90-88.abo.wanadoo.fr
 [90.88.149.148])
 by mail.bootlin.com (Postfix) with ESMTPSA id 5ACF720714;
 Thu,  3 Jan 2019 15:38:57 +0100 (CET)
Date: Thu, 3 Jan 2019 15:38:57 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH 0/3] Few fix for pins configuration on Armada 37xx
Message-ID: <20190103153857.073d4e34@xps13>
In-Reply-To: <20181221173259.8372-1-gregory.clement@bootlin.com>
References: <20181221173259.8372-1-gregory.clement@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_063900_839993_CB7E426C 
X-CRM114-Status: UNSURE (   8.87  )
X-CRM114-Notice: Please train this message.
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
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, linux-gpio@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Marcin Wojtas <mw@semihalf.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgR3JlZ29yeSwKCkdyZWdvcnkgQ0xFTUVOVCA8Z3JlZ29yeS5jbGVtZW50QGJvb3RsaW4uY29t
PiB3cm90ZSBvbiBGcmksIDIxIERlYyAyMDE4CjE4OjMyOjU2ICswMTAwOgoKPiBIZWxsbywKPiAK
PiB0aGlzIHNtYWxsIHNlcmllcyBmaXhlcyB3cm9uZyBwaW5zIGNvbmZpZ3VyYXRpb24gd2UgY3Vy
cmVudGx5IGhhdmUgb24KPiBBcm1hZGEgMzd4eC4KPiAKPiBGb3Igbm93IGl0IGlzIGVzcGVjaWFs
bHkgYW5ub3lpbmcgaXQgd2Ugd2FudCB0byBlbmFibGUgc3VzcGVuZCB0bwo+IFJBTSBmb3IgUENp
ZS4KClRoYW5rcyBmb3IgdGhlIHNlcmllcywgaXQgd29ya3MgZm9yIG1lLgoKVGVzdGVkLWJ5OiBN
aXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPgoKClRoYW5rcywKTWlxdcOo
bAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
YXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJt
LWtlcm5lbAo=

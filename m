Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4A1C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:46:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42F10214DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PS5eVqv1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F10214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MZwiaf6uf+DT/ytQIm3frPSs1sJWdET+bNlT26L0iDA=; b=PS5eVqv10Y9rkw
	17K0nwAbcIiWbdhuOqOv53GwQqwhNIYS5h+TzkRL61BYxA2mW/bYJYvVRL5YaZ6TmJWK6gsxBxvlb
	IaT1F6tE4urlQ+BjBy4IZsCRgY4UxUUHuzF/NUs3j8ZUlarNTuFnZfQbemLarOubk5ifXpzyQsYjU
	lMzgLsU5UsVNXEffzjAPTkrXPVRZeDdE/kaJxOscQJeS8o8HWVYLuNqeiXhsFYWdFmAAFzLqv53EL
	RdFzT5AMO70R0BvzGSYl5U23revdGCGE3o9inQVG7+/HsMXVfc3W4dFi26H4aVVH87yzCbhURbCHZ
	vAR5VEIds3bnDgkEzWug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUnQN-0006CN-Q5; Thu, 06 Dec 2018 06:46:15 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUnQI-0006BV-0k; Thu, 06 Dec 2018 06:46:14 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 409E220734; Thu,  6 Dec 2018 07:45:56 +0100 (CET)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
 by mail.bootlin.com (Postfix) with ESMTPSA id E0C6D20729;
 Thu,  6 Dec 2018 07:45:55 +0100 (CET)
Date: Thu, 6 Dec 2018 07:45:54 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: Re: [PATCH v5 0/7] spi: add support for octal mode
Message-ID: <20181206074554.0ec0aecb@bbrezillon>
In-Reply-To: <VI1PR04MB572646B71C6CB7BAAB4A1E1999A90@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20181203101937.7b01a0ad@bbrezillon>
 <214dadd9-859c-ca88-1aff-1c83fcfa3c0b@ti.com>
 <20181205134618.56223758@bbrezillon>
 <VI1PR04MB572646B71C6CB7BAAB4A1E1999A90@VI1PR04MB5726.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_224610_196995_9CB3AE2C 
X-CRM114-Status: GOOD (  13.00  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Vignesh R <vigneshr@ti.com>, "robh@kernel.org" <robh@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
 "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 6 Dec 2018 04:20:26 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Hi Boris,
> 
> > -----Original Message-----
> > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > Sent: Wednesday, December 5, 2018 6:16 PM
> > To: Vignesh R <vigneshr@ti.com>; broonie@kernel.org
> > Cc: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>; linux-
> > mtd@lists.infradead.org; marek.vasut@gmail.com; linux-spi@vger.kernel.org;
> > devicetree@vger.kernel.org; robh@kernel.org; mark.rutland@arm.com;
> > shawnguo@kernel.org; linux-arm-kernel@lists.infradead.org;
> > computersforpeace@gmail.com; frieder.schrempf@exceet.de; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH v5 0/7] spi: add support for octal mode
> > 
> > On Wed, 5 Dec 2018 17:25:12 +0530
> > Vignesh R <vigneshr@ti.com> wrote:
> >   
> > > >>   mtd: spi-nor: add opcodes for octal Read/Write commands
> > > >>   mtd: spi-nor: add octal read flag for flash mt35xu512aba  
> > >
> > > Could you consider merging these two patches alone for v4.21?
> > > These can be applied independent of other patches in the series and
> > > would allow supporting OSPI flash at SPI NOR level with Cadence QSPI driver.  
> > 
> > Yep, I'll queue them to spi-nor/next.
> >   
> > > >>   spi: nxp-fspi: add octal mode flag bit for octal support  
> > 
> > Mark, I think you can pick this one too.  
> 
> This patch is dependent on the series [1] which is yet to be applied by you, please apply.

By me? I can't apply SPI patches.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

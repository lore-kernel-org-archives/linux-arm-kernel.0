Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A046C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:56:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E36B208A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uGiiPohH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sr2JLzEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E36B208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=95MCms934rW1t7vwXGkDUNq3GhGItON8tiKJgCRFOk0=; b=uGiiPohHYLO3cM
	pb3OpGnOz51n+k/dEtzdId7M17lXEQRp/0HM8RrppptfRiQVSilcOHWMp7MLaUHRMHEnACEA7URnG
	x7iLzdNv1cteeFwJ8L23j9KiAcUKRWjukDYgHw1nvYsyrFh5aPwuU9Kj/tGnucA1G48K1YKScfLYE
	37YAhMyzQgCJimPzkAgEbYU+q+pVei5qRZEAH3UQz7umWRRrozu2Y2QZ8/0kS+woG47K25G4M+tHQ
	u3kHYcqSlUuBgWGVxtaZd8eLwYRlcPYYIcQJGr7JZjgECS6lHRe89Bn8LkvrbvaEnr/PUXXRAkWm/
	tOcYxs5itWA+Si49uZPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTtNl-0000e7-IG; Mon, 03 Dec 2018 18:55:49 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTtNi-0000dP-0I
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 18:55:47 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 795B4208A3;
 Mon,  3 Dec 2018 18:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543863335;
 bh=e1HS1dfwn1OAMmZAaiTUcAcuQiSS0bRtNxOfrQ40UsI=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=sr2JLzEY3d+bOJPIsrZ/nBZpxB/NuclcRIWotToXOUzm1iyWehhLMV5qSifie62SC
 nELJnIF7OD8wE8kRKcsrHQJiRl5117wjMK6AWBYr2qg/C/tavxGq6twkpC8laGzpcr
 FqhPtnPhw6nqZ4r2es5Tf3wu4PfsE7AvaTdiO7c0=
MIME-Version: 1.0
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Aisheng DONG <aisheng.dong@nxp.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <AM0PR04MB4211E36F9553E16A196C101C80DA0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1541862894-8209-1-git-send-email-aisheng.dong@nxp.com>
 <1541862894-8209-7-git-send-email-aisheng.dong@nxp.com>
 <154223811948.88331.8860718270277533070@swboyd.mtv.corp.google.com>
 <AM0PR04MB4211A7CA91D6188AB81BA6EA80DC0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <154274014557.88331.17188709471206009766@swboyd.mtv.corp.google.com>
 <AM0PR04MB4211E36F9553E16A196C101C80DA0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <154386333481.88331.9590400147413133304@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: RE: [PATCH V6 6/6] clk: imx: add imx8qxp lpcg driver
Date: Mon, 03 Dec 2018 10:55:34 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_105546_080859_E71B7AF9 
X-CRM114-Status: GOOD (  20.22  )
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
Cc: "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Aisheng DONG (2018-11-20 17:50:47)
> > -----Original Message-----
> > From: Stephen Boyd [mailto:sboyd@kernel.org]
> [...]
> > > > > +
> > > > > +       ss_lpcg = of_device_get_match_data(dev);
> > > > > +       if (!ss_lpcg)
> > > > > +               return -ENODEV;
> > > > > +
> > > > > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > > > +       base = devm_ioremap(dev, res->start, resource_size(res));
> > > >
> > > > Why not devm_ioremap_resource()?
> > >
> > > Because LPCGs are distributed in various subsystem memory space which
> > > may be overlapped with some IP modules. So we can't use
> > > devm_ioremap_resource which has a request_mem_region() in it.
> > > It's something like what we've done for drivers/mfd/syscon.c.
> > 
> > Ok. Any chance that the various subsystems that are combined with the clk
> > controller can be split up so that we can use
> > devm_ioremap_resource() here? 
> 
> We can achieve that by describing each LPCGS node in devicetree, but that would
> bloat the Devicetree seriously as we have hundreds of LPCGS.
> 
> This is similar as what we did for legacy SoCs, e.g MX7D.
> The difference is that on MX7D LPCGS are continuous.
> e.g.
> Table 5-19. CCGR Mapping Table
> Gating Register LPCG Enable Offset
> CCM_CCGR4 sim_main 0x4040
> CCM_CCGR5 sim_display 0x4050
> ...
> CCM_CCGR168 iomux 0x4A80
> CCM_CCGR169 iomux_lpsr 0x4A90
> CCM_CCGR170 kpp 0x4AA0
> 
> But on MX8QXP/QM, they're not continuous anymore and distributed in each SS.
> And we probably want to push our IC designer to re-orgnize them into a continuous
> memory map again for new chips in the future.
> 
> So do you think we can start with this way for MX8 as well?
> Then we won't block MX8QXP booting up too long or probably could improve it
> Later.

Ok, I don't really understand the memory map of this SoC. I wouldn't
push the IC designer to reorganize everything. I'd push the designer to
make clock controller hw blocks, maybe even one per subsystem is OK, and
then have that build on basic clk types that the clock controller
drivers could use to implement the clk support.

Either way, this hardware must already exist so I think we're done here.
I'm OK with whatever works at this point.

> 
> > It may be better to carve up the I/O space of
> > this SoC into device nodes that map to the hardware IP blocks, and then have
> > those device drivers generate sub-devices for the various logical subsystems
> > that the hardware IP spans. Or it could be a big driver that registers with
> > multiple subsytems/frameworks from one device driver. This way, the logical
> > structure of the linux kernel device driver design doesn't leak into the DT
> > description of the SoC.
> > 
> 
> Yes, we currently already describe them with each subsystems in Devicetree.
> https://patchwork.kernel.org/patch/10677311/
> 

Ok.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F87C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:25:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23AB82086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F8C8aYMf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8/Os+31"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23AB82086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:References:From:Subject:To:
	Message-ID:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kLPUfDMBY6yCqWv8MVVVYCKzC2yztSRcjaD0Rrn/weA=; b=F8C8aYMfZm7JhT
	Wcg3IZWe8qG4/jlkbtuvF4I2KPjrXrsLsPDHwsYo+vw3kLDU1Hh8vsS4B9Pa9vp+ZTmZbLcjp36Cv
	/hhfo4nCmav0trQogU9lc/1YUiAqtSZp/6yN/47pLkBFifzeLC13n1R+IGynVV3NsxExv1zzw/koi
	SeiSUCNExUcLsk8az0qLfHW0uSbSSFohnHHCVv9HX5APPnth/raq8nr++wpu9HiG3CsUHUwSz2z/z
	LHbittm3OcAurSQaYOoH1bscv33bJkUvKYQr251IBM7RngUjORaKK4+EZ6oGGGc0lXoLfeAoNnHem
	msc8Ek152r23lUpFlN8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXCwb-0008E4-5f; Wed, 12 Dec 2018 22:25:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCv5-00064X-Vs
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:24:18 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1AF3120672;
 Wed, 12 Dec 2018 22:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544653425;
 bh=l9MQGS+qOpU8T4nMV6gHPxzE28YMdLd/M6YGRO0B1lc=;
 h=In-Reply-To:To:Subject:From:References:Cc:Date:From;
 b=e8/Os+31jKBEg06OUq0jkkhC0FaVlBIlYxMGAejCYGIRPM3Pl4HpjZyhNOP8VIIKr
 fTAHD33r4y6jAM6M+cjh0hV7qHKCx0TK2Eup5HvD+215fS5jPvRKqk/ycB/9B7pxG9
 LYyQNGyEQRTw5N2YBQsEK+C0jKaWfajJ5uttBV3g=
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4211C8B8DC2D5F2133D30B9F80A70@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <154465342417.17204.9306702088509412293@swboyd.mtv.corp.google.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [PATCH V9 1/7] clk: imx: add configuration option for mmio clks
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.7
References: <1543934041-12572-1-git-send-email-aisheng.dong@nxp.com>
 <1543934041-12572-2-git-send-email-aisheng.dong@nxp.com>
 <154447530435.17204.3027810086542897433@swboyd.mtv.corp.google.com>
 <AM0PR04MB4211B87A842FB8AF14621E3380A60@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <154455657071.17204.2493209125185218529@swboyd.mtv.corp.google.com>
 <AM0PR04MB4211D9C32A4DDCCF266B60C380A70@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB4211C8B8DC2D5F2133D30B9F80A70@AM0PR04MB4211.eurprd04.prod.outlook.com>
Date: Wed, 12 Dec 2018 14:23:44 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_142356_675349_DD75E96C 
X-CRM114-Status: GOOD (  19.08  )
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

Quoting Aisheng Dong (2018-12-12 02:27:24)
> Hi Stephen,
> 
> > > > > > diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> > > > > > index
> > > > > > 5c0b11e..f850424 100644
> > > > > > --- a/drivers/clk/imx/Makefile
> > > > > > +++ b/drivers/clk/imx/Makefile
> > > > > > @@ -1,6 +1,6 @@
> > > > > >  # SPDX-License-Identifier: GPL-2.0
> > > > > >
> > > > > > -obj-y += \
> > > > > > +obj-$(CONFIG_MXC_CLK) += \
> > > > >
> > > > > Because this changes to obj-$(CONFIG) we should change the
> > > > > drivers/clk/Makefile to have obj-y for this Makefile instead of
> > > > > depending on ARCH_MXC.
> > > >
> > > > We also use ARCH_MXC for ARMv8 SoC clocks.
> > >
> > > Yes, and? I'm suggesting drivers/clk/Makefile have an obj-y +=
> > > drivers/clk/imx/ and then decide to compile or not compile the MXC_CLK
> > > "core" bits based on CONFIG_MXC_CLK config option.
> > 
> > Sorry for the missunderstanding before.
> > I guess you point is have an ojb-y += drivrs/clk/imx/ Then in
> > drivers/clk/imx/Kconfig config MXC_CLK
> >               def_bool ARCH_MXC && !ARM64
> >               select MXC_clk bits
> > config MXC_CLK_SCU
> >               def_bool ARCH_MXC && ARM64
> >               select SCU clock bits
> > 
> > If wrong please let me know.
> > 
> > Will update the patch series and re-send.
> > Thanks for the suggestion.

Yes that looks like what I'm asking for.

> > 
> 
> I tried and met another problem that MX8MQ (ARM64) is also
> using legacy MXC_CLK. (And 3 more MX8M series based chips.)
> 
> That means I have to write something like:
> config MXC_CLK
>         bool
>         def_bool (ARCH_MXC && !ARM64) || (ARCH_MXC && ARM64 && SOC_IMX8MQ)
> 
> config MXC_CLK_SCU
>         bool
>         def_bool (ARCH_MXC && ARM64 && !SOC_IMX8MQ)
> 
> But it can't work as ARM64 supports multiplatforms.
> e.g. we have also SOC_IMX8QXP, SOC_IMX8QM, SOC_IMX8DM ...
> 
> Do you have a suggestion about this?
> 

Can you put the enabling of MXC_CLK_SCU in the defconfig and exposed it
as a user selectable option? And keep hiding the MXC_CLK option behind
the def_bool? I hope that MXC_CLK could be user selectable eventually,
but the def_bool is there to make it easier to bridge the transition and
update everyone's defconfigs while it is moved into the defconfig.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

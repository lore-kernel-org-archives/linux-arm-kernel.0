Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F97C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:15:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E21BB2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IXoQahqP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E21BB2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZCX7mxvZJIciM8o3W5MVKaxjgid5aNpmhOlhazsdedk=; b=IXoQahqPPOQxpY
	1NTuAZD1RJPKUA/fg1GQZ3NX519legQkrZlfQBjCZxp7zSEJGRNWGBygfpptuAEqT7fCFzhACU63K
	l4hejVlcXR/cn8XZnebyQnZ1o6mBZ2ksnSTLT6pbrPecrbP+ayRtd69bqQkzTX0EDAVFc0OJjISrT
	Cxb0EFB9IPYLqvdEpnTlV9eZ6mdjCROH8r7U35CmTpFY5Eu1+wo/SyC5y+K6mFUTGZ5hT2lxYTaH5
	HsPGKGk+cufZ8R7ppUypZ6Q4xTdDSbLfx560ZcA0yiSv+SQuaMzVEyvVRDjzqosJL8iOr5m+xVn1/
	LUi3q6nGiixGe6hD1mOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goly0-0003em-EW; Wed, 30 Jan 2019 09:15:32 +0000
Received: from honk.sigxcpu.org ([24.134.29.49])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1golxv-0003dJ-1C
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 09:15:30 +0000
Received: from localhost (localhost [127.0.0.1])
 by honk.sigxcpu.org (Postfix) with ESMTP id 30CC4FB03;
 Wed, 30 Jan 2019 10:15:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
 by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4hGbEfnpr_UF; Wed, 30 Jan 2019 10:15:21 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
 id 325F5420A6; Wed, 30 Jan 2019 10:15:21 +0100 (CET)
Date: Wed, 30 Jan 2019 10:15:21 +0100
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/2] phy: Add driver for mixel dphy
Message-ID: <20190130091521.GA10544@bogon.m.sigxcpu.org>
References: <cover.1548410989.git.agx@sigxcpu.org>
 <bbefc77a437bd21bfe1c27b15f65b57e7714b18a.1548410989.git.agx@sigxcpu.org>
 <CAOMZO5B9uMZuZX_QkGzMiLC=hKzsuEyD_3DXxakEATO1rNK_Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOMZO5B9uMZuZX_QkGzMiLC=hKzsuEyD_3DXxakEATO1rNK_Cw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_011527_401866_9FEC23F6 
X-CRM114-Status: GOOD (  24.06  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
 Robert Chiras <robert.chiras@nxp.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 DRI mailing list <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,
On Mon, Jan 28, 2019 at 01:10:45PM -0200, Fabio Estevam wrote:
> Hi Guido,
> =

> On Fri, Jan 25, 2019 at 8:15 AM Guido G=FCnther <agx@sigxcpu.org> wrote:
> =

> > +config PHY_MIXEL_MIPI_DPHY
> > +       bool
> > +       depends on OF
> > +       select GENERIC_PHY
> > +       select GENERIC_PHY_MIPI_DPHY
> > +       default ARCH_MXC && ARM64
> =

> No need to force this selection for all i.MX8M boards, as not everyone
> is interested in using Mixel DSI.
> =

> > --- /dev/null
> > +++ b/drivers/phy/phy-mixel-mipi-dphy.c
> > @@ -0,0 +1,449 @@
> > +/*
> > + * Copyright 2017 NXP
> > + * Copyright 2019 Purism SPC
> > + *
> > + * SPDX-License-Identifier: GPL-2.0
> =

> SPDX line should be in the first line and start with //
> =

> > + */
> > +
> > +/* #define DEBUG 1 */
> =

> Please remove it.
> =

> > +/* DPHY registers */
> > +#define DPHY_PD_DPHY                   0x00
> > +#define DPHY_M_PRG_HS_PREPARE          0x04
> > +#define DPHY_MC_PRG_HS_PREPARE         0x08
> > +#define DPHY_M_PRG_HS_ZERO             0x0c
> > +#define DPHY_MC_PRG_HS_ZERO            0x10
> > +#define DPHY_M_PRG_HS_TRAIL            0x14
> > +#define DPHY_MC_PRG_HS_TRAIL           0x18
> > +#define DPHY_PD_PLL                    0x1c
> > +#define DPHY_TST                       0x20
> > +#define DPHY_CN                                0x24
> > +#define DPHY_CM                                0x28
> > +#define DPHY_CO                                0x2c
> > +#define DPHY_LOCK                      0x30
> > +#define DPHY_LOCK_BYP                  0x34
> > +#define DPHY_TX_RCAL                   0x38
> > +#define DPHY_AUTO_PD_EN                        0x3c
> > +#define DPHY_RXLPRP                    0x40
> > +#define DPHY_RXCDRP                    0x44
> =

> In the NXP vendor tree we have these additional offsets for imx8m that
> are missing here:
> =

> .reg_rxhs_settle =3D 0x48,
> .reg_bypass_pll =3D 0x4c,
> =

> > +#define MBPS(x) ((x) * 1000000)
> > +
> > +#define DATA_RATE_MAX_SPEED MBPS(1500)
> > +#define DATA_RATE_MIN_SPEED MBPS(80)
> > +
> > +#define CN_BUF 0xcb7a89c0
> > +#define CO_BUF 0x63
> > +#define CM(x)  (                               \
> > +               ((x) <  32)?0xe0|((x)-16) :     \
> > +               ((x) <  64)?0xc0|((x)-32) :     \
> > +               ((x) < 128)?0x80|((x)-64) :     \
> > +               ((x) - 128))
> > +#define CN(x)  (((x) =3D=3D 1)?0x1f : (((CN_BUF)>>((x)-1))&0x1f))
> > +#define CO(x)  ((CO_BUF)>>(8-(x))&0x3)
> > +
> > +static inline u32 phy_read(struct phy *phy, unsigned int reg)
> > +{
> > +       struct mixel_dphy_priv *priv =3D phy_get_drvdata(phy);
> > +
> > +       return readl(priv->regs + reg);
> =

> Maybe it's worth using regmap here. It makes it very easy to dump all
> the MIXEL registers at once.
> =

> > +static int mixel_dphy_config_from_opts(struct phy *phy,
> > +              struct phy_configure_opts_mipi_dphy *dphy_opts,
> > +              struct mixel_dphy_cfg *cfg)
> > +{
> > +       struct mixel_dphy_priv *priv =3D dev_get_drvdata(phy->dev.paren=
t);
> > +       unsigned long ref_clk =3D clk_get_rate(priv->phy_ref_clk);
> > +       int i;
> > +       unsigned long numerator, denominator, frequency;
> > +       unsigned step;
> > +
> > +       if (dphy_opts->hs_clk_rate > DATA_RATE_MAX_SPEED ||
> > +           dphy_opts->hs_clk_rate < DATA_RATE_MIN_SPEED)
> > +               return -EINVAL;
> > +       cfg->hs_clk_rate =3D dphy_opts->hs_clk_rate;
> > +
> > +       numerator =3D dphy_opts->hs_clk_rate;
> > +       denominator =3D ref_clk;
> > +       get_best_ratio(&numerator, &denominator, 255, 256);
> > +       if (!numerator || !denominator) {
> > +               dev_dbg(&phy->dev, "Invalid %ld/%ld for %ld/%ld\n",
> =

> dev_err should be more appropriate here.
> =

> > +static int mixel_dphy_ref_power_on(struct phy *phy)
> > +{
> > +       struct mixel_dphy_priv *priv =3D phy_get_drvdata(phy);
> > +       u32 lock, timeout;
> > +       int ret =3D 0;
> > +
> > +       mutex_lock(&priv->lock);
> > +       clk_prepare_enable(priv->phy_ref_clk);
> > +
> > +       phy_write(phy, PWR_ON, DPHY_PD_DPHY);
> > +       phy_write(phy, PWR_ON, DPHY_PD_PLL);
> > +
> > +       timeout =3D 100;
> > +       while (!(lock =3D phy_read(phy, DPHY_LOCK))) {
> > +               udelay(10);
> > +               if (--timeout =3D=3D 0) {
> > +                       dev_err(&phy->dev, "Could not get DPHY lock!\n"=
);
> > +                       mutex_unlock(&priv->lock);
> > +                       return -EINVAL;
> =

> Could you use readl_poll_timeout() instead?
> =

> > +static int mixel_dphy_ref_power_off(struct phy *phy)
> > +{
> > +       struct mixel_dphy_priv *priv =3D phy_get_drvdata(phy);
> > +       int ret =3D 0;
> =

> This variable is not needed.
> =

> > +
> > +       mutex_lock(&priv->lock);
> > +
> > +       phy_write(phy, PWR_OFF, DPHY_PD_PLL);
> > +       phy_write(phy, PWR_OFF, DPHY_PD_DPHY);
> > +
> > +       clk_disable_unprepare(priv->phy_ref_clk);
> > +       mutex_unlock(&priv->lock);
> > +
> > +       return ret;
> =

> and you could simply do a 'return 0' instead.
> =

> > +       phy_write(phy, 0x00, DPHY_LOCK_BYP);
> > +       phy_write(phy, 0x01, DPHY_TX_RCAL);
> > +       phy_write(phy, 0x00, DPHY_AUTO_PD_EN);
> > +       phy_write(phy, 0x01, DPHY_RXLPRP);
> > +       phy_write(phy, 0x01, DPHY_RXCDRP);
> =

> In the NXP vendor code the value 2 is written to this register:
> =

> phy_write(phy, 0x02, priv->plat_data->reg_rxcdrp);
> =

> It would be good to dump all Mixel DSI PHY registers in the NXP vendor
> and in mainline and make sure they match.

Seems some of these changed quite a bit between the 4.9 and 4.14 NXP
tree. I'll update things accordingly (and address the other stuff as
well).
 -- Guido

> =

> > +       priv->regs =3D devm_ioremap(dev, res->start, SZ_256);
> =

> No need to hardcode SZ_256 here and the size should come from the device =
tree.
> =

> You could also use devm_ioremap_resource() instead.
> =


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

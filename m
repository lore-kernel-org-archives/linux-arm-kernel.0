Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BBAC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:54:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B01A8218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SyEy19Pb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01A8218CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YZcWBeHgmKFAj1Ws8rAysr8WICkX7m++uGYcpkTHcdI=; b=SyEy19PbapyRy2
	U4FnfHpnkqJadMsCpce2T4OF5pb7RLWcd/xH7mFFzohqleVUKvAO96kaaUMKETdUzi1s54l0LeGm2
	E8tOV4YLVp72xT30OgQqUMb9n6JVsCt8SIGKLyB8f1AWAxnJcPEzFUBa8g8/jfPQb9z0ph8Ycfgpm
	ACGRwxPSlV+eKUp7CKUIFUBG19H6/TSSghPxC22ghhsTppIcmmh8Txaex+x1crggkSW4Buf11sD2W
	ang8wN9OpHITzbjp2Mg/lTAYCI9VGgyGc2xPJ7f+ObMclR2yngIFLuBi4A4L980XgFi1wAU30Wwwv
	ZfE1JjA8U9gQqUI7+E4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn4k0-0004Yk-Tu; Fri, 25 Jan 2019 16:54:04 +0000
Received: from asavdk3.altibox.net ([109.247.116.14])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn4jw-0004YP-LH
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 16:54:03 +0000
Received: from ravnborg.org (unknown [158.248.194.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by asavdk3.altibox.net (Postfix) with ESMTPS id 1431A20050;
 Fri, 25 Jan 2019 17:53:56 +0100 (CET)
Date: Fri, 25 Jan 2019 17:53:55 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Subject: Re: [PATCH 2/2] phy: Add driver for mixel dphy
Message-ID: <20190125165355.GA3522@ravnborg.org>
References: <cover.1548410989.git.agx@sigxcpu.org>
 <bbefc77a437bd21bfe1c27b15f65b57e7714b18a.1548410989.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bbefc77a437bd21bfe1c27b15f65b57e7714b18a.1548410989.git.agx@sigxcpu.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
 a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
 a=8nJEP1OIZ-IA:10 a=ze386MxoAAAA:8 a=e5mUnYsNAAAA:8
 a=wTxEHkJ9yh_FIgG7YY4A:9 a=wPNLvfGTeEIA:10 a=iBZjaW-pnkserzjvUTHh:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_085401_057026_A0915539 
X-CRM114-Status: GOOD (  36.34  )
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
 Robert Chiras <robert.chiras@nxp.com>, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Guido.

Patch looks good but a few comments below.

	Sam

On Fri, Jan 25, 2019 at 11:14:46AM +0100, Guido G=FCnther wrote:
> This adds support for the Mixel DPHY as found on i.MX8 CPUs but since
> this is an IP core it will likely be found on others in the future. So
> instead of adding this to the nwl host driver make it a generic PHY
> driver.
> =

> The driver supports the i.MX8MQ. Support for i.MX8QM and i.MX8QXP can be
> added once the necessary system controller bits are in via
> mixel_dpy_ops.
> =

> Signed-off-by: Guido G=FCnther <agx@sigxcpu.org>
> ---
>  drivers/phy/Kconfig               |   7 +
>  drivers/phy/Makefile              |   1 +
>  drivers/phy/phy-mixel-mipi-dphy.c | 449 ++++++++++++++++++++++++++++++
>  3 files changed, 457 insertions(+)
>  create mode 100644 drivers/phy/phy-mixel-mipi-dphy.c
> =

> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 250abe290ca1..9195b5876bcc 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -48,6 +48,13 @@ config PHY_XGENE
>  	help
>  	  This option enables support for APM X-Gene SoC multi-purpose PHY.
>  =

> +config PHY_MIXEL_MIPI_DPHY
> +	bool
> +	depends on OF
> +	select GENERIC_PHY
> +	select GENERIC_PHY_MIPI_DPHY
> +	default ARCH_MXC && ARM64

Is it correct that driver is mandatory if ARCH_MXC is y?
There is no prompt to allow the user to select it.
Or in other words - will all i.MX8 user need it?

> +
>  source "drivers/phy/allwinner/Kconfig"
>  source "drivers/phy/amlogic/Kconfig"
>  source "drivers/phy/broadcom/Kconfig"
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index 0d9fddc498a6..264f570b67bf 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_ARCH_MEDIATEK)		+=3D mediatek/
>  obj-$(CONFIG_ARCH_RENESAS)		+=3D renesas/
>  obj-$(CONFIG_ARCH_ROCKCHIP)		+=3D rockchip/
>  obj-$(CONFIG_ARCH_TEGRA)		+=3D tegra/
> +obj-$(CONFIG_PHY_MIXEL_MIPI_DPHY)	+=3D phy-mixel-mipi-dphy.o
>  obj-y					+=3D broadcom/	\
>  					   cadence/	\
>  					   freescale/	\
> diff --git a/drivers/phy/phy-mixel-mipi-dphy.c b/drivers/phy/phy-mixel-mi=
pi-dphy.c
> new file mode 100644
> index 000000000000..8a43dab79cee
> --- /dev/null
> +++ b/drivers/phy/phy-mixel-mipi-dphy.c

There is already a PHY named phy-fsl-imx8mq-usb, located in the
freescale subdirectory.
Why locate another imx8 PHY in the top level directory with
another naming convention?

> @@ -0,0 +1,449 @@
> +/*
> + * Copyright 2017 NXP
> + * Copyright 2019 Purism SPC
> + *
> + * SPDX-License-Identifier: GPL-2.0
> + */
SPDX-License-Identifier goes in at first line with //.
It is documented somewhere.
Also, did you double check that GPL 2.0 is correct?

> +
> +/* #define DEBUG 1 */
There is no reference to DEBUG in this file - delete?

> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +
> +/* DPHY registers */
> +#define DPHY_PD_DPHY			0x00
> +#define DPHY_M_PRG_HS_PREPARE		0x04
> +#define DPHY_MC_PRG_HS_PREPARE		0x08
> +#define DPHY_M_PRG_HS_ZERO		0x0c
> +#define DPHY_MC_PRG_HS_ZERO		0x10
> +#define DPHY_M_PRG_HS_TRAIL		0x14
> +#define DPHY_MC_PRG_HS_TRAIL		0x18
> +#define DPHY_PD_PLL			0x1c
> +#define DPHY_TST			0x20
> +#define DPHY_CN				0x24
> +#define DPHY_CM				0x28
> +#define DPHY_CO				0x2c
> +#define DPHY_LOCK			0x30
> +#define DPHY_LOCK_BYP			0x34
> +#define DPHY_TX_RCAL			0x38
> +#define DPHY_AUTO_PD_EN			0x3c
> +#define DPHY_RXLPRP			0x40
> +#define DPHY_RXCDRP			0x44
> +
> +#define MBPS(x) ((x) * 1000000)
> +
> +#define DATA_RATE_MAX_SPEED MBPS(1500)
> +#define DATA_RATE_MIN_SPEED MBPS(80)
> +
> +#define CN_BUF	0xcb7a89c0
> +#define CO_BUF	0x63
> +#define CM(x)	(				\
> +		((x) <  32)?0xe0|((x)-16) :	\
> +		((x) <  64)?0xc0|((x)-32) :	\
> +		((x) < 128)?0x80|((x)-64) :	\
> +		((x) - 128))
> +#define CN(x)	(((x) =3D=3D 1)?0x1f : (((CN_BUF)>>((x)-1))&0x1f))
> +#define CO(x)	((CO_BUF)>>(8-(x))&0x3)
> +
> +/* PHY power on is LOW_ENABLE */
> +#define PWR_ON	0
> +#define PWR_OFF	1
> +
> +struct mixel_dphy_cfg {
> +	u32 cm;
> +	u32 cn;
> +	u32 co;
> +	unsigned long hs_clk_rate;
> +	u8 mc_prg_hs_prepare;
> +	u8 m_prg_hs_prepare;
> +	u8 mc_prg_hs_zero;
> +	u8 m_prg_hs_zero;
> +	u8 mc_prg_hs_trail;
> +	u8 m_prg_hs_trail;
> +};

For the naive reader it would be helpful to spell out the names in a commen=
t.
As I assume the names comes from the data sheet the short names are OK - but
let others know the purpose.

> +
> +struct mixel_dphy_priv;
> +struct mixel_dphy_ops {
> +	int (*probe)(struct mixel_dphy_priv *priv);
> +	int (*power_on)(struct phy *phy);
> +	int (*power_off)(struct phy *phy);
> +};
Consider same argument for all three ops, less suprises.
But then probe() is called before we have a phy, so this may be
the best option.
> +
> +struct mixel_dphy_priv {
> +	struct mixel_dphy_cfg cfg;
> +	void __iomem *regs;
> +	struct clk *phy_ref_clk;
> +	struct mutex lock;
> +	const struct mixel_dphy_ops *ops;
> +};
Document what the lock protects, or find a better name for the lock to docu=
ment it

> +
> +/* Find a ratio close to the desired one using continued fraction
> +   approximation ending either at exact match or maximum allowed
> +   nominator, denominator. */

Use kernel style comments
/*
 * Bla bla
 * more bla
 */

> +static void get_best_ratio(unsigned long *pnum, unsigned long *pdenom, u=
nsigned max_n, unsigned max_d)
Wrap line to stay below 80 chars.
Use checkpatch to help you sport things like this.

> +{
> +	unsigned long a =3D *pnum;
> +	unsigned long b =3D *pdenom;
> +	unsigned long c;
> +	unsigned n[] =3D {0, 1};
> +	unsigned d[] =3D {1, 0};
> +	unsigned whole;
> +	unsigned i =3D 1;
> +	while (b) {
Add empty line after last local variable.

> +		i ^=3D 1;
> +		whole =3D a / b;
> +		n[i] +=3D (n[i ^ 1] * whole);
> +		d[i] +=3D (d[i ^ 1] * whole);
> +		if ((n[i] > max_n) || (d[i] > max_d)) {
> +			i ^=3D 1;
> +			break;
> +		}
> +		c =3D a - (b * whole);
> +		a =3D b;
> +		b =3D c;
> +	}
> +	*pnum =3D n[i];
> +	*pdenom =3D d[i];
> +}
> +
> +static int mixel_dphy_config_from_opts(struct phy *phy,
> +	       struct phy_configure_opts_mipi_dphy *dphy_opts,
> +	       struct mixel_dphy_cfg *cfg)
> +{
Align extra paratmers below the first parameter using tabs and add necessary
spaces.

> +	struct mixel_dphy_priv *priv =3D dev_get_drvdata(phy->dev.parent);
> +	unsigned long ref_clk =3D clk_get_rate(priv->phy_ref_clk);
> +	int i;
> +	unsigned long numerator, denominator, frequency;
> +	unsigned step;
> +
> +static int mixel_dphy_ref_power_on(struct phy *phy)
> +{
> +	struct mixel_dphy_priv *priv =3D phy_get_drvdata(phy);
> +	u32 lock, timeout;
> +	int ret =3D 0;
> +
> +	mutex_lock(&priv->lock);
> +	clk_prepare_enable(priv->phy_ref_clk);
> +
> +	phy_write(phy, PWR_ON, DPHY_PD_DPHY);
> +	phy_write(phy, PWR_ON, DPHY_PD_PLL);
> +
> +	timeout =3D 100;
> +	while (!(lock =3D phy_read(phy, DPHY_LOCK))) {
> +		udelay(10);
> +		if (--timeout =3D=3D 0) {
> +			dev_err(&phy->dev, "Could not get DPHY lock!\n");
> +			mutex_unlock(&priv->lock);
> +			return -EINVAL;
> +		}
USe goto to have a single exit path where you do mutex_unlock()

> +	}
> +	mutex_unlock(&priv->lock);
> +
> +	return ret;
> +}
> +
> +
> +	mutex_lock(&priv->lock);
> +
> +	phy_write(phy, 0x00, DPHY_LOCK_BYP);
> +	phy_write(phy, 0x01, DPHY_TX_RCAL);
> +	phy_write(phy, 0x00, DPHY_AUTO_PD_EN);
> +	phy_write(phy, 0x01, DPHY_RXLPRP);
> +	phy_write(phy, 0x01, DPHY_RXCDRP);
> +	phy_write(phy, 0x25, DPHY_TST);
> +
> +	mixel_phy_set_hs_timings(phy);
> +	ret =3D mixel_dphy_set_pll_params(phy);
> +	if (ret < 0) {
> +		mutex_unlock(&priv->lock);
> +		return ret;
> +	}
USe goto to have a single exit path where you do mutex_unlock()
> +
> +	mutex_unlock(&priv->lock);
> +
> +	return 0;
> +}
> +
> +
> +/*
> + * This is the reference implementation of DPHY hooks. Specific integrat=
ion of
> + * this IP may have to re-implement some of them depending on how they d=
ecided
> + * to wire things in the SoC.
> + */
> +static const struct mixel_dphy_ops mixel_dphy_ref_ops =3D {
> +	.power_on =3D mixel_dphy_ref_power_on,
> +	.power_off =3D mixel_dphy_ref_power_off,
> +};
> +
> +static const struct phy_ops mixel_dphy_ops =3D {
> +	.power_on =3D mixel_dphy_power_on,
> +	.power_off =3D mixel_dphy_power_off,
> +	.configure =3D mixel_dphy_configure,
> +	.validate =3D mixel_dphy_validate,
> +	.owner =3D THIS_MODULE,
> +};
This is confusing.
We have struct mixel_dphy_ops =3D> mixel_dphy_ref_ops
And then struct phy_ops =3D> mixel_dphy_ops

So reading this there are to uses of mixel_dphy_ops,
one is a struct, and another is an instance of another type.
Try to find a niming scheme that is less confusing.


> +
> +static const struct of_device_id mixel_dphy_of_match[] =3D {
> +	{ .compatible =3D "mixel,imx8mq-mipi-dphy", .data =3D &mixel_dphy_ref_o=
ps },
> +	{ /* sentinel */ },
> +};
Multi-line to keep line shorter?

> +MODULE_DEVICE_TABLE(of, mixel_dphy_of_match);
> +
> +static int mixel_dphy_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *np =3D dev->of_node;
> +	struct phy_provider *phy_provider;
> +	struct mixel_dphy_priv *priv;
> +	struct resource *res;
> +	struct phy *phy;
> +	int ret;
> +
> +	if (!np)
> +		return -ENODEV;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->ops =3D of_device_get_match_data(&pdev->dev);
> +	if (!priv->ops)
> +		return -EINVAL;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +
> +	priv->regs =3D devm_ioremap(dev, res->start, SZ_256);
> +	if (IS_ERR(priv->regs))
> +		return PTR_ERR(priv->regs);
> +
> +	priv->phy_ref_clk =3D devm_clk_get(&pdev->dev, "phy_ref");
> +	if (IS_ERR(priv->phy_ref_clk)) {
> +		dev_err(dev, "No phy_ref clock found");
> +		return PTR_ERR(priv->phy_ref_clk);
> +	}
> +	dev_dbg(dev, "phy_ref clock rate: %lu", clk_get_rate(priv->phy_ref_clk)=
);
> +
> +	mutex_init(&priv->lock);
> +	dev_set_drvdata(dev, priv);
> +
> +	if (priv->ops->probe) {
> +		ret =3D priv->ops->probe(priv);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	phy =3D devm_phy_create(dev, np, &mixel_dphy_ops);
> +	if (IS_ERR(phy)) {
> +		dev_err(dev, "Failed to create phy %ld\n", PTR_ERR(phy));
> +		return PTR_ERR(phy);
> +	}
> +	phy_set_drvdata(phy, priv);
> +
> +	phy_provider =3D devm_of_phy_provider_register(dev, of_phy_simple_xlate=
);
> +
> +	return PTR_ERR_OR_ZERO(phy_provider);
> +}
> +
> +static struct platform_driver mixel_dphy_driver =3D {
> +	.probe	=3D mixel_dphy_probe,
> +	.driver =3D {
> +		.name =3D "mixel-mipi-dphy",
> +		.of_match_table	=3D mixel_dphy_of_match,
> +	}
> +};
> +module_platform_driver(mixel_dphy_driver);
> +
> +MODULE_AUTHOR("NXP Semiconductor");
> +MODULE_DESCRIPTION("Mixel MIPI-DSI PHY driver");
> +MODULE_LICENSE("GPL v2");
> -- =

> 2.20.1
> =

> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

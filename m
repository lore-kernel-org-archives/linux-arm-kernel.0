Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB2AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:24:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BC052173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="albM/sGo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZmSGSdv8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC052173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y56xdVgqY+UzL8uk9gZeYTmCz0gSiDCo4I7k/rQw4Zg=; b=albM/sGodUwwuf
	mf8mE7hZg70d/1JJ0b0eVBCahCCwzzPVN86/b7H5bQIieXS5zycJrzW3/3Q//Bc4imzvDVjzKMql9
	DqAvpf/fF9HfrGEHDCkmuBAYsmPAOv8oj+qxK5bm9dj+G84jUWgeW2bP0grtmh5dzMHkaYMLQEyzn
	T6WkNcD88Hto9aQMZV0/271xmFueUQYDigFJP1XNNHAZs/JdM6CNWQZCqM+aqIfz+wrpm20eyALjv
	2qd5EtVyEPTegd/VZBiIAyQEwpyh2tjmL1mpKGv+L4Orv3eJD72A+tD6Hbs+jpUd6LqRLovUSp+q7
	k52Jq421EUqgHU6Itu7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvUrB-00010H-5J; Sun, 17 Feb 2019 22:24:17 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvUr6-0000zR-RA; Sun, 17 Feb 2019 22:24:14 +0000
Received: by mail-ot1-x343.google.com with SMTP id t7so8861721otk.8;
 Sun, 17 Feb 2019 14:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=P80GfNvaS9e6SAoUl/bctSRLBIM9yVHA6Ik97/uOB2Q=;
 b=ZmSGSdv8mJvz/GYo3kwYdjudIogl68qmELZVdXXFd0umMpJpyPbkm5cSHl/Av/E619
 0HKbW2k55MnPdIcza6iD6fJ7w+G+XNY0EeEPV425j1zc7PM3PiWZpDdXnJICKzJMlNdl
 AmX3EsCmA9SzRpu9b9QHqXqkvTJc55f1D68Ik+SSJoZwFk8g/I4MCJBIXmrGgy/DmOjR
 /FX7S0mVxfq17DUCueZdItVJHFZ4qMlINSZN8nLvdLeq47stRaFl05da5KKtMdFDtCvL
 yXrgpT27ZMkkSBKiS4VUzL9jMlyvq5DAeFgOi4nBfbCSxG77dnWF7H1oeaxyDF/MM3C8
 pf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P80GfNvaS9e6SAoUl/bctSRLBIM9yVHA6Ik97/uOB2Q=;
 b=qK0YSZr2TdUNSWvmwSY+/trfCIx8tZxrJJIybgvGUG/WL/wRzcRRr3t3h4XA6RhGBH
 DMw6wcPcPnDmI8dE6IT84cugKmzu4M2prK26d8pxCVl0YT9kbiPV/d9VCxVhwtwxKVXx
 69ABuodNOyfzSy2GSm/bGwRKJpfOvUnjbpk0TH/DWOJp/daYDDdCX0wTLXFSuszBivno
 dnvpcn5Hb6taRG8S9GQHqyt0OeyNyXE7S1Nksz1MT6Btbb2LGZcG0dXWgM/dLtFiWs22
 tqMKP4b7aPIH70PTvZOFGI0tu4V23DnLO2z7zMOw0NCHAvG93+HH874oWlQt6khfZ6H3
 p/GA==
X-Gm-Message-State: AHQUAubCh7lW2s8bmqWtZ2qizT8dSf9k2SMgeV6SkKgN7+KFYvqGX0Mh
 jf/qCp3RX1+xx0iTIwLW4Ri5kBKevqE/7v69P5U=
X-Google-Smtp-Source: AHgI3Ib4vAInp2/JvTqhmiBDjxKOtHyCkeU8mp0QtcalTeZBUgZzv6lCMPTenFM/p4GbYhunWPma4/GdmzQMMJmQ5VM=
X-Received: by 2002:aca:aacb:: with SMTP id
 t194mr13119811oie.129.1550442251883; 
 Sun, 17 Feb 2019 14:24:11 -0800 (PST)
MIME-Version: 1.0
References: <20190212151413.24632-1-narmstrong@baylibre.com>
 <20190212151413.24632-6-narmstrong@baylibre.com>
In-Reply-To: <20190212151413.24632-6-narmstrong@baylibre.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 17 Feb 2019 23:24:01 +0100
Message-ID: <CAFBinCCAi_NYTvGPK+MNoqn3YhOHrSLrH4ybFYJvBSNkSCZ8BQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] phy: amlogic: add Amlogic G12A USB2 PHY Driver
To: Neil Armstrong <narmstrong@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_142412_906866_B201472F 
X-CRM114-Status: GOOD (  30.70  )
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
Cc: balbi@kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, kishon@ti.com, hminas@synopsys.com,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Neil,

On Tue, Feb 12, 2019 at 4:15 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This adds support for the USB2 PHY found in the Amlogic G12A SoC Family.
>
> It supports Host and/or Peripheral mode, depending on it's position.
> The first PHY is only used as Host, but the second supports Dual modes
> defined by the USB Control Glue HW in front of the USB Controllers.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/phy/amlogic/Kconfig               |  12 ++
>  drivers/phy/amlogic/Makefile              |   1 +
>  drivers/phy/amlogic/phy-meson-g12a-usb2.c | 191 ++++++++++++++++++++++
>  3 files changed, 204 insertions(+)
>  create mode 100644 drivers/phy/amlogic/phy-meson-g12a-usb2.c
>
> diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
> index 23fe1cda2f70..78d6e194dce9 100644
> --- a/drivers/phy/amlogic/Kconfig
> +++ b/drivers/phy/amlogic/Kconfig
> @@ -36,3 +36,15 @@ config PHY_MESON_GXL_USB3
>           Enable this to support the Meson USB3 PHY and OTG detection
>           IP block found in Meson GXL and GXM SoCs.
>           If unsure, say N.
> +
> +config PHY_MESON_G12A_USB2
> +       tristate "Meson G12A USB2 PHY drivers"
aw, there's a typo in the GXL driver names (from which this new
Kconfig entry may have been copied): it should be "driver" instead of
"drivers"

> +       default ARCH_MESON
> +       depends on OF && (ARCH_MESON || COMPILE_TEST)
> +       depends on USB_SUPPORT
I don't think you need USB_SUPPORT (neither does PHY_MESON_GXL_USB2,
but it seems that I accidentally left it in from an early development
iteration), see below

> +       select GENERIC_PHY
> +       select REGMAP_MMIO
> +       help
> +         Enable this to support the Meson USB2 PHYs found in Meson
> +         G12A SoCs.
> +         If unsure, say N.
> diff --git a/drivers/phy/amlogic/Makefile b/drivers/phy/amlogic/Makefile
> index 4fd8848c194d..7d4d10f5a6b3 100644
> --- a/drivers/phy/amlogic/Makefile
> +++ b/drivers/phy/amlogic/Makefile
> @@ -1,3 +1,4 @@
>  obj-$(CONFIG_PHY_MESON8B_USB2)         += phy-meson8b-usb2.o
>  obj-$(CONFIG_PHY_MESON_GXL_USB2)       += phy-meson-gxl-usb2.o
> +obj-$(CONFIG_PHY_MESON_G12A_USB2)      += phy-meson-g12a-usb2.o
>  obj-$(CONFIG_PHY_MESON_GXL_USB3)       += phy-meson-gxl-usb3.o
> diff --git a/drivers/phy/amlogic/phy-meson-g12a-usb2.c b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
> new file mode 100644
> index 000000000000..3b6271a8be02
> --- /dev/null
> +++ b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
> @@ -0,0 +1,191 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Meson G12A USB2 PHY driver
> + *
> + * Copyright (C) 2017 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> + * Copyright (C) 2017 Amlogic, Inc. All rights reserved
> + * Copyright (C) 2019 BayLibre, SAS
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
I don't see any syscon usage in the driver so you can drop this

> +#include <linux/reset.h>
> +#include <linux/phy/phy.h>
> +#include <linux/usb/otg.h>
do you need this? if you drop "depends on USB_SUPPORT" from Kconfig
then you want to get rid of this as well

> +#include <linux/platform_device.h>
> +
> +#define PHY_CTRL_R0                                            0x0
> +#define PHY_CTRL_R1                                            0x4
> +#define PHY_CTRL_R2                                            0x8
> +#define PHY_CTRL_R3                                            0xc
> +#define PHY_CTRL_R4                                            0x10
> +#define PHY_CTRL_R5                                            0x14
> +#define PHY_CTRL_R6                                            0x18
> +#define PHY_CTRL_R7                                            0x1c
> +#define PHY_CTRL_R8                                            0x20
> +#define PHY_CTRL_R9                                            0x24
> +#define PHY_CTRL_R10                                           0x28
> +#define PHY_CTRL_R11                                           0x2c
> +#define PHY_CTRL_R12                                           0x30
> +#define PHY_CTRL_R13                                           0x34
> +#define PHY_CTRL_R14                                           0x38
> +#define PHY_CTRL_R15                                           0x3c
> +#define PHY_CTRL_R16                                           0x40
> +#define PHY_CTRL_R17                                           0x44
> +#define PHY_CTRL_R18                                           0x48
> +#define PHY_CTRL_R19                                           0x4c
> +#define PHY_CTRL_R20                                           0x50
> +#define PHY_CTRL_R21                                           0x54
> +#define PHY_CTRL_R22                                           0x58
> +#define PHY_CTRL_R23                                           0x5c
> +
> +#define RESET_COMPLETE_TIME                                    1000
> +#define PLL_RESET_COMPLETE_TIME                                        100
> +
> +struct phy_meson_g12a_usb2_priv {
> +       struct device           *dev;
> +       struct regmap           *regmap;
> +       struct clk              *clk;
> +       struct reset_control    *reset;
> +};
> +
> +static const struct regmap_config phy_meson_g12a_usb2_regmap_conf = {
> +       .reg_bits = 8,
> +       .val_bits = 32,
> +       .reg_stride = 4,
> +       .max_register = PHY_CTRL_R23,
> +};
> +
> +static int phy_meson_g12a_usb2_init(struct phy *phy)
> +{
> +       struct phy_meson_g12a_usb2_priv *priv = phy_get_drvdata(phy);
> +       int ret;
> +
> +       ret = reset_control_reset(priv->reset);
> +       if (ret)
> +               return ret;
> +
> +       udelay(RESET_COMPLETE_TIME);
> +
> +       /* usb2_otg_aca_en == 0 */
> +       regmap_update_bits(priv->regmap, PHY_CTRL_R21, BIT(2), 0);
do you have the name of the other register bits as well? having
#defines would make the code easier to read

> +
> +       /* PLL Setup : 24MHz * 20 / 1 = 480MHz */
> +       regmap_write(priv->regmap, PHY_CTRL_R16, 0x39400414);
> +       regmap_write(priv->regmap, PHY_CTRL_R17, 0x927e0000);
> +       regmap_write(priv->regmap, PHY_CTRL_R18, 0xac5f49e5);
> +
> +       udelay(PLL_RESET_COMPLETE_TIME);
> +
> +       /* UnReset PLL */
> +       regmap_write(priv->regmap, PHY_CTRL_R16, 0x19400414);
> +
> +       /* PHY Tuning */
> +       regmap_write(priv->regmap, PHY_CTRL_R20, 0xfe18);
> +       regmap_write(priv->regmap, PHY_CTRL_R4, 0x8000fff);
> +
> +       /* Tuning Disconnect Threshold */
> +       regmap_write(priv->regmap, PHY_CTRL_R3, 0x34);
> +
> +       /* Analog Settings */
> +       regmap_write(priv->regmap, PHY_CTRL_R14, 0);
> +       regmap_write(priv->regmap, PHY_CTRL_R13, 0x78000);
> +
> +       return 0;
> +}
> +
> +static int phy_meson_g12a_usb2_exit(struct phy *phy)
> +{
> +       struct phy_meson_g12a_usb2_priv *priv = phy_get_drvdata(phy);
> +
> +       return reset_control_reset(priv->reset);
do you have information on whether we should reset_control_assert here
instead of reset_control_reset?

> +}
> +
> +/* set_mode is not needed, mode setting is handled via the UTMI bus */
> +static const struct phy_ops phy_meson_g12a_usb2_ops = {
> +       .init           = phy_meson_g12a_usb2_init,
> +       .exit           = phy_meson_g12a_usb2_exit,
> +       .owner          = THIS_MODULE,
> +};
> +
> +static int phy_meson_g12a_usb2_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct phy_provider *phy_provider;
> +       struct resource *res;
> +       struct phy_meson_g12a_usb2_priv *priv;
> +       struct phy *phy;
> +       void __iomem *base;
> +       int ret;
> +
> +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->dev = dev;
> +       platform_set_drvdata(pdev, priv);
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       base = devm_ioremap_resource(dev, res);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       priv->regmap = devm_regmap_init_mmio(dev, base,
> +                                            &phy_meson_g12a_usb2_regmap_conf);
> +       if (IS_ERR(priv->regmap))
> +               return PTR_ERR(priv->regmap);
> +
> +       priv->clk = devm_clk_get(dev, "xtal");
> +       if (IS_ERR(priv->clk))
> +               return PTR_ERR(priv->clk);
> +
> +       priv->reset = devm_reset_control_get(dev, "phy");
> +       if (IS_ERR(priv->reset))
> +               return PTR_ERR(priv->reset);
> +
> +       ret = reset_control_deassert(priv->reset);
should we move this to phy_meson_g12a_usb2_init (which currently uses
reset_control_reset)?
then we could also use reset_control_assert in phy_meson_g12a_usb2_exit

> +       if (ret)
> +               return ret;
> +
> +       phy = devm_phy_create(dev, NULL, &phy_meson_g12a_usb2_ops);
> +       if (IS_ERR(phy)) {
> +               ret = PTR_ERR(phy);
> +               if (ret != -EPROBE_DEFER)
> +                       dev_err(dev, "failed to create PHY\n");
phy-core only returns EPROBE_DEFER in case the phy-supply is not ready yet.
we won't need a phy-supply (at least as far as I know, if we do then
please document this in the dt-bindings patch). for USB VBUS dwc2
support the "vbus-supply" property which we should use instead.
I leave it up to you to decide whether the check makes sense

> +               return ret;
> +       }
> +
> +       phy_set_bus_width(phy, 8);
> +       phy_set_drvdata(phy, priv);
> +
> +       phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +
> +       return PTR_ERR_OR_ZERO(phy_provider);
> +}
> +
> +static const struct of_device_id phy_meson_g12a_usb2_of_match[] = {
> +       { .compatible = "amlogic,g12a-usb2-phy", },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(of, phy_meson_g12a_usb2_of_match);
> +
> +static struct platform_driver phy_meson_g12a_usb2_driver = {
> +       .probe  = phy_meson_g12a_usb2_probe,
> +       .driver = {
> +               .name           = "phy-meson-g12a-usb2",
> +               .of_match_table = phy_meson_g12a_usb2_of_match,
> +       },
> +};
> +module_platform_driver(phy_meson_g12a_usb2_driver);
> +
> +MODULE_AUTHOR("Martin Blumenstingl <martin.blumenstingl@googlemail.com>");
I haven't contributed any of the relevant code to this driver (I
assume you took one of our existing Amlogic PHY drivers as skeleton?).
it's up to you whether you want to keep me in here


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

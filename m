Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49A4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:38:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A29FA2173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u5dUVpCM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fFWK9ayh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A29FA2173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v1/cqerK5E9MhqxOV1Eg50UaCR0bm8mSZENm9XHcmJk=; b=u5dUVpCMBCq+4t
	YgMdlZD+SutYSoDkmV3Ys2WaF7UNS0WfZbBXHGQkkAy6jZuQ8skCycUkksQCuj9kmmQ+uvWcXQsF+
	Eo7cL2w9f7Fg+wqjfCKAwEK7Z2wHSBJ7020WK2RgM/t9FxkYjHZv3U7swQ0LMBZYPt1S59aVJvm55
	W3er2Pq7Gv3u2QZG7uAoLo0hj8ILAs6PoaapkPPEzd3J9tG+D216q/l53vrCjgCUpP9jZQPSoZZGR
	3Q1DZ2RpQxusKV7fj4HX++awo+hxTs7Dq0B1nG1abzCh/iN1TfhSXUyLjfme5xni9MPENVFIF09bG
	UhEoxVKQQhdMYohPBkeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvgJV-0001QH-4u; Mon, 18 Feb 2019 10:38:17 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvgJR-0001Ot-46
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 10:38:15 +0000
Received: by mail-wm1-x343.google.com with SMTP id j125so16556721wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 02:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=t5h1LW7JsQTmqeHQOJ0qUsEEL5WHZRH1eHkkuJFsVAQ=;
 b=fFWK9ayh5rjbtrLa/1HuVBiLnq8O/nNVlx8AweukIoft/tF3wmTTeWeM+AD7MKuqsJ
 epKQvWjzdyZCFKPQrB+xafKxCpXZ1vYKmWfKX8yKWSjuvLAghuRbStLbp95Tb0fx70M/
 d4x3k16y9CXjjQpwGBIDZSL5/dPpe4nJzTtyiFc8qJMpPGsussf5vo1rT05h6jgeI0At
 CNrl27ZJThq5mXuXzMwbNI/eo8hvBAkauxpDSB/hVy6LG/w+qhD55ALr8urPcqJMSfpn
 U1zYYlDrB13EAYmMbf6ve/QCrgJYi/ZaxZ8vA5mAFkwP7YdqNqov4nTC+wkD9FaNY2cB
 0xWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :organization:message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=t5h1LW7JsQTmqeHQOJ0qUsEEL5WHZRH1eHkkuJFsVAQ=;
 b=LzaYazQbla5Nqk+/5Ef/NTVitqQAn5JyFVrKu42MbiUIM237K4FxFliCZJ4SIJicE8
 JD+oPudZVLFRBJ7WzDrgikeNTTd+HwzxMzjsQvYvl8SW6CPl62mj500O11kB4Nyc087W
 1myO3e5dlIIuc13C8XjcJ0s2yf5eIbImy45MJes6HEVj6+FFDwJufsZDFaF36G8Mi9Ha
 sjM3Zd/ZN9v/AHTQ6eJrIJpc1S8CEdTZeufKepUu/vSWYylx/fVTdWPgcmrLXPSokAuy
 GjL8qnL31YtjsK/lxT+qogD3vTSDNtL6Kk05LQRZDdMbU7rKDeED/mVek6sYS5Rd76Yr
 7jtw==
X-Gm-Message-State: AHQUAuaT8Fy3xITV6HRsTdaf3BAHNH4g51B+fZXj0az0xbkgJjxjOzkf
 rJpD+yk0HHWCiQkjeKBuvjXUBLCw+ZhS6Q==
X-Google-Smtp-Source: AHgI3IaZNkh5GY1OW8V50XVfmZgBwBuGC2yG2XV36LEe+xJxoN4Nb9PCZ3lIzsw8DpdyYjNsCYRiPA==
X-Received: by 2002:a1c:eb18:: with SMTP id j24mr14630194wmh.119.1550486289122; 
 Mon, 18 Feb 2019 02:38:09 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr.
 [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id j124sm13989744wmb.48.2019.02.18.02.38.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Feb 2019 02:38:08 -0800 (PST)
Subject: Re: [PATCH 5/8] phy: amlogic: add Amlogic G12A USB2 PHY Driver
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20190212151413.24632-1-narmstrong@baylibre.com>
 <20190212151413.24632-6-narmstrong@baylibre.com>
 <CAFBinCCAi_NYTvGPK+MNoqn3YhOHrSLrH4ybFYJvBSNkSCZ8BQ@mail.gmail.com>
From: Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <98974429-3b7d-7462-e912-7ee83981831d@baylibre.com>
Date: Mon, 18 Feb 2019 11:38:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCCAi_NYTvGPK+MNoqn3YhOHrSLrH4ybFYJvBSNkSCZ8BQ@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_023813_234176_81C06BA8 
X-CRM114-Status: GOOD (  29.93  )
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

Hi Martin,

On 17/02/2019 23:24, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Tue, Feb 12, 2019 at 4:15 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> This adds support for the USB2 PHY found in the Amlogic G12A SoC Family.
>>
>> It supports Host and/or Peripheral mode, depending on it's position.
>> The first PHY is only used as Host, but the second supports Dual modes
>> defined by the USB Control Glue HW in front of the USB Controllers.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/phy/amlogic/Kconfig               |  12 ++
>>  drivers/phy/amlogic/Makefile              |   1 +
>>  drivers/phy/amlogic/phy-meson-g12a-usb2.c | 191 ++++++++++++++++++++++
>>  3 files changed, 204 insertions(+)
>>  create mode 100644 drivers/phy/amlogic/phy-meson-g12a-usb2.c
>>
>> diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
>> index 23fe1cda2f70..78d6e194dce9 100644
>> --- a/drivers/phy/amlogic/Kconfig
>> +++ b/drivers/phy/amlogic/Kconfig
>> @@ -36,3 +36,15 @@ config PHY_MESON_GXL_USB3
>>           Enable this to support the Meson USB3 PHY and OTG detection
>>           IP block found in Meson GXL and GXM SoCs.
>>           If unsure, say N.
>> +
>> +config PHY_MESON_G12A_USB2
>> +       tristate "Meson G12A USB2 PHY drivers"
> aw, there's a typo in the GXL driver names (from which this new
> Kconfig entry may have been copied): it should be "driver" instead of
> "drivers"

Will fix...

> 
>> +       default ARCH_MESON
>> +       depends on OF && (ARCH_MESON || COMPILE_TEST)
>> +       depends on USB_SUPPORT
> I don't think you need USB_SUPPORT (neither does PHY_MESON_GXL_USB2,
> but it seems that I accidentally left it in from an early development
> iteration), see below

Indeed, thanks for pointing this

> 
>> +       select GENERIC_PHY
>> +       select REGMAP_MMIO
>> +       help
>> +         Enable this to support the Meson USB2 PHYs found in Meson
>> +         G12A SoCs.
>> +         If unsure, say N.
>> diff --git a/drivers/phy/amlogic/Makefile b/drivers/phy/amlogic/Makefile
>> index 4fd8848c194d..7d4d10f5a6b3 100644
>> --- a/drivers/phy/amlogic/Makefile
>> +++ b/drivers/phy/amlogic/Makefile
>> @@ -1,3 +1,4 @@
>>  obj-$(CONFIG_PHY_MESON8B_USB2)         += phy-meson8b-usb2.o
>>  obj-$(CONFIG_PHY_MESON_GXL_USB2)       += phy-meson-gxl-usb2.o
>> +obj-$(CONFIG_PHY_MESON_G12A_USB2)      += phy-meson-g12a-usb2.o
>>  obj-$(CONFIG_PHY_MESON_GXL_USB3)       += phy-meson-gxl-usb3.o
>> diff --git a/drivers/phy/amlogic/phy-meson-g12a-usb2.c b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
>> new file mode 100644
>> index 000000000000..3b6271a8be02
>> --- /dev/null
>> +++ b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
>> @@ -0,0 +1,191 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Meson G12A USB2 PHY driver
>> + *
>> + * Copyright (C) 2017 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> + * Copyright (C) 2017 Amlogic, Inc. All rights reserved
>> + * Copyright (C) 2019 BayLibre, SAS
>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/mfd/syscon.h>
> I don't see any syscon usage in the driver so you can drop this

Forgot to remove it

> 
>> +#include <linux/reset.h>
>> +#include <linux/phy/phy.h>
>> +#include <linux/usb/otg.h>
> do you need this? if you drop "depends on USB_SUPPORT" from Kconfig
> then you want to get rid of this as well

Indeed, no need to this

> 
>> +#include <linux/platform_device.h>
>> +
>> +#define PHY_CTRL_R0                                            0x0
>> +#define PHY_CTRL_R1                                            0x4
>> +#define PHY_CTRL_R2                                            0x8
>> +#define PHY_CTRL_R3                                            0xc
>> +#define PHY_CTRL_R4                                            0x10
>> +#define PHY_CTRL_R5                                            0x14
>> +#define PHY_CTRL_R6                                            0x18
>> +#define PHY_CTRL_R7                                            0x1c
>> +#define PHY_CTRL_R8                                            0x20
>> +#define PHY_CTRL_R9                                            0x24
>> +#define PHY_CTRL_R10                                           0x28
>> +#define PHY_CTRL_R11                                           0x2c
>> +#define PHY_CTRL_R12                                           0x30
>> +#define PHY_CTRL_R13                                           0x34
>> +#define PHY_CTRL_R14                                           0x38
>> +#define PHY_CTRL_R15                                           0x3c
>> +#define PHY_CTRL_R16                                           0x40
>> +#define PHY_CTRL_R17                                           0x44
>> +#define PHY_CTRL_R18                                           0x48
>> +#define PHY_CTRL_R19                                           0x4c
>> +#define PHY_CTRL_R20                                           0x50
>> +#define PHY_CTRL_R21                                           0x54
>> +#define PHY_CTRL_R22                                           0x58
>> +#define PHY_CTRL_R23                                           0x5c
>> +
>> +#define RESET_COMPLETE_TIME                                    1000
>> +#define PLL_RESET_COMPLETE_TIME                                        100
>> +
>> +struct phy_meson_g12a_usb2_priv {
>> +       struct device           *dev;
>> +       struct regmap           *regmap;
>> +       struct clk              *clk;
>> +       struct reset_control    *reset;
>> +};
>> +
>> +static const struct regmap_config phy_meson_g12a_usb2_regmap_conf = {
>> +       .reg_bits = 8,
>> +       .val_bits = 32,
>> +       .reg_stride = 4,
>> +       .max_register = PHY_CTRL_R23,
>> +};
>> +
>> +static int phy_meson_g12a_usb2_init(struct phy *phy)
>> +{
>> +       struct phy_meson_g12a_usb2_priv *priv = phy_get_drvdata(phy);
>> +       int ret;
>> +
>> +       ret = reset_control_reset(priv->reset);
>> +       if (ret)
>> +               return ret;
>> +
>> +       udelay(RESET_COMPLETE_TIME);
>> +
>> +       /* usb2_otg_aca_en == 0 */
>> +       regmap_update_bits(priv->regmap, PHY_CTRL_R21, BIT(2), 0);
> do you have the name of the other register bits as well? having
> #defines would make the code easier to read

It's on my TODO list...

> 
>> +
>> +       /* PLL Setup : 24MHz * 20 / 1 = 480MHz */
>> +       regmap_write(priv->regmap, PHY_CTRL_R16, 0x39400414);
>> +       regmap_write(priv->regmap, PHY_CTRL_R17, 0x927e0000);
>> +       regmap_write(priv->regmap, PHY_CTRL_R18, 0xac5f49e5);
>> +
>> +       udelay(PLL_RESET_COMPLETE_TIME);
>> +
>> +       /* UnReset PLL */
>> +       regmap_write(priv->regmap, PHY_CTRL_R16, 0x19400414);
>> +
>> +       /* PHY Tuning */
>> +       regmap_write(priv->regmap, PHY_CTRL_R20, 0xfe18);
>> +       regmap_write(priv->regmap, PHY_CTRL_R4, 0x8000fff);
>> +
>> +       /* Tuning Disconnect Threshold */
>> +       regmap_write(priv->regmap, PHY_CTRL_R3, 0x34);
>> +
>> +       /* Analog Settings */
>> +       regmap_write(priv->regmap, PHY_CTRL_R14, 0);
>> +       regmap_write(priv->regmap, PHY_CTRL_R13, 0x78000);
>> +
>> +       return 0;
>> +}
>> +
>> +static int phy_meson_g12a_usb2_exit(struct phy *phy)
>> +{
>> +       struct phy_meson_g12a_usb2_priv *priv = phy_get_drvdata(phy);
>> +
>> +       return reset_control_reset(priv->reset);
> do you have information on whether we should reset_control_assert here
> instead of reset_control_reset?

No, I don't have it, I haven't fully validated the remove/suspend path yet,
but this should at least put the PHY in an unconfigured mode.

> 
>> +}
>> +
>> +/* set_mode is not needed, mode setting is handled via the UTMI bus */
>> +static const struct phy_ops phy_meson_g12a_usb2_ops = {
>> +       .init           = phy_meson_g12a_usb2_init,
>> +       .exit           = phy_meson_g12a_usb2_exit,
>> +       .owner          = THIS_MODULE,
>> +};
>> +
>> +static int phy_meson_g12a_usb2_probe(struct platform_device *pdev)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       struct phy_provider *phy_provider;
>> +       struct resource *res;
>> +       struct phy_meson_g12a_usb2_priv *priv;
>> +       struct phy *phy;
>> +       void __iomem *base;
>> +       int ret;
>> +
>> +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +       if (!priv)
>> +               return -ENOMEM;
>> +
>> +       priv->dev = dev;
>> +       platform_set_drvdata(pdev, priv);
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       base = devm_ioremap_resource(dev, res);
>> +       if (IS_ERR(base))
>> +               return PTR_ERR(base);
>> +
>> +       priv->regmap = devm_regmap_init_mmio(dev, base,
>> +                                            &phy_meson_g12a_usb2_regmap_conf);
>> +       if (IS_ERR(priv->regmap))
>> +               return PTR_ERR(priv->regmap);
>> +
>> +       priv->clk = devm_clk_get(dev, "xtal");
>> +       if (IS_ERR(priv->clk))
>> +               return PTR_ERR(priv->clk);
>> +
>> +       priv->reset = devm_reset_control_get(dev, "phy");
>> +       if (IS_ERR(priv->reset))
>> +               return PTR_ERR(priv->reset);
>> +
>> +       ret = reset_control_deassert(priv->reset);
> should we move this to phy_meson_g12a_usb2_init (which currently uses
> reset_control_reset)?
> then we could also use reset_control_assert in phy_meson_g12a_usb2_exit

Maybe it would be better, indeed.

> 
>> +       if (ret)
>> +               return ret;
>> +
>> +       phy = devm_phy_create(dev, NULL, &phy_meson_g12a_usb2_ops);
>> +       if (IS_ERR(phy)) {
>> +               ret = PTR_ERR(phy);
>> +               if (ret != -EPROBE_DEFER)
>> +                       dev_err(dev, "failed to create PHY\n");
> phy-core only returns EPROBE_DEFER in case the phy-supply is not ready yet.
> we won't need a phy-supply (at least as far as I know, if we do then
> please document this in the dt-bindings patch). for USB VBUS dwc2
> support the "vbus-supply" property which we should use instead.
> I leave it up to you to decide whether the check makes sense

It's always better to handle these return cases, better to leave it.

> 
>> +               return ret;
>> +       }
>> +
>> +       phy_set_bus_width(phy, 8);
>> +       phy_set_drvdata(phy, priv);
>> +
>> +       phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
>> +
>> +       return PTR_ERR_OR_ZERO(phy_provider);
>> +}
>> +
>> +static const struct of_device_id phy_meson_g12a_usb2_of_match[] = {
>> +       { .compatible = "amlogic,g12a-usb2-phy", },
>> +       { },
>> +};
>> +MODULE_DEVICE_TABLE(of, phy_meson_g12a_usb2_of_match);
>> +
>> +static struct platform_driver phy_meson_g12a_usb2_driver = {
>> +       .probe  = phy_meson_g12a_usb2_probe,
>> +       .driver = {
>> +               .name           = "phy-meson-g12a-usb2",
>> +               .of_match_table = phy_meson_g12a_usb2_of_match,
>> +       },
>> +};
>> +module_platform_driver(phy_meson_g12a_usb2_driver);
>> +
>> +MODULE_AUTHOR("Martin Blumenstingl <martin.blumenstingl@googlemail.com>");
> I haven't contributed any of the relevant code to this driver (I
> assume you took one of our existing Amlogic PHY drivers as skeleton?).
> it's up to you whether you want to keep me in here

Yep it's for the skeleton ! No harm to keep you in !

> 
> 
> Regards
> Martin
> 

Thanks,
Neil


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

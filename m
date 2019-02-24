Return-Path: <SRS0=QUhG=Q7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786EBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:41:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4768920652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="op6ts09+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="q85QtieL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4768920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=i5BGMprxszYGNsYhPH2NlxUQPahfYqdxD5zPheNNyyQ=; b=op6ts09+mlsIOv
	7GIOGjITusxtNV64rHIwihO7RYK7m9HMaXouvuZR9uUJbSQ/72NVFbVzkRR+d+FwQAmtsx5xu0bBf
	BZwFnosXi2Nhr+hIYPUcZ/kJBElKX92iGtU71P0rxY3l16Ywg0WzlgyNl96Oeybe05arTd2IVHXMl
	A3s/ob9xSwf8EeUCzD5HmdR/KnK22xdPIFpL9d8FiIIr/GiNKbspP0RrOT0uLN70GNWo+cpmev/OU
	VdR8klOemqP+zv5cZctt73oR6W+7n5Pnsr154xUtEhMpCvInphMNR+jVAEpj/3NQyOPkEPlzCQ8ny
	QRW6SxY3G5k4ZW9hAlsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxzdu-0006Mc-2K; Sun, 24 Feb 2019 19:40:54 +0000
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxzdq-0006Lc-4Y; Sun, 24 Feb 2019 19:40:51 +0000
Received: by mail-oi1-x244.google.com with SMTP id b4so5635096oif.6;
 Sun, 24 Feb 2019 11:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2lLS7Eq3OMW3HLFIEHd7HCsdWAS76ih1fieUstK9xb0=;
 b=q85QtieLdl8MuHe6sabxOP+87uHLP0EfDOrGpEUjcuN4iNEf8qZt12KH6oL3tijIuw
 hg8qFbXyjS0XlyPJMa4vSCYS/KN1jYgHi5/MUAhsmRT5GORkftgEIs2SjwpLmouK6vk8
 NUtQmnrUGWhzgeK8mjijT7sWhSx8pLq7XqfgZ6O7/RNvbLh9ao29Gzu1+08H6uhhn0hF
 Com8KzoEv00uW4iKIyJYqrHX2mUNlPRvMioi7EPko7bRM2OebyYrh3R2uHJGQTlw6JPF
 OsF5/lB7qkFPDv8aBFAPBN8FASiIPk9wIjuSXjBHcfTSuBrsRF44nQ34bzqdzrf8WhG+
 Gohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2lLS7Eq3OMW3HLFIEHd7HCsdWAS76ih1fieUstK9xb0=;
 b=CayAIExIZJVccIdaE4p15o28L0zuS098ub3WkY3FlN122g9kkc2xEwIfSHsZQbJB+Y
 UTY30fpP5BMzsxumgDWePHiA7eu9y8hXirP4REjGilVcQxejikgbWKEaH4rZRUrR5A3G
 Cr4LmzYIW7/vtBjjwIi2ZzZC1IqGvIusP2qYvPsimQbjCBYvsd7foMaFWZuxmiNAMzvQ
 6wHjkS4v71X+01G82xGpVT8tt/CpqNTQwAiL2anCF/ntBnXuXNpXwV4vc2UyCQPibwSH
 UPXEJcCvxBgywNmlgGMAkLYniYNl0zuWcxhu+GntSZtux5e8HEVY/pfK8ZQas5HqqNu4
 IUMg==
X-Gm-Message-State: AHQUAuZqoqCG/QJ00y6BVb8oD+2eAE1jFafyFcdijDwAHdq7ru7WKLew
 wK0hot0b5JH0pdXKd9hRmyukxD5N15tqGztZSX4=
X-Google-Smtp-Source: AHgI3IYsoPfO0Zfqmpdy/kVkQl70w8ybav3C9zxzpYyTna3eo9dZmNjtAScxwNiCtFVQktyARcUm1dikJkE7x+bBPlM=
X-Received: by 2002:aca:bc0b:: with SMTP id m11mr8694088oif.41.1551037248237; 
 Sun, 24 Feb 2019 11:40:48 -0800 (PST)
MIME-Version: 1.0
References: <20190212151413.24632-1-narmstrong@baylibre.com>
 <20190212151413.24632-7-narmstrong@baylibre.com>
In-Reply-To: <20190212151413.24632-7-narmstrong@baylibre.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 24 Feb 2019 20:40:37 +0100
Message-ID: <CAFBinCA7yRpxG8WMvE0BBXdmcYCBV0EPb6nLQBevxZ0iy7-ZtA@mail.gmail.com>
Subject: Re: [PATCH 6/8] phy: amlogic: Add Amlogic G12A USB3 + PCIE Combo PHY
 Driver
To: Neil Armstrong <narmstrong@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_114050_205525_AEA8C490 
X-CRM114-Status: GOOD (  25.81  )
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

On Tue, Feb 12, 2019 at 4:16 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This adds support for the shared USB3 + PCIE PHY found in the
> Amlogic G12A SoC Family.
>
> It supports USB3 Host mode or PCIE 2.0 mode, depending on the layout of
> the board.
>
> Selection is done by the #phy-cells, making the mode static and exclusive.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/phy/amlogic/Kconfig                   |  12 +
>  drivers/phy/amlogic/Makefile                  |   1 +
>  .../phy/amlogic/phy-meson-g12a-usb3-pcie.c    | 414 ++++++++++++++++++
>  3 files changed, 427 insertions(+)
>  create mode 100644 drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
>
> diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
> index 78d6e194dce9..7ccb9a756aba 100644
> --- a/drivers/phy/amlogic/Kconfig
> +++ b/drivers/phy/amlogic/Kconfig
> @@ -48,3 +48,15 @@ config PHY_MESON_G12A_USB2
>           Enable this to support the Meson USB2 PHYs found in Meson
>           G12A SoCs.
>           If unsure, say N.
> +
> +config PHY_MESON_G12A_USB3_PCIE
> +       tristate "Meson G12A USB3+PCIE Combo PHY drivers"
nit-pick: s/drivers/driver/

> +       default ARCH_MESON
> +       depends on OF && (ARCH_MESON || COMPILE_TEST)
> +       depends on USB_SUPPORT
> +       select GENERIC_PHY
> +       select REGMAP_MMIO
> +       help
> +         Enable this to support the Meson USB3 + PCIE Combi PHY found
> +         in Meson G12A SoCs.
> +         If unsure, say N.
> diff --git a/drivers/phy/amlogic/Makefile b/drivers/phy/amlogic/Makefile
> index 7d4d10f5a6b3..fdd008e1b19b 100644
> --- a/drivers/phy/amlogic/Makefile
> +++ b/drivers/phy/amlogic/Makefile
> @@ -2,3 +2,4 @@ obj-$(CONFIG_PHY_MESON8B_USB2)          += phy-meson8b-usb2.o
>  obj-$(CONFIG_PHY_MESON_GXL_USB2)       += phy-meson-gxl-usb2.o
>  obj-$(CONFIG_PHY_MESON_G12A_USB2)      += phy-meson-g12a-usb2.o
>  obj-$(CONFIG_PHY_MESON_GXL_USB3)       += phy-meson-gxl-usb3.o
> +obj-$(CONFIG_PHY_MESON_G12A_USB3_PCIE) += phy-meson-g12a-usb3-pcie.o
> diff --git a/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c b/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
> new file mode 100644
> index 000000000000..59eae98928e9
> --- /dev/null
> +++ b/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
> @@ -0,0 +1,414 @@
[...]
> +static int phy_g12a_usb3_init(struct phy *phy)
> +{
> +       struct phy_g12a_usb3_pcie_priv *priv = phy_get_drvdata(phy);
> +       int data, ret;
> +
> +       /* Switch PHY to USB3 */
> +       regmap_update_bits(priv->regmap, PHY_R0,
> +                          PHY_R0_PCIE_USB3_SWITCH,
> +                          PHY_R0_PCIE_USB3_SWITCH);
> +
> +       /*
> +        * WORKAROUND: There is SSPHY suspend bug due to
> +        * which USB enumerates
> +        * in HS mode instead of SS mode. Workaround it by asserting
> +        * LANE0.TX_ALT_BLOCK.EN_ALT_BUS to enable TX to use alt bus
> +        * mode
> +        */
> +       ret = regmap_update_bits(priv->regmap_cr, 0x102d, BIT(7), BIT(7));
does the datasheet have names for these registers / bits? it if does
then it would be great if you could introduce #defines for them

> +       if (ret)
> +               return ret;
> +
> +       ret = regmap_update_bits(priv->regmap_cr, 0x1010, 0xff0, 20);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * Fix RX Equalization setting as follows
> +        * LANE0.RX_OVRD_IN_HI. RX_EQ_EN set to 0
> +        * LANE0.RX_OVRD_IN_HI.RX_EQ_EN_OVRD set to 1
> +        * LANE0.RX_OVRD_IN_HI.RX_EQ set to 3
> +        * LANE0.RX_OVRD_IN_HI.RX_EQ_OVRD set to 1
> +        */
> +       ret = regmap_read(priv->regmap_cr, 0x1006, &data);
> +       if (ret)
> +               return ret;
> +
> +       data &= ~BIT(6);
> +       data |= BIT(7);
> +       data &= ~(0x7 << 8);
> +       data |= (0x3 << 8);
> +       data |= (1 << 11);
> +       ret = regmap_write(priv->regmap_cr, 0x1006, data);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * Set EQ and TX launch amplitudes as follows
> +        * LANE0.TX_OVRD_DRV_LO.PREEMPH set to 22
> +        * LANE0.TX_OVRD_DRV_LO.AMPLITUDE set to 127
> +        * LANE0.TX_OVRD_DRV_LO.EN set to 1.
> +        */
> +       ret = regmap_read(priv->regmap_cr, 0x1002, &data);
> +       if (ret)
> +               return ret;
> +
> +       data &= ~0x3f80;
> +       data |= (0x16 << 7);
> +       data &= ~0x7f;
> +       data |= (0x7f | BIT(14));
> +       ret = regmap_write(priv->regmap_cr, 0x1002, data);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * MPLL_LOOP_CTL.PROP_CNTRL = 8
> +        */
why a multi-line comment here? "Switch PHY to USB3" above uses a
single-line comment

> +       ret = regmap_update_bits(priv->regmap_cr, 0x30, 0xf << 4, 8 << 4);
> +       if (ret)
> +               return ret;
> +
> +       regmap_update_bits(priv->regmap, PHY_R2,
> +                       PHY_R2_PHY_TX_VBOOST_LVL,
> +                       FIELD_PREP(PHY_R2_PHY_TX_VBOOST_LVL, 0x4));
> +
> +       regmap_update_bits(priv->regmap, PHY_R1,
> +                       PHY_R1_PHY_LOS_BIAS | PHY_R1_PHY_LOS_LEVEL,
> +                       FIELD_PREP(PHY_R1_PHY_LOS_BIAS, 4) |
> +                       FIELD_PREP(PHY_R1_PHY_LOS_LEVEL, 9));
> +
> +       return 0;
> +}
> +
> +static int phy_g12a_usb3_pcie_init(struct phy *phy)
> +{
> +       struct phy_g12a_usb3_pcie_priv *priv = phy_get_drvdata(phy);
> +       int ret;
> +
> +       ret = reset_control_reset(priv->reset);
> +       if (ret)
> +               return ret;
> +
> +       if (priv->mode == PHY_TYPE_USB3)
> +               return phy_g12a_usb3_init(phy);
> +
> +       /* Power UP PCIE */
> +       regmap_update_bits(priv->regmap, PHY_R0,
> +                          PHY_R0_PCIE_POWER_STATE,
> +                          FIELD_PREP(PHY_R0_PCIE_POWER_STATE, 0x1c));
do we also need this for USB mode?
also do we need to change the PHY_R2 register values
(PHY_R2_PHY_TX_VBOOST_LVL for example) for PCIe, for example if the
bootloader initialized the PHY in USB3 mode while the board actually
exposes a PCIe port?


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

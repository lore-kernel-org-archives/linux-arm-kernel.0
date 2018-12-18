Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF12CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:50:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFFFF20874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TgwtOcBg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Izb3/GFO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFFFF20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dOM2HbDApkMItP8PN15WunBVw7ChsKGqYxGT/Y16pAQ=; b=TgwtOcBg7A0kQY
	9UI+DnvSG0Tws7b6/CTCpduPq5pwB4jzxZVUZmE3z28V+5KFA1zBOP+qk3CeMWb0r6Mr/ji7hpQK/
	K9fQ6IrkUQ/DMg7XZ5J69QgyZJHaSP50INMgwWDwmooUsS8nSg/2ld2fbfE70iCJRBBi6rBjKb0vz
	Gp/U4kJaDlUVbBcSeh/NisGa3NifbhcPLlYzChWOmzGyuddt/P3rdl4b06uxIxOADZad26rnMG8G3
	QG1CcA1GdcSQJhp6D/ICUt81SIXjRROX3Ep9LFd1vT9bJ7sWChHYZEXOFga+QzJSVJMWBEqHM2pCb
	pP2NdcrtEiGuaFvfxa5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ6Ox-0003CI-9o; Tue, 18 Dec 2018 03:50:35 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ6Op-0003BP-DX; Tue, 18 Dec 2018 03:50:33 +0000
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AF29D21849;
 Tue, 18 Dec 2018 03:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545105017;
 bh=nf9/1bm3hBCP/Y6CurT6Mh3N1LPIZB808p5rFP/voUM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Izb3/GFOGJnyrJMxgIQQ7weSJI75nqElZD2I2AbpagDgIFKTa7mwKkJak+2NvWOov
 b6Up+49rZ5yEBoo/uUgAqG/fNbh8sbsOQvVE5uSuE6ZRGKiRc8garfBiJdnYARcQKO
 w8D33SCQsA8eIi/jNDRqFHVACMFzoGLAvXlMZpS0=
Received: by mail-wm1-f50.google.com with SMTP id g67so1243582wmd.2;
 Mon, 17 Dec 2018 19:50:16 -0800 (PST)
X-Gm-Message-State: AA+aEWZXvgEYsX7sM3phAKqqokFsPbOYKFJIJ3pluwn4XkL8d4m+UGJT
 dXl4euc3uC/hKaGhxXQJfBqrizGlYojTXpdDcwU=
X-Google-Smtp-Source: AFSGD/XaW6U8YNzEALwgfEeQ/wOMZe2gyAQ8A8hBM1fKF440RmRbIXn0yIjf0ozEGePZFPmdwFVfbkjQ3exMNxWZMGM=
X-Received: by 2002:a1c:2e43:: with SMTP id u64mr1452607wmu.52.1545105015165; 
 Mon, 17 Dec 2018 19:50:15 -0800 (PST)
MIME-Version: 1.0
References: <1545100937-16093-1-git-send-email-biao.huang@mediatek.com>
 <1545100937-16093-3-git-send-email-biao.huang@mediatek.com>
In-Reply-To: <1545100937-16093-3-git-send-email-biao.huang@mediatek.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Mon, 17 Dec 2018 19:49:47 -0800
X-Gmail-Original-Message-ID: <CAGp9LzoWYdQ_PHgHbTmg35EvFY+kdFMZy5Pz7ndpPC0pUZ-uGg@mail.gmail.com>
Message-ID: <CAGp9LzoWYdQ_PHgHbTmg35EvFY+kdFMZy5Pz7ndpPC0pUZ-uGg@mail.gmail.com>
Subject: Re: [PATCH 2/2] net-next: stmmac: dwmac-mediatek: remove fine-tune
 property
To: Biao Huang <biao.huang@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_195027_495571_165E9AE6 
X-CRM114-Status: GOOD (  20.35  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, nelson.chang@mediatek.com,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 Liguo Zhang <liguo.zhang@mediatek.com>, joabreu@synopsys.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 linux-mediatek@lists.infradead.org, honghui.zhang@mediatek.com,
 Matthias Brugger <matthias.bgg@gmail.com>, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 17, 2018 at 6:43 PM Biao Huang <biao.huang@mediatek.com> wrote:
>
> 1. remove fine-tune property and related setting to simplify
> the timing adjustment flow.
> 2. set timing value according to the value from device tree,
> and will not care whether PHY insert internal delay.
>
> Signed-off-by: Biao Huang <biao.huang@mediatek.com>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   |   71 +++++++-------------
>  1 file changed, 24 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> index e400cbd..801c797 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> @@ -44,7 +44,6 @@ struct mac_delay_struct {
>         u32 rx_delay;
>         bool tx_inv;
>         bool rx_inv;
> -       bool fine_tune;
>  };
>
>  struct mediatek_dwmac_plat_data {
> @@ -105,16 +104,28 @@ static int mt2712_set_interface(struct mediatek_dwmac_plat_data *plat)
>         return 0;
>  }
>
> -static void mt2712_delay_ps2stage(struct mac_delay_struct *mac_delay)
> +static void mt2712_delay_ps2stage(struct mediatek_dwmac_plat_data *plat)
>  {
> -       if (mac_delay->fine_tune) {
> -               /* 170ps per stage for fine tune delay macro circuit*/
> -               mac_delay->tx_delay /= 170;
> -               mac_delay->rx_delay /= 170;
> -       } else {
> -               /* 550ps per stage for coarse tune delay macro circuit*/
> +       struct mac_delay_struct *mac_delay = &plat->mac_delay;
> +
> +       switch (plat->phy_mode) {
> +       case PHY_INTERFACE_MODE_MII:
> +       case PHY_INTERFACE_MODE_RMII:
> +               /* 550ps per stage for mii/rmii*/
>                 mac_delay->tx_delay /= 550;
>                 mac_delay->rx_delay /= 550;
> +               break;
> +       case PHY_INTERFACE_MODE_RGMII:
> +       case PHY_INTERFACE_MODE_RGMII_TXID:
> +       case PHY_INTERFACE_MODE_RGMII_RXID:
> +       case PHY_INTERFACE_MODE_RGMII_ID:
> +               /* 170ps per stage for mii/rmii*/

mii/rmii appear to be a typo here.

Additionally, I'd suggest using the capital letters for these abbreviations.

> +               mac_delay->tx_delay /= 170;
> +               mac_delay->rx_delay /= 170;
> +               break;
> +       default:
> +               dev_err(plat->dev, "phy interface not supported\n");
> +               break;
>         }
>  }
>
> @@ -123,7 +134,7 @@ static int mt2712_set_delay(struct mediatek_dwmac_plat_data *plat)
>         struct mac_delay_struct *mac_delay = &plat->mac_delay;
>         u32 delay_val = 0, fine_val = 0;
>
> -       mt2712_delay_ps2stage(mac_delay);
> +       mt2712_delay_ps2stage(plat);
>
>         switch (plat->phy_mode) {
>         case PHY_INTERFACE_MODE_MII:
> @@ -167,13 +178,10 @@ static int mt2712_set_delay(struct mediatek_dwmac_plat_data *plat)
>                         fine_val = ETH_RMII_DLY_TX_INV;
>                 break;
>         case PHY_INTERFACE_MODE_RGMII:
> -               /* the PHY is not responsible for inserting any internal
> -                * delay by itself in PHY_INTERFACE_MODE_RGMII case,
> -                * so Ethernet MAC will insert delays for both transmit
> -                * and receive path here.
> -                */
> -               if (mac_delay->fine_tune)
> -                       fine_val = ETH_FINE_DLY_GTXC | ETH_FINE_DLY_RXC;
> +       case PHY_INTERFACE_MODE_RGMII_TXID:
> +       case PHY_INTERFACE_MODE_RGMII_RXID:
> +       case PHY_INTERFACE_MODE_RGMII_ID:
> +               fine_val = ETH_FINE_DLY_GTXC | ETH_FINE_DLY_RXC;
>
>                 delay_val |= FIELD_PREP(ETH_DLY_GTXC_ENABLE, !!mac_delay->tx_delay);
>                 delay_val |= FIELD_PREP(ETH_DLY_GTXC_STAGES, mac_delay->tx_delay);
> @@ -183,36 +191,6 @@ static int mt2712_set_delay(struct mediatek_dwmac_plat_data *plat)
>                 delay_val |= FIELD_PREP(ETH_DLY_RXC_STAGES, mac_delay->rx_delay);
>                 delay_val |= FIELD_PREP(ETH_DLY_RXC_INV, mac_delay->rx_inv);
>                 break;
> -       case PHY_INTERFACE_MODE_RGMII_TXID:
> -               /* the PHY should insert an internal delay for the transmit
> -                * path in PHY_INTERFACE_MODE_RGMII_TXID case,
> -                * so Ethernet MAC will insert the delay for receive path here.
> -                */
> -               if (mac_delay->fine_tune)
> -                       fine_val = ETH_FINE_DLY_RXC;
> -
> -               delay_val |= FIELD_PREP(ETH_DLY_RXC_ENABLE, !!mac_delay->rx_delay);
> -               delay_val |= FIELD_PREP(ETH_DLY_RXC_STAGES, mac_delay->rx_delay);
> -               delay_val |= FIELD_PREP(ETH_DLY_RXC_INV, mac_delay->rx_inv);
> -               break;
> -       case PHY_INTERFACE_MODE_RGMII_RXID:
> -               /* the PHY should insert an internal delay for the receive
> -                * path in PHY_INTERFACE_MODE_RGMII_RXID case,
> -                * so Ethernet MAC will insert the delay for transmit path here.
> -                */
> -               if (mac_delay->fine_tune)
> -                       fine_val = ETH_FINE_DLY_GTXC;
> -
> -               delay_val |= FIELD_PREP(ETH_DLY_GTXC_ENABLE, !!mac_delay->tx_delay);
> -               delay_val |= FIELD_PREP(ETH_DLY_GTXC_STAGES, mac_delay->tx_delay);
> -               delay_val |= FIELD_PREP(ETH_DLY_GTXC_INV, mac_delay->tx_inv);
> -               break;
> -       case PHY_INTERFACE_MODE_RGMII_ID:
> -               /* the PHY should insert internal delays for both transmit
> -                * and receive path in PHY_INTERFACE_MODE_RGMII_RXID case,
> -                * so Ethernet MAC will NOT insert any delay here.
> -                */
> -               break;
>         default:
>                 dev_err(plat->dev, "phy interface not supported\n");
>                 return -EINVAL;
> @@ -270,7 +248,6 @@ static int mediatek_dwmac_config_dt(struct mediatek_dwmac_plat_data *plat)
>
>         mac_delay->tx_inv = of_property_read_bool(plat->np, "mediatek,txc-inverse");
>         mac_delay->rx_inv = of_property_read_bool(plat->np, "mediatek,rxc-inverse");
> -       mac_delay->fine_tune = of_property_read_bool(plat->np, "mediatek,fine-tune");
>         plat->rmii_rxc = of_property_read_bool(plat->np, "mediatek,rmii-rxc");
>
>         return 0;
> --
> 1.7.9.5
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

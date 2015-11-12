From: davem@davemloft.net (David Miller)
Date: Thu, 12 Nov 2015 16:12:21 -0500 (EST)
Subject: [PATCH v2] stmmac: avoid ipq806x constant overflow warning
In-Reply-To: <3825178.3luTQFAgny@wuerfel>
References: <20151112.122528.1794206832971213176.davem@davemloft.net>
 <3729464.5X0HBxzvx5@wuerfel> <3825178.3luTQFAgny@wuerfel>
Message-ID: <20151112.161221.471436899716074817.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 12 Nov 2015 22:03:40 +0100

> @@ -337,11 +337,11 @@ static int ipq806x_gmac_probe(struct platform_device *pdev)
>  			     QSGMII_PHY_RX_SIGNAL_DETECT_EN |
>  			     QSGMII_PHY_TX_DRIVER_EN |
>  			     QSGMII_PHY_QSGMII_EN |
> -			     0x4 << QSGMII_PHY_PHASE_LOOP_GAIN_OFFSET |
> -			     0x3 << QSGMII_PHY_RX_DC_BIAS_OFFSET |
> -			     0x1 << QSGMII_PHY_RX_INPUT_EQU_OFFSET |
> -			     0x2 << QSGMII_PHY_CDR_PI_SLEW_OFFSET |
> -			     0xC << QSGMII_PHY_TX_DRV_AMP_OFFSET);
> +			     0x4ul << QSGMII_PHY_PHASE_LOOP_GAIN_OFFSET |
> +			     0x3ul << QSGMII_PHY_RX_DC_BIAS_OFFSET |
> +			     0x1ul << QSGMII_PHY_RX_INPUT_EQU_OFFSET |
> +			     0x2ul << QSGMII_PHY_CDR_PI_SLEW_OFFSET |
> +			     0xCul << QSGMII_PHY_TX_DRV_AMP_OFFSET);
>  	}
>  

Indeed, this looks so much better.

Applied.

Thanks for looking more deeply into this!

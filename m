From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Dec 2016 10:45:02 +0000
Subject: [PATCH v4 11/12] arm64: dts: marvell: add sdhci support for
 Armada 7K/8K
In-Reply-To: <2564fe18eb9cc8a0a1a3311cdf7e7141f35211bd.1481651244.git-series.gregory.clement@free-electrons.com>
References: <cover.67d726f70f6bd48d38a2023513f2711080bc66c8.1481651244.git-series.gregory.clement@free-electrons.com>
 <2564fe18eb9cc8a0a1a3311cdf7e7141f35211bd.1481651244.git-series.gregory.clement@free-electrons.com>
Message-ID: <20161222104502.GV14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2016 at 06:48:40PM +0100, Gregory CLEMENT wrote:
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> index 7b6136182ad0..181e8c5de3bf 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> @@ -229,6 +229,15 @@
>  
>  			};
>  
> +			ap_sdhci0: sdhci at 6e0000 {
> +				compatible = "marvell,armada-7000-sdhci";
> +				reg = <0x6e0000 0x300>;
> +				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> +				clock-names = "core";
> +				clocks = <&cpm_syscon0 1 4>;

This seems to be the wrong clock - how can the AP SDHCI core be connected
to the CPM syscon (which is on a different die.)

I think you first need a patch to add this clock to the AP syscon...

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

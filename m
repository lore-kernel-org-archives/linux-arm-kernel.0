From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Dec 2016 10:47:25 +0000
Subject: [PATCH v4 11/12] arm64: dts: marvell: add sdhci support for
 Armada 7K/8K
In-Reply-To: <2564fe18eb9cc8a0a1a3311cdf7e7141f35211bd.1481651244.git-series.gregory.clement@free-electrons.com>
References: <cover.67d726f70f6bd48d38a2023513f2711080bc66c8.1481651244.git-series.gregory.clement@free-electrons.com>
 <2564fe18eb9cc8a0a1a3311cdf7e7141f35211bd.1481651244.git-series.gregory.clement@free-electrons.com>
Message-ID: <20161222104725.GW14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2016 at 06:48:40PM +0100, Gregory CLEMENT wrote:
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> index e5e3ed678b6f..035b2b2fc9ca 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> @@ -164,6 +164,16 @@
>  				clocks = <&cpm_syscon0 1 21>;
>  				status = "disabled";
>  			};
> +
> +			cpm_sdhci0: sdhci at 780000 {
> +				compatible = "marvell,armada-7000-sdhci";
> +				reg = <0x780000 0x300>;
> +				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> +				clock-names = "core";
> +				clocks = <&cpm_syscon0 1 4>;
> +				status = "disabled";
> +			};
> +

Oh, and a nitpick, since I've already commented on this patch - there's
a needless extra blank line here...

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 4 Apr 2014 18:00:13 +0200
Subject: [PATCH 1/2] ARM: mvebu: enable the SDHCI interface on Armada 385
In-Reply-To: <1396626125-8631-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1396626125-8631-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1396626125-8631-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140404160013.GK2798@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 04, 2014 at 05:42:04PM +0200, Thomas Petazzoni wrote:
> In commit "mmc: sdhci-pxav3: add support for the Armada 38x SDHCI
> controller", the sdhci-pxav3 driver has been extended to also be
> usable on Armada 38x platforms.
> 
> Therefore, this commit adds the necessary Device Tree informations to
> declare this SDHCI interface in the Armada 38x SoC, and also in the
> Armada 385 Development Board.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-385-db.dts | 8 ++++++++
>  arch/arm/boot/dts/armada-38x.dtsi   | 9 +++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/armada-385-db.dts b/arch/arm/boot/dts/armada-385-db.dts
> index 6828d77..959aeed 100644
> --- a/arch/arm/boot/dts/armada-385-db.dts
> +++ b/arch/arm/boot/dts/armada-385-db.dts
> @@ -101,6 +101,14 @@
>  					reg = <0x1000000 0x3f000000>;
>  				};
>  			};
> +
> +			sdhci at d8000 {
> +				clock-frequency = <200000000>;
> +				broken-cd;
> +				wp-inverted;
> +				bus-width = <8>;
> +				status = "okay";
> +			};
>  		};
>  
>  		pcie-controller {
> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> index a064f59..2c1ff30 100644
> --- a/arch/arm/boot/dts/armada-38x.dtsi
> +++ b/arch/arm/boot/dts/armada-38x.dtsi
> @@ -355,6 +355,15 @@
>  				clocks = <&coredivclk 0>;
>  				status = "disabled";
>  			};
> +
> +			sdhci at d8000 {
> +				compatible = "marvell,armada-380-sdhci";
> +				reg = <0xd8000 0x1000>, <0xdc000 0x100>;
> +				interrupts = <0 25 0x4>;
> +				clocks = <&gateclk 17>;
> +				mrvl,clk-delay-cycles = <0x1F>;

Hi Thomas

Maybe this has been discussed as part of the previous patchset. Why
the mrvl prefix, not marvell? marvell is in vendor-prefixes.txt, but
mrvl does not appear to be listed.

     Andrew

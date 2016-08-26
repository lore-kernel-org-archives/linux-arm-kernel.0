From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 26 Aug 2016 11:45:12 +0200
Subject: [PATCH] ARM: dts: armada-38x: Add NAND pinctrl information
In-Reply-To: <20160823232115.23973-1-chris.packham@alliedtelesis.co.nz> (Chris
 Packham's message of "Wed, 24 Aug 2016 11:21:15 +1200")
References: <20160823232115.23973-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <87lgzjj23b.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,
 
 On mer., ao?t 24 2016, Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> Add pin control information for the NAND flash interface. This interface
> is multiplexed with the device bus interface to the function is "dev"
> not "nand" as one might expect.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Applied on mvebu/dt

Thanks,

Gregory
> ---
>  arch/arm/boot/dts/armada-38x.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> index 3312be6c82cc..30381d421d43 100644
> --- a/arch/arm/boot/dts/armada-38x.dtsi
> +++ b/arch/arm/boot/dts/armada-38x.dtsi
> @@ -287,6 +287,15 @@
>  					marvell,function = "spi1";
>  				};
>  
> +				nand_pins: nand-pins {
> +					marvell,pins = "mpp22", "mpp34", "mpp23",
> +						       "mpp33", "mpp38", "mpp28",
> +						       "mpp40", "mpp42", "mpp35",
> +						       "mpp36", "mpp25", "mpp30",
> +						       "mpp32";
> +					marvell,function = "dev";
> +				};
> +
>  				uart0_pins: uart-pins-0 {
>  					marvell,pins = "mpp0", "mpp1";
>  					marvell,function = "ua0";
> -- 
> 2.9.2.518.ged577c6.dirty
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

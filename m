From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 28 Jul 2016 11:39:14 +0200
Subject: [PATCH 07/18] ARM: mvebu: a39x: update the SDHCI node on Armada
 39x
In-Reply-To: <1469105055-25181-8-git-send-email-jaz@semihalf.com> (Grzegorz
 Jaszczyk's message of "Thu, 21 Jul 2016 14:44:03 +0200")
References: <1469105055-25181-1-git-send-email-jaz@semihalf.com>
 <1469105055-25181-8-git-send-email-jaz@semihalf.com>
Message-ID: <87wpk6ksot.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grzegorz,
 
 On jeu., juil. 21 2016, Grzegorz Jaszczyk <jaz@semihalf.com> wrote:

> Commit 1140011ee9d9 ("mmc: sdhci-pxav3: Modify clock settings
> for the SDR50 and DDR50 modes") has extended the Device Tree
> binding used to describe PXAv3 SDHCI controllers in order to be
> able to use the SDR50 and DDR50 modes.
>
> This commit updates the Device Tree description of the Armada
> 39x SDHCI controller in other to take advantage of this
> functionality.
>
> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>

Change the prefix title to "ARM: dts: mvebu: armada-39x". With this:

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory
> ---
>  arch/arm/boot/dts/armada-39x.dtsi | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/armada-39x.dtsi b/arch/arm/boot/dts/armada-39x.dtsi
> index dc6efd3..cb66f20 100644
> --- a/arch/arm/boot/dts/armada-39x.dtsi
> +++ b/arch/arm/boot/dts/armada-39x.dtsi
> @@ -380,7 +380,10 @@
>  
>  			sdhci at d8000 {
>  				compatible = "marvell,armada-380-sdhci";
> -				reg = <0xd8000 0x1000>, <0xdc000 0x100>;
> +				reg-names = "sdhci", "mbus", "conf-sdio3";
> +				reg = <0xd8000 0x1000>,
> +					<0xdc000 0x100>,
> +					<0x18454 0x4>;
>  				interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&gateclk 17>;
>  				mrvl,clk-delay-cycles = <0x1F>;
> -- 
> 1.8.3.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

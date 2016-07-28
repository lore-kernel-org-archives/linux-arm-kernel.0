From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 28 Jul 2016 12:53:12 +0200
Subject: [PATCH 13/18] ARM: mvebu: a39x: enable rtc for all Armada-39x SoCs
In-Reply-To: <1469105055-25181-15-git-send-email-jaz@semihalf.com> (Grzegorz
 Jaszczyk's message of "Thu, 21 Jul 2016 14:44:10 +0200")
References: <1469105055-25181-1-git-send-email-jaz@semihalf.com>
 <1469105055-25181-15-git-send-email-jaz@semihalf.com>
Message-ID: <8737mukp9j.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grzegorz,
 
 On jeu., juil. 21 2016, Grzegorz Jaszczyk <jaz@semihalf.com> wrote:

> Despite that FS states that rtc is present only in A395 and A398 and not in
> A390, the rtc is working with A390.
>
Change the prefix to "ARM: dts: mvebu: armada-39x:"

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory

> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> ---
>  arch/arm/boot/dts/armada-39x.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/boot/dts/armada-39x.dtsi b/arch/arm/boot/dts/armada-39x.dtsi
> index 1225cd8..5bed8b9 100644
> --- a/arch/arm/boot/dts/armada-39x.dtsi
> +++ b/arch/arm/boot/dts/armada-39x.dtsi
> @@ -429,6 +429,13 @@
>  				};
>  			};
>  
> +			rtc at a3800 {
> +				compatible = "marvell,armada-380-rtc";
> +				reg = <0xa3800 0x20>, <0x184a0 0x0c>;
> +				reg-names = "rtc", "rtc-soc";
> +				interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +
>  			flash at d0000 {
>  				compatible = "marvell,armada370-nand";
>  				reg = <0xd0000 0x54>;
> -- 
> 1.8.3.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

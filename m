From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 28 Jul 2016 14:55:02 +0200
Subject: [PATCH 15/18] ARM: mvebu: a398: update the dtsi about missing
 interfaces
In-Reply-To: <1469105055-25181-17-git-send-email-jaz@semihalf.com> (Grzegorz
 Jaszczyk's message of "Thu, 21 Jul 2016 14:44:12 +0200")
References: <1469105055-25181-1-git-send-email-jaz@semihalf.com>
 <1469105055-25181-17-git-send-email-jaz@semihalf.com>
Message-ID: <87twf9kjmh.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grzegorz,
 
 On jeu., juil. 21 2016, Grzegorz Jaszczyk <jaz@semihalf.com> wrote:

> Beside interfaces described in the armada-39x.dtsi and armada-395.dtsi, the
> Armada 398 SoC family supports 2 additional SATA port (2 ports in one unit)
>
> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>

Change the prefix to "ARM: dts: mvebu: armada-398:"

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory

> ---
>  arch/arm/boot/dts/armada-398.dtsi | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/armada-398.dtsi b/arch/arm/boot/dts/armada-398.dtsi
> index fdc2591..234a998 100644
> --- a/arch/arm/boot/dts/armada-398.dtsi
> +++ b/arch/arm/boot/dts/armada-398.dtsi
> @@ -44,7 +44,7 @@
>   *     OTHER DEALINGS IN THE SOFTWARE.
>   */
>  
> -#include "armada-39x.dtsi"
> +#include "armada-395.dtsi"
>  
>  / {
>  	compatible = "marvell,armada398", "marvell,armada390";
> @@ -55,6 +55,14 @@
>  				compatible = "marvell,mv88f6928-pinctrl";
>  				reg = <0x18000 0x20>;
>  			};
> +
> +			sata at e0000 {
> +				compatible = "marvell,armada-380-ahci";
> +				reg = <0xe0000 0x2000>;
> +				interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&gateclk 30>;
> +				status = "disabled";
> +			};
>  		};
>  	};
>  };
> -- 
> 1.8.3.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Apr 2014 09:47:56 +0200
Subject: [PATCH 2/5] ARM: mvebu: enable the SATA interface on Armada 375 DB
In-Reply-To: <1397806908-7550-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397806908-7550-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397806908-7550-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5350D8AC.1040602@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/04/2014 09:41, Thomas Petazzoni wrote:
> The Armada 375 SoC has a dual-port SATA interface, which is exposed on
> the Armada 375 DB board. This commit therefore enables this interface
> on the Armada 375 DB board.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory

> ---
>  arch/arm/boot/dts/armada-375-db.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/armada-375-db.dts b/arch/arm/boot/dts/armada-375-db.dts
> index 9378d31..0451124 100644
> --- a/arch/arm/boot/dts/armada-375-db.dts
> +++ b/arch/arm/boot/dts/armada-375-db.dts
> @@ -79,6 +79,11 @@
>  				};
>  			};
>  
> +			sata at a0000 {
> +				status = "okay";
> +				nr-ports = <2>;
> +			};
> +
>  			nand: nand at d0000 {
>  				pinctrl-0 = <&nand_pins>;
>  				pinctrl-names = "default";
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

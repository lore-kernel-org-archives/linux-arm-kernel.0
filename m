From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Apr 2014 09:50:43 +0200
Subject: [PATCH 5/5] ARM: mvebu: don't use clocks property in UART node
 for Netgear RN2120
In-Reply-To: <1397806908-7550-6-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397806908-7550-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397806908-7550-6-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5350D953.8010904@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/04/2014 09:41, Thomas Petazzoni wrote:
> The Netgear RN2120 was not using the same strategy as the other Armada
> 370/375/38x/XP boards: it was using a 'clocks' property and not the
> 'clock-frequency' property in its UART controller Device Tree node.
> 
> However, now that this clock reference is present at the SoC-level,
> there is no point in duplicating it at the board-level.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory

> ---
>  arch/arm/boot/dts/armada-xp-netgear-rn2120.dts | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
> index ff049ee..0cf999a 100644
> --- a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
> +++ b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
> @@ -138,7 +138,6 @@
>  			};
>  
>  			serial at 12000 {
> -				clocks = <&coreclk 0>;
>  				status = "okay";
>  			};
>  
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

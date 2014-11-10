From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 10 Nov 2014 15:15:17 +0100
Subject: [PATCH 16/17] ARM: mvebu: adjust mbus controller description
 on Armada 370/XP
In-Reply-To: <1414151970-6626-17-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414151970-6626-17-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5460C875.4090609@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 24/10/2014 13:59, Thomas Petazzoni wrote:
> In order to support suspend/resume on Armada XP, an additional set of
> registers need to be described at the MBus controller level. This
> commit therefore adjusts the Device Tree of the Armada 370/XP SoC to
> include those registers in the MBus controller description;
> 

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory

> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-370-xp.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
> index 83286ec..90dba78 100644
> --- a/arch/arm/boot/dts/armada-370-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-370-xp.dtsi
> @@ -180,7 +180,8 @@
>  
>  			mbusc: mbus-controller at 20000 {
>  				compatible = "marvell,mbus-controller";
> -				reg = <0x20000 0x100>, <0x20180 0x20>;
> +				reg = <0x20000 0x100>, <0x20180 0x20>,
> +				      <0x20250 0x8>;
>  			};
>  
>  			mpic: interrupt-controller at 20000 {
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 10 Nov 2014 15:25:08 +0100
Subject: [PATCH 17/17] ARM: mvebu: add SDRAM controller description for
 Armada XP
In-Reply-To: <1414151970-6626-18-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414151970-6626-18-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5460CAC4.7030008@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,


On 24/10/2014 13:59, Thomas Petazzoni wrote:
> The suspend/resume sequence on Armada XP needs to modify a number of
> registers in the SDRAM controller. Therefore, this commit updates the
> Armada XP Device Tree description to include the SDRAM controller
> Device Tree node.
> 

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory

> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-xp.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
> index bff9f6c..2be244a 100644
> --- a/arch/arm/boot/dts/armada-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-xp.dtsi
> @@ -35,6 +35,11 @@
>  		};
>  
>  		internal-regs {
> +			sdramc at 1400 {
> +				compatible = "marvell,armada-xp-sdram-controller";
> +				reg = <0x1400 0x500>;

It seemed a quite large area, but indeed there are registers related to the sdram
controller at least until the address 0x18AC.

> +			};
> +
>  			L2: l2-cache {
>  				compatible = "marvell,aurora-system-cache";
>  				reg = <0x08000 0x1000>;
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

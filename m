From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 25 Jul 2014 21:46:52 +0200
Subject: [PATCH] ARM: mvebu: armada xp: Generalize use of i2c quirk
In-Reply-To: <1406308951-14612-1-git-send-email-andrew@lunn.ch>
References: <1406308951-14612-1-git-send-email-andrew@lunn.ch>
Message-ID: <53D2B42C.6060008@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/07/2014 19:22, Andrew Lunn wrote:
> A second product has come to light which makes use of the A0 stepping
> of the Armada XP SoC. A0 stepping has a hardware bug in the i2c core
> meaning that hardware offload does not work, resulting in the kernel
> failing to boot. The quirk detects that the kernel is running on an A0
> stepping SoC and disables the use of hardware offload.
> 
> Currently the quirk is only enabled for PlatHome Openblocks AX3. The
> AX3 has been produced with both A0 and B1 stepping SoCs. The second
> product is the Lenovo Iomega IX4-300d. It seems likely that this
> device will also swap from A0 to B1 SoC sometime during its life.
> 
> If there are two products using A0, it seems likely there are more
> products with A0. Also, since the number of A0 SoCs is limited, these
> products are also likely to transition to B1. Hence detecting at run
> time is the safest option. So enable the quirk for all Armada XP
> boards.
> 
> Tested on an AX3 with A0 stepping.


Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory


> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/mach-mvebu/board-v7.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
> index 8bb742fdf5ca..be080cff98d2 100644
> --- a/arch/arm/mach-mvebu/board-v7.c
> +++ b/arch/arm/mach-mvebu/board-v7.c
> @@ -167,7 +167,7 @@ static void __init thermal_quirk(void)
>  
>  static void __init mvebu_dt_init(void)
>  {
> -	if (of_machine_is_compatible("plathome,openblocks-ax3-4"))
> +	if (of_machine_is_compatible("marvell,armadaxp"))
>  		i2c_quirk();
>  	if (of_machine_is_compatible("marvell,a375-db"))
>  		thermal_quirk();
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

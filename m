From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 19 Jan 2015 10:29:23 +0530
Subject: [PATCH] ARM: mach-davinci: Remove driver CDCE949
In-Reply-To: <1421624259-24127-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
References: <1421624259-24127-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Message-ID: <54BC8F2B.10509@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 19 January 2015 05:07 AM, Rickard Strandqvist wrote:
> Remove driver CDCE949 because it is not used anywhere.
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>


> diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
> index ae129bc..8be5aef 100644
> --- a/arch/arm/mach-davinci/board-dm646x-evm.c
> +++ b/arch/arm/mach-davinci/board-dm646x-evm.c
> @@ -45,7 +45,6 @@
>  #include <mach/irqs.h>
>  #include <mach/serial.h>
>  #include <mach/clock.h>
> -#include <mach/cdce949.h>
>  
>  #include "davinci.h"
>  #include "clock.h"
> @@ -399,9 +398,6 @@ static struct i2c_board_info __initdata i2c_info[] =  {
>  	{
>  		I2C_BOARD_INFO("cpld_video", 0x3b),
>  	},
> -	{
> -		I2C_BOARD_INFO("cdce949", 0x6c),
> -	},
>  };

There is cdce_clk_init() and associated data structures that also need
to be removed.

Thanks,
Sekhar

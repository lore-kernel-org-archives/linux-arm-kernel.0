From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 5 Feb 2013 10:34:11 -0500
Subject: [PATCH] ARM: Kirkwood: Add missing linux/i2c.h include
In-Reply-To: <1360077025-8046-1-git-send-email-thierry.reding@avionic-design.de>
References: <1360077025-8046-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <20130205153411.GV14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thierry,

On Tue, Feb 05, 2013 at 04:10:25PM +0100, Thierry Reding wrote:
> The nsa310 board uses I2C_BOARD_INFO and i2c_register_board_info(), both
> of which are defined in the linux/i2c.h header file.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> ---
>  arch/arm/mach-kirkwood/board-nsa310.c | 1 +
>  1 file changed, 1 insertion(+)

What is this based against?  We're in the process of removing this whole
file for v3.9 (pinctrl, mv643xx_eth, and i2c)...

thx,

Jason.

> 
> diff --git a/arch/arm/mach-kirkwood/board-nsa310.c b/arch/arm/mach-kirkwood/board-nsa310.c
> index 61c4b18..970174a 100644
> --- a/arch/arm/mach-kirkwood/board-nsa310.c
> +++ b/arch/arm/mach-kirkwood/board-nsa310.c
> @@ -11,6 +11,7 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/gpio.h>
> +#include <linux/i2c.h>
>  #include <mach/kirkwood.h>
>  #include <linux/of.h>
>  #include "common.h"
> -- 
> 1.8.1.2
> 

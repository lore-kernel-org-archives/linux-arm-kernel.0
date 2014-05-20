From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 20 May 2014 16:03:58 +0100
Subject: [PATCH 2/7] mfd: twl4030-power: Fix some defines for SW_EVENTS
In-Reply-To: <1400031250-29542-3-git-send-email-tony@atomide.com>
References: <1400031250-29542-1-git-send-email-tony@atomide.com>
 <1400031250-29542-3-git-send-email-tony@atomide.com>
Message-ID: <20140520150358.GX24991@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> We have these bits partially defined in two different
> places, so let's fix them up and add defines for the
> missing bits. These bits are the same for P1_SW_EVENTS,
> P2_SW_EVENTS and P3_SW_EVENTS.
> 
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/mfd/twl4030-power.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
> index 1b30d8a..c0e4fc3 100644
> --- a/drivers/mfd/twl4030-power.c
> +++ b/drivers/mfd/twl4030-power.c
> @@ -35,7 +35,14 @@
>  static u8 twl4030_start_script_address = 0x2b;
>  
>  #define PWR_P1_SW_EVENTS	0x10

BIT(4)?

> +#define PWR_STOPON_PRWON	(1 << 6)
> +#define PWR_STOPON_SYSEN	(1 << 5)
> +#define PWR_ENABLE_WARMRESET	(1 << 4)
> +#define PWR_LVL_WAKEUP		(1 << 3)
> +#define PWR_DEVACT		(1 << 2)
> +#define PWR_DEVSLP		(1 << 1)
>  #define PWR_DEVOFF		(1 << 0)
> +
>  #define SEQ_OFFSYNC		(1 << 0)

Please use the BIT() macro for these.

[...]

Once fixed, apply my Acked-by on re-submission.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

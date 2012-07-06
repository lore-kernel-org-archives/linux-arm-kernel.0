From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 06 Jul 2012 14:59:29 +0200
Subject: [PATCH 1/2] ARM: OMAP: board-4430sdp: MUX configuration for
 sys_nirq2
In-Reply-To: <1341564590-14024-1-git-send-email-peter.ujfalusi@ti.com>
References: <1341564590-14024-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <4FF6E131.1030008@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/06/2012 10:49 AM, Peter Ujfalusi wrote:
> The sys_nirq2 is used for twl6040, make sure the pin is configured
> correctly.

Please ignore this two patch, I'll resend them with the correct MUX config.
By mistake I have set MUX_MODE1, while it must be set MUX_MODE0.
It was working with MUX_MODE1, but it is not aligned with the TRM...

Sorry,
P?ter

> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  arch/arm/mach-omap2/board-4430sdp.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> index c4e17641..050cc8e 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -827,6 +827,9 @@ static void __init omap_4430sdp_display_init(void)
>  #ifdef CONFIG_OMAP_MUX
>  static struct omap_board_mux board_mux[] __initdata = {
>  	OMAP4_MUX(USBB2_ULPITLL_CLK, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
> +	/* NIRQ2 for twl6040 */
> +	OMAP4_MUX(SYS_NIRQ2, OMAP_MUX_MODE1 |
> +		  OMAP_PIN_INPUT_PULLUP | OMAP_PIN_OFF_WAKEUPENABLE),
>  	{ .reg_offset = OMAP_MUX_TERMINATOR },
>  };
>  
> 

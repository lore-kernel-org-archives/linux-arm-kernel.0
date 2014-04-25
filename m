From: archit@ti.com (Archit Taneja)
Date: Fri, 25 Apr 2014 16:41:18 +0530
Subject: [PATCH 06/23] ARM: OMAP: add OMAP5 DSI muxing
In-Reply-To: <1398334639-14172-7-git-send-email-tomi.valkeinen@ti.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
 <1398334639-14172-7-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <535A42D6.5090107@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday 24 April 2014 03:47 PM, Tomi Valkeinen wrote:
> Add support to set OMAP5 DSI pin muxing.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
>   arch/arm/mach-omap2/display.c | 35 ++++++++++++++++++++++++++++++++++-
>   1 file changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
> index 16d33d831287..974461441fc3 100644
> --- a/arch/arm/mach-omap2/display.c
> +++ b/arch/arm/mach-omap2/display.c
> @@ -137,11 +137,42 @@ static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
>   	return 0;
>   }
>
> +#define CONTROL_PAD_BASE	0x4A002800
> +#define CONTROL_DSIPHY		0x614
> +

I guess this is something we can move to our driver, and use sysconf to 
get the register from DT.

Archit

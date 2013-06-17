From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Jun 2013 23:22:35 +0800
Subject: [PATCH v2 1/5] clk: divider: replace bitfield width with mask
In-Reply-To: <1371437905-15567-2-git-send-email-mturquette@linaro.org>
References: <1371437905-15567-1-git-send-email-mturquette@linaro.org>
 <1371437905-15567-2-git-send-email-mturquette@linaro.org>
Message-ID: <20130617152233.GK31687@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 16, 2013 at 07:58:21PM -0700, Mike Turquette wrote:
> The forthcoming Device Tree binding for the divider clock type will use
> a bitfield mask instead of bitfield width, which is what the current
> basic divider implementation uses.
> 
> This patch replaces the u8 width in struct clk_divider with a u32 mask.
> The divider code is updated to use the bit mask internally but the two
> registration functions still accept the width to maintain compatibility
> with existing users.
> 
> Also updated in this patch is the clk-private.h divider macro and two
> Freescale clock divider implementations that are based on struct
> clk_divider.
> 
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Mike Turquette <mturquette@linaro.org>
> ---
> No change since v1, new patch
> 
>  arch/arm/mach-imx/clk-busy.c |  2 +-
>  drivers/clk/clk-divider.c    | 31 +++++++++++++++----------------
>  drivers/clk/mxs/clk-div.c    |  2 +-
>  include/linux/clk-private.h  |  2 +-
>  include/linux/clk-provider.h |  2 +-
>  5 files changed, 19 insertions(+), 20 deletions(-)

On imx and mxs,

Tested-by: Shawn Guo <shawn.guo@linaro.org>

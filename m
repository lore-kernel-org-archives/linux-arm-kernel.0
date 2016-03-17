From: eric@anholt.net (Eric Anholt)
Date: Thu, 17 Mar 2016 09:57:14 -0700
Subject: [PATCH 2/8] clk: bcm2835: add missing PLL clock divider
In-Reply-To: <1456760642-2412-3-git-send-email-kernel@martin.sperl.org>
References: <1456760642-2412-1-git-send-email-kernel@martin.sperl.org>
 <1456760642-2412-3-git-send-email-kernel@martin.sperl.org>
Message-ID: <87y49hjb4l.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel at martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> Add the missing pll clock divider definitions.
>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> ---
>  drivers/clk/bcm/clk-bcm2835.c       |   50 +++++++++++++++++++++++++++++++++++
>  include/dt-bindings/clock/bcm2835.h |    8 ++++++
>  2 files changed, 58 insertions(+)
>
> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
> index 01a48cb..710cf15 100644
> --- a/drivers/clk/bcm/clk-bcm2835.c
> +++ b/drivers/clk/bcm/clk-bcm2835.c
> @@ -1497,6 +1497,22 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
>  		.load_mask = CM_PLLA_LOADPER,
>  		.hold_mask = CM_PLLA_HOLDPER,
>  		.fixed_divider = 1),
> +	[BCM2835_PLLA_DSI0]	= REGISTER_PLL_DIV(
> +		.name = "plla_dsi0",
> +		.source_pll = "plla",
> +		.cm_reg = CM_PLLA,
> +		.a2w_reg = A2W_PLLA_DSI0,
> +		.load_mask = CM_PLLA_LOADDSI0,
> +		.hold_mask = CM_PLLA_HOLDDSI0,
> +		.fixed_divider = 1),
> +	[BCM2835_PLLA_CCP2]	= REGISTER_PLL_DIV(
> +		.name = "plla_ccp2",
> +		.source_pll = "plla",
> +		.cm_reg = CM_PLLA,
> +		.a2w_reg = A2W_PLLA_DSI0,
> +		.load_mask = CM_PLLA_LOADCCP2,
> +		.hold_mask = CM_PLLA_HOLDCCP2,
> +		.fixed_divider = 1),
>
>  	/* PLLB is used for the ARM's clock. */
>  	[BCM2835_PLLB]		= REGISTER_PLL(
> @@ -1521,6 +1537,24 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
>  		.load_mask = CM_PLLB_LOADARM,
>  		.hold_mask = CM_PLLB_HOLDARM,
>  		.fixed_divider = 1),
> +	[BCM2835_PLLB_SP0]	= REGISTER_PLL_DIV(
> +		.name = "pllb_sp0",
> +		.source_pll = "pllb",
> +		.cm_reg = CM_PLLB,
> +		.a2w_reg = A2W_PLLB_SP0,
> +		.fixed_divider = 1),
> +	[BCM2835_PLLB_SP1]	= REGISTER_PLL_DIV(
> +		.name = "pllb_sp1",
> +		.source_pll = "pllb",
> +		.cm_reg = CM_PLLB,
> +		.a2w_reg = A2W_PLLB_SP1,
> +		.fixed_divider = 1),
> +	[BCM2835_PLLB_SP2]	= REGISTER_PLL_DIV(
> +		.name = "pllb_sp2",
> +		.source_pll = "pllb",
> +		.cm_reg = CM_PLLB,
> +		.a2w_reg = A2W_PLLB_SP2,
> +		.fixed_divider = 1),

These don't exist on the hardware as far as I've been able to find.  "I
found it in a header file somewhere" is not sufficient justification to
expose it.

I'm working on getting a series of all of these reviewed and ready, so
I'm just dropping these PLLB hunks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160317/fa0f898f/attachment.sig>

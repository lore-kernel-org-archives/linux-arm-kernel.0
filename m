From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 13 Nov 2018 14:26:58 +0100
Subject: [PATCH v4 03/26] clk: sunxi-ng: Add check for maximum rate to
 NKM PLLs
In-Reply-To: <20181113111633.20189-4-jagan@amarulasolutions.com>
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
 <20181113111633.20189-4-jagan@amarulasolutions.com>
Message-ID: <20181113132658.niwy6bqdqzaeqpv2@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2018 at 04:46:10PM +0530, Jagan Teki wrote:
> Some NKM PLLs, frequency can be set above PLL working range.
> 
> Add a constraint for maximum supported rate. This way, drivers can
> specify which is maximum allowed rate for PLL.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>

As Vasily reported on a previous version, this should be squashed with
the patch 2.

> ---
>  drivers/clk/sunxi-ng/ccu_nkm.c | 3 +++
>  drivers/clk/sunxi-ng/ccu_nkm.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
> index 6b5ad990f802..b8b66cdd30bf 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> @@ -128,6 +128,9 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
>  	if (rate < nkm->min_rate)
>  		return nkm->min_rate;
>  
> +	if (nkm->max_rate && rate > nkm->max_rate)
> +		return nkm->max_rate;
> +

I would expect the test to be the same for the minimum and maximum cases.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181113/1217c715/attachment.sig>

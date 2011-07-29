From: vinod.koul@intel.com (Koul, Vinod)
Date: Fri, 29 Jul 2011 17:39:15 +0530
Subject: [PATCH 04/18] dmaengine/amba-pl08x: Remove redundant comment
	and rewrite original
In-Reply-To: <e2c1bd6941e88f8988b1942c13c20cf436b3a963.1311936524.git.viresh.kumar@st.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<e2c1bd6941e88f8988b1942c13c20cf436b3a963.1311936524.git.viresh.kumar@st.com>
Message-ID: <1311941355.1536.529.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-07-29 at 16:19 +0530, Viresh Kumar wrote:
> Similar comment is present over routine also pl08x_choose_master_bus(). Keeping
> one of them. Also rewrite that comment to convey message clearly.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  drivers/dma/amba-pl08x.c |   11 +++--------
>  1 files changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
> index 1f7c510..4a64fdf 100644
> --- a/drivers/dma/amba-pl08x.c
> +++ b/drivers/dma/amba-pl08x.c
> @@ -498,9 +498,9 @@ struct pl08x_lli_build_data {
>  };
>  
>  /*
> - * Autoselect a master bus to use for the transfer this prefers the
> - * destination bus if both available if fixed address on one bus the
> - * other will be chosen
> + * Autoselect a master bus to use for the transfer
> + * - prefers the destination bus if both available
> + * - if fixed address on one bus the other will be chosen
Not sure I get it, English is not my first language :)
>   */
>  static void pl08x_choose_master_bus(struct pl08x_lli_build_data *bd,
>  	struct pl08x_bus_data **mbus, struct pl08x_bus_data **sbus, u32 cctl)
> @@ -626,11 +626,6 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
>  	/* We need to count this down to zero */
>  	bd.remainder = txd->len;
>  
> -	/*
> -	 * Choose bus to align to
> -	 * - prefers destination bus if both available
> -	 * - if fixed address on one bus chooses other
> -	 */
>  	pl08x_choose_master_bus(&bd, &mbus, &sbus, cctl);
>  
>  	dev_vdbg(&pl08x->adev->dev, "src=0x%08x%s/%u dst=0x%08x%s/%u len=%zu "


-- 
~Vinod

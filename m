From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 28 Jun 2011 16:53:27 +0530
Subject: [PATCH] davinci: da850: add a .set_rate method to ref_clk
In-Reply-To: <1308073157-22993-1-git-send-email-christian.riesch@omicron.at>
References: <B85A65D85D7EB246BE421B3FB0FBB593024D4CF84E@dbde02.ent.ti.com>
	<1308073157-22993-1-git-send-email-christian.riesch@omicron.at>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D7939D4@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christian,

On Tue, Jun 14, 2011 at 23:09:17, Christian Riesch wrote:
> This patch allows setting the input clock frequency of the SoC from
> the board specific using the davinci_set_refclk_rate function.

"board specific code"

> 
> Suggested-by: Kevin Hilman <khilman@ti.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Christian Riesch <christian.riesch@omicron.at>
> ---
> 
> This patch applies on top of Sekhar's patch.
> Best regards, Christian
> 
>  arch/arm/mach-davinci/da850.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> index 133aac4..27fe3ac 100644
> --- a/arch/arm/mach-davinci/da850.c
> +++ b/arch/arm/mach-davinci/da850.c
> @@ -58,6 +58,7 @@ static struct pll_data pll0_data = {
>  static struct clk ref_clk = {
>  	.name		= "ref_clk",
>  	.rate		= DA850_REF_FREQ,
> +	.set_rate       = davinci_simple_set_rate,

Please use tabs for indentation.

Thanks,
Sekhar

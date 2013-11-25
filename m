From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Sun, 24 Nov 2013 18:15:26 -0800 (PST)
Subject: [PATCH 1/3] ARM: shmobile: r8a7779: add HSPI clock support for DT
In-Reply-To: <1385341216-27101-2-git-send-email-horms+renesas@verge.net.au>
References: <1385341216-27101-1-git-send-email-horms+renesas@verge.net.au>
 <1385341216-27101-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <87ob59ns5h.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Simon

Thank you for this patch

> Based on work for the r8a7778 SoC by Kuninori Morimoto.
> 
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/mach-shmobile/clock-r8a7779.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
> index b7ce0e7..09ca2ea 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7779.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7779.c
> @@ -198,8 +198,11 @@ static struct clk_lookup lookups[] = {
>  	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP022]), /* SCIF4 */
>  	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP021]), /* SCIF6 */
>  	CLKDEV_DEV_ID("sh-hspi.0", &mstp_clks[MSTP007]), /* HSPI0 */
> +	CLKDEV_DEV_ID("fffc7000.sh-hspi", &mstp_clks[MSTP007]), /* HSPI0 */
>  	CLKDEV_DEV_ID("sh-hspi.1", &mstp_clks[MSTP007]), /* HSPI1 */
> +	CLKDEV_DEV_ID("fffc8000.sh-hspi", &mstp_clks[MSTP007]), /* HSPI1 */
>  	CLKDEV_DEV_ID("sh-hspi.2", &mstp_clks[MSTP007]), /* HSPI2 */
> +	CLKDEV_DEV_ID("fffc6000.sh-hspi", &mstp_clks[MSTP007]), /* HSPI2 */
>  	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP323]), /* SDHI0 */
>  	CLKDEV_DEV_ID("ffe4c000.sd", &mstp_clks[MSTP323]), /* SDHI0 */
>  	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP322]), /* SDHI1 */

I guess, [2/3] patch is using

	hspi0: spi at fffc7000 {

So, the correct name is...

 - fffc7000.sh-hspi
 + fffc7000.spi


Best regards
---
Kuninori Morimoto

From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 02 Apr 2013 16:17:10 +0400
Subject: [PATCH 16/30] ARM: shmobile: sh7372: use fixed ratio clock
In-Reply-To: <1364879246-9470-17-git-send-email-horms+renesas@verge.net.au>
References: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
 <1364879246-9470-17-git-send-email-horms+renesas@verge.net.au>
Message-ID: <515ACC46.9020402@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 02-04-2013 9:07, Simon Horman wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

> Current clock-sh7372 is using own implement
> for each divX clocks.
> This patch switches to use fixed ratio clock,
> and was tesed on mackerel board.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Acked-by: Magnus Damm <damm@opensource.se>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   arch/arm/mach-shmobile/clock-sh7372.c |   44 ++++++---------------------------
>   1 file changed, 7 insertions(+), 37 deletions(-)

> diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
> index 6c23e3f..7e10593 100644
> --- a/arch/arm/mach-shmobile/clock-sh7372.c
> +++ b/arch/arm/mach-shmobile/clock-sh7372.c
[...]
> @@ -83,39 +84,12 @@ struct clk sh7372_extal2_clk = {
[...]
> +SH_FIXED_RATIO_CLKg(sh7372_dv_clki_div2_clk,	sh7372_dv_clki_clk,	div2);
> +SH_FIXED_RATIO_CLK(extal1_div2_clk,		sh7372_extal1_clk,	div2);
> +SH_FIXED_RATIO_CLK(extal2_div2_clk,		sh7372_extal2_clk,	div2);
> +SH_FIXED_RATIO_CLK(extal2_div4_clk,		extal2_div2_clk,	div2);

    Note that SH_FIXED_RATIO_CLK() definition already includes ; -- it 
probably should be removed from there.

WBR, Sergei

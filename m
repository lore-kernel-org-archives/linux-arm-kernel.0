From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 02 Jun 2014 22:13:29 +0400
Subject: [PATCH 1/4] ARM: shmobile: r8a7791: Add SYS-DMAC clocks
In-Reply-To: <1401716424-29740-2-git-send-email-geert+renesas@glider.be>
References: <1401716424-29740-1-git-send-email-geert+renesas@glider.be>
 <1401716424-29740-2-git-send-email-geert+renesas@glider.be>
Message-ID: <538CBEC9.6090707@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 06/02/2014 05:40 PM, Geert Uytterhoeven wrote:

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>   arch/arm/mach-shmobile/clock-r8a7791.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)

> diff --git a/arch/arm/mach-shmobile/clock-r8a7791.c b/arch/arm/mach-shmobile/clock-r8a7791.c
> index e2fdfcc14436..b0b2294513e2 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7791.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7791.c
> @@ -178,7 +178,7 @@ enum {
>   	MSTP719, MSTP718, MSTP715, MSTP714,
>   	MSTP522,
>   	MSTP314, MSTP312, MSTP311,
> -	MSTP216, MSTP207, MSTP206,
> +	MSTP219, MSTP218, MSTP216, MSTP207, MSTP206,

    I'd put the latter two on a separate line or on the same line with the 
following three.

>   	MSTP204, MSTP203, MSTP202,
>   	MSTP124,
>   	MSTP_NR
> @@ -215,6 +215,8 @@ static struct clk mstp_clks[MSTP_NR] = {
>   	[MSTP312] = SH_CLK_MSTP32_STS(&div6_clks[DIV6_SD1], SMSTPCR3, 12, MSTPSR3, 0), /* SDHI1 */
>   	[MSTP311] = SH_CLK_MSTP32_STS(&div6_clks[DIV6_SD2], SMSTPCR3, 11, MSTPSR3, 0), /* SDHI2 */
>   	[MSTP216] = SH_CLK_MSTP32_STS(&mp_clk, SMSTPCR2, 16, MSTPSR2, 0), /* SCIFB2 */
> +	[MSTP219] = SH_CLK_MSTP32_STS(&mp_clk, SMSTPCR2, 19, MSTPSR2, 0), /* SYS-DMAC0 */
> +	[MSTP218] = SH_CLK_MSTP32_STS(&mp_clk, SMSTPCR2, 18, MSTPSR2, 0), /* SYS-DMAC1 */

    I think these 2 clocks should precede SCIFB2 clock.

>   	[MSTP207] = SH_CLK_MSTP32_STS(&mp_clk, SMSTPCR2, 7, MSTPSR2, 0), /* SCIFB1 */
>   	[MSTP206] = SH_CLK_MSTP32_STS(&mp_clk, SMSTPCR2, 6, MSTPSR2, 0), /* SCIFB0 */
>   	[MSTP204] = SH_CLK_MSTP32_STS(&mp_clk, SMSTPCR2, 4, MSTPSR2, 0), /* SCIFA0 */

WBR, Sergei

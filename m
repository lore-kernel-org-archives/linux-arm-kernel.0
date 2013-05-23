From: horms@verge.net.au (Simon Horman)
Date: Thu, 23 May 2013 10:39:02 +0900
Subject: [PATCH v4 4/7] ARM: shmobile: sh73a0: Add timer DT names to
 clock list
In-Reply-To: <1365679443-25456-4-git-send-email-hechtb+renesas@gmail.com>
References: <1365679443-25456-1-git-send-email-hechtb+renesas@gmail.com>
 <1365679443-25456-4-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <20130523013902.GB22608@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 01:24:00PM +0200, Bastian Hecht wrote:
> This adds temporarily the alternative device names to the clock list
> that are used when booting via Device Tree setup.
> 
> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>

As per my recent email regarding "ARM: shmobile: sh73a0: Add timer DT names
to clock list", I have dropped this patch which was previously queued-up
for v3.11.

> ---
> v4: same. only patches 2 and 3 are changed.
> 
>  arch/arm/mach-shmobile/clock-sh73a0.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
> index 784fbaa..5d98322 100644
> --- a/arch/arm/mach-shmobile/clock-sh73a0.c
> +++ b/arch/arm/mach-shmobile/clock-sh73a0.c
> @@ -535,7 +535,9 @@ static struct clk_lookup lookups[] = {
>  	CLKDEV_DEV_ID("sh_mobile_ceu.0", &mstp_clks[MSTP127]), /* CEU0 */
>  	CLKDEV_DEV_ID("sh-mobile-csi2.0", &mstp_clks[MSTP126]), /* CSI2-RX0 */
>  	CLKDEV_DEV_ID("sh_tmu.0", &mstp_clks[MSTP125]), /* TMU00 */
> +	CLKDEV_DEV_ID("fff60008.timer", &mstp_clks[MSTP125]), /* TMU00 */
>  	CLKDEV_DEV_ID("sh_tmu.1", &mstp_clks[MSTP125]), /* TMU01 */
> +	CLKDEV_DEV_ID("fff60014.timer", &mstp_clks[MSTP125]), /* TMU01 */
>  	CLKDEV_DEV_ID("sh-mipi-dsi.0", &mstp_clks[MSTP118]), /* DSITX */
>  	CLKDEV_DEV_ID("i2c-sh_mobile.0", &mstp_clks[MSTP116]), /* I2C0 */
>  	CLKDEV_DEV_ID("e6820000.i2c", &mstp_clks[MSTP116]), /* I2C0 */
> @@ -552,6 +554,7 @@ static struct clk_lookup lookups[] = {
>  	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP200]), /* SCIFA4 */
>  	CLKDEV_DEV_ID("sh-sci.6", &mstp_clks[MSTP331]), /* SCIFA6 */
>  	CLKDEV_DEV_ID("sh_cmt.10", &mstp_clks[MSTP329]), /* CMT10 */
> +	CLKDEV_DEV_ID("e6138010.timer", &mstp_clks[MSTP329]), /* CMT10 */
>  	CLKDEV_DEV_ID("sh_fsi2", &mstp_clks[MSTP328]), /* FSI */
>  	CLKDEV_DEV_ID("sh_irda.0", &mstp_clks[MSTP325]), /* IrDA */
>  	CLKDEV_DEV_ID("i2c-sh_mobile.1", &mstp_clks[MSTP323]), /* I2C1 */
> -- 
> 1.7.9.5
> 

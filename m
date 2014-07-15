From: horms@verge.net.au (Simon Horman)
Date: Wed, 16 Jul 2014 08:52:35 +0900
Subject: [PATCH 4/4] ARM: shmobile: sh73a0: add SCI clock support for DT
In-Reply-To: <53C52A69.7080808@cogentembedded.com>
References: <cover.1405398284.git.horms+renesas@verge.net.au>
 <ff4ce48e1f163d945c037c1c90ce12950961d91d.1405398284.git.horms+renesas@verge.net.au>
 <53C52A69.7080808@cogentembedded.com>
Message-ID: <20140715235233.GH557@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 15, 2014 at 05:19:37PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 07/15/2014 01:16 PM, Simon Horman wrote:
> 
> >This will be used when initialising SCI devices using DT
> >until common clock framework support is added.
> 
> >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >---
> >  arch/arm/mach-shmobile/clock-sh73a0.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> 
> >diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
> >index 0d9cd1f..4990e03 100644
> >--- a/arch/arm/mach-shmobile/clock-sh73a0.c
> >+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
> >@@ -638,16 +638,25 @@ static struct clk_lookup lookups[] = {
> >  	CLKDEV_DEV_ID("e6820000.i2c", &mstp_clks[MSTP116]), /* I2C0 */
> >  	CLKDEV_DEV_ID("sh_mobile_lcdc_fb.0", &mstp_clks[MSTP100]), /* LCDC0 */
> >  	CLKDEV_DEV_ID("sh-sci.7", &mstp_clks[MSTP219]), /* SCIFA7 */
> >+	CLKDEV_DEV_ID("e6cd0000.serial", &mstp_clks[MSTP219]), /* SCIFA7 */
> >  	CLKDEV_DEV_ID("sh-dma-engine.0", &mstp_clks[MSTP218]), /* SY-DMAC */
> >  	CLKDEV_DEV_ID("sh-dma-engine.1", &mstp_clks[MSTP217]), /* MP-DMAC */
> >  	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP207]), /* SCIFA5 */
> >+	CLKDEV_DEV_ID("e6cb0000.serial", &mstp_clks[MSTP207]), /* SCIFA5 */
> >  	CLKDEV_DEV_ID("sh-sci.8", &mstp_clks[MSTP206]), /* SCIFB */
> >+	CLKDEV_DEV_ID("0xe6c3000.serial", &mstp_clks[MSTP206]), /* SCIFB */
> 
>    Eh, are you sure there should be "0x"?

Thanks, I'll clean that up in a follow-up patch.

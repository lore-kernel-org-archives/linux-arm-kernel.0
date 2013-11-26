From: horms@verge.net.au (Simon Horman)
Date: Tue, 26 Nov 2013 09:25:31 +0900
Subject: [PATCH 1/3] ARM: shmobile: r8a7779: add HSPI clock support for DT
In-Reply-To: <52931A89.8060905@cogentembedded.com>
References: <1385341216-27101-1-git-send-email-horms+renesas@verge.net.au>
 <1385341216-27101-2-git-send-email-horms+renesas@verge.net.au>
 <52931A89.8060905@cogentembedded.com>
Message-ID: <20131126002531.GE15227@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 01:38:17PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 25-11-2013 5:00, Simon Horman wrote:
> 
> >Based on work for the r8a7778 SoC by Kuninori Morimoto.
> 
> >Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >---
> >  arch/arm/mach-shmobile/clock-r8a7779.c | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> >diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
> >index b7ce0e7..09ca2ea 100644
> >--- a/arch/arm/mach-shmobile/clock-r8a7779.c
> >+++ b/arch/arm/mach-shmobile/clock-r8a7779.c
> >@@ -198,8 +198,11 @@ static struct clk_lookup lookups[] = {
> >  	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP022]), /* SCIF4 */
> >  	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP021]), /* SCIF6 */
> >  	CLKDEV_DEV_ID("sh-hspi.0", &mstp_clks[MSTP007]), /* HSPI0 */
> >+	CLKDEV_DEV_ID("fffc7000.sh-hspi", &mstp_clks[MSTP007]), /* HSPI0 */
> >  	CLKDEV_DEV_ID("sh-hspi.1", &mstp_clks[MSTP007]), /* HSPI1 */
> >+	CLKDEV_DEV_ID("fffc8000.sh-hspi", &mstp_clks[MSTP007]), /* HSPI1 */
> >  	CLKDEV_DEV_ID("sh-hspi.2", &mstp_clks[MSTP007]), /* HSPI2 */
> >+	CLKDEV_DEV_ID("fffc6000.sh-hspi", &mstp_clks[MSTP007]), /* HSPI2 */
> 
>    The device names here don't seem to match to the device names in
> the .dtsi file.

Thanks, I will fix that.

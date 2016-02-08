From: horms@verge.net.au (Simon Horman)
Date: Mon, 8 Feb 2016 10:21:45 +0100
Subject: [PATCH v2] arm64: dts: r8a7795: pmu: switch to Cortex specific
 device nodes
In-Reply-To: <56B47378.3080209@de.bosch.com>
References: <1452953636-4995-1-git-send-email-dirk.behme@gmail.com>
 <56B236F4.4090409@gmail.com> <20160205095445.GD16556@verge.net.au>
 <56B47378.3080209@de.bosch.com>
Message-ID: <20160208092145.GA15520@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 05, 2016 at 11:03:36AM +0100, Dirk Behme wrote:
> On 05.02.2016 10:54, Simon Horman wrote:
> >[CC shiny new linux-renesas-soc ML]
> 
> 
> Yes, thanks. I've to learn and remember this, too :)
> 
> 
> >On Wed, Feb 03, 2016 at 06:20:52PM +0100, Dirk Behme wrote:
> >>On 16.01.2016 15:13, Dirk Behme wrote:
> >>>Instead of using the generic armv8-pmuv3 compatibility use the more
> >>>specific Cortex A57 compatibility.
> >>>
> >>>Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
> >>>---
> >>>Changes in v2: Drop the not yet merged Cortex A53 part.
> >>>
> >>>  arch/arm64/boot/dts/renesas/r8a7795.dtsi | 4 ++--
> >>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>>diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> >>>index 266c5de..a82bce8 100644
> >>>--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> >>>+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> >>>@@ -247,8 +247,8 @@
> >>>  			power-domains = <&cpg>;
> >>>  		};
> >>>
> >>>-		pmu {
> >>>-			compatible = "arm,armv8-pmuv3";
> >>>+		pmu_a57 {
> >>>+			compatible = "arm,cortex-a57-pmu";
> >>>  			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
> >>>  				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
> >>>  				     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
> >>>
> >>
> >>
> >>Any further comments to this? If not, could this be applied?
> >
> >Hi Dirk,
> >
> >I apologise for loosing track of this one.
> >
> >Does this change work? I saw some discussion about using arm,cortex-a57-pmu
> >not working correctly on the r8a7795 in an earlier thread.
> 
> Yes, the A57 PMU probe is successful.
> 
> What's not working with the latest Renesas BSP is the A53, because these
> cores are disabled in the firmware coming with that BSP. But that's not a
> PMU issue, it's just because the cores are disabled. Using an older BSP
> firmware enabling all cores makes the A53 PMU probe fine, too.

Thanks for the explanation. I have queued up this patch.

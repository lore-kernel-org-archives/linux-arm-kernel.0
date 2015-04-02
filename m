From: horms@verge.net.au (Simon Horman)
Date: Thu, 2 Apr 2015 10:33:59 +0900
Subject: [PATCH 2/2] ARM: shmobile: r8a7790: add EtherAVB DT support
In-Reply-To: <551AB78B.4000506@cogentembedded.com>
References: <1625400.M0MxPQybIy@wasted.cogentembedded.com>
 <8163383.0UU0Q5gsLE@wasted.cogentembedded.com>
 <20150331002113.GB16289@verge.net.au>
 <551AB78B.4000506@cogentembedded.com>
Message-ID: <20150402013359.GB25445@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 31, 2015 at 06:04:43PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 03/31/2015 03:21 AM, Simon Horman wrote:
> 
> >>Define the generic R8A7790 part of the EtherAVB device node.
> 
> >Please repost once this binding (and associated driver) has been accepted.
> 
>    OK, but will you merge patch #1?

I would prefer to wait until we can exercise it with a driver.

> >>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >>
> >>---
> >>  arch/arm/boot/dts/r8a7790.dtsi |   10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >>Index: renesas/arch/arm/boot/dts/r8a7790.dtsi
> >>===================================================================
> >>--- renesas.orig/arch/arm/boot/dts/r8a7790.dtsi
> >>+++ renesas/arch/arm/boot/dts/r8a7790.dtsi
> >>@@ -626,6 +626,16 @@
> >>  		status = "disabled";
> >>  	};
> >>
> >>+	avb: ethernet at e6800000 {
> >>+		compatible = "renesas,ravb-r8a7790";
> 
>    I went the usual way here but I suspect that SoC part of the prop should
> be "-rcar-gen2" as we now have this IP core (as well as most of the others,
> except PFC) described in a common manual for the R-Car generation 2 SoCs.
> What do you think?

I like -r8a7790.

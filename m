From: horms@verge.net.au (Simon Horman)
Date: Wed, 3 Sep 2014 10:03:47 +0900
Subject: [PATCH 2/3] clocksource: sh_mtu2: Document r7s72100 binding
In-Reply-To: <53FDBC6B.5090801@cogentembedded.com>
References: <1409115600-26192-1-git-send-email-horms+renesas@verge.net.au>
 <1409115600-26192-3-git-send-email-horms+renesas@verge.net.au>
 <53FDBC6B.5090801@cogentembedded.com>
Message-ID: <20140903010347.GB2903@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 03:09:31PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 8/27/2014 8:59 AM, Simon Horman wrote:
> 
> >In general Renesas hardware is not documented to the extent
> >where the relationship between IP blocks on different SoCs can be assumed
> >although they may appear to operate the same way. Furthermore the
> >documentation typically does not specify a version for individual
> >IP blocks. For these reasons a convention of using the SoC name in place
> >of a version and providing SoC-specific compat strings has been adopted.
> 
> >Although not universally liked this convention is used in the bindings
> >for the drivers a number of drivers for Renesas hardware. The purpose
> >of this patch is to update the Renesas R-Car Multi-Function Timer Pulse
> >Unit 2 (MTU2) driver to follow this convention.
> 
> >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> >---
> >* I plan to follow up with a patch patch to use the new binding in the
> >   dtsi files for the r7s72100 SoC.
> >---
> >  Documentation/devicetree/bindings/timer/renesas,mtu2.txt | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> >diff --git a/Documentation/devicetree/bindings/timer/renesas,mtu2.txt b/Documentation/devicetree/bindings/timer/renesas,mtu2.txt
> >index 917453f..ec4d334 100644
> >--- a/Documentation/devicetree/bindings/timer/renesas,mtu2.txt
> >+++ b/Documentation/devicetree/bindings/timer/renesas,mtu2.txt
> >@@ -8,7 +8,9 @@ are independent. The MTU2 hardware supports five channels indexed from 0 to 4.
> >
> >  Required Properties:
> >
> >-  - compatible: must contain "renesas,mtu2"
> >+  - compatible: must be one of the following.
> 
>    Your example below has both.

Thanks, as I will change "one of" to "one or more of".

> >+    - "renesas,mtu2" for generic MTU2
> >+    - "renesas,mtu2-r7s72100" for R7S72100 MTU2
> >
> >    - reg: base address and length of the registers block for the timer module.
> >
> >@@ -26,7 +28,7 @@ Required Properties:
> >  Example: R7S72100 (RZ/A1H) MTU2 node
> >
> >  	mtu2: timer at fcff0000 {
> >-		compatible = "renesas,mtu2";
> >+		compatible = "renesas,mtu2-r7s72100", "renesas,mtu2";
> >  		reg = <0xfcff0000 0x400>;
> >  		interrupts = <0 139 IRQ_TYPE_LEVEL_HIGH>,
> >  			     <0 146 IRQ_TYPE_LEVEL_HIGH>,
> 
> WBR, Sergei
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

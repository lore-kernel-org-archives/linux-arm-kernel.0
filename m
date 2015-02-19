From: horms@verge.net.au (Simon Horman)
Date: Thu, 19 Feb 2015 12:55:02 -0500
Subject: [PATCH 1/2] ARM: shmobile: r8a7794: add MMCIF DT support
In-Reply-To: <54E61740.8030708@cogentembedded.com>
References: <29687119.ELU9MoH02q@wasted.cogentembedded.com>
 <4040756.88Rqm1nt32@wasted.cogentembedded.com>
 <20150219161012.GA3864@verge.net.au>
 <54E61740.8030708@cogentembedded.com>
Message-ID: <20150219175458.GA18262@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 19, 2015 at 08:02:56PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 02/19/2015 07:10 PM, Simon Horman wrote:
> 
> >>Define the generic R8A7794 part of the MMCIF0 device node.
> 
> >>Based on the orginal patch by Shinobu Uehara <shinobu.uehara.xc@renesas.com>.
> 
> >>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> >>---
> >>  arch/arm/boot/dts/r8a7794.dtsi |   11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> 
> >>Index: renesas/arch/arm/boot/dts/r8a7794.dtsi
> >>===================================================================
> >>--- renesas.orig/arch/arm/boot/dts/r8a7794.dtsi
> >>+++ renesas/arch/arm/boot/dts/r8a7794.dtsi
> >>@@ -346,6 +346,17 @@
> >>  		status = "disabled";
> >>  	};
> >>
> >>+	mmcif0: mmc at ee200000 {
> >>+		compatible = "renesas,mmcif-r8a7794", "renesas,sh-mmcif";
> 
> >Please submit a patch to add "renesas,mmcif-r8a7794" to
> >Documentation/devicetree/bindings/mmc/renesas,mmcif.txt.
> >I looked and I couldn't find such a change in-tree or in-flight.
> 
>    That file doesn't match the reality at all. It says:
> 
> <<
> - compatible: must contain one of the following
>         - "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
>         - "renesas,mmcif-r8a7790" for the MMCIF found in r8a7790 SoCs
>         - "renesas,mmcif-r8a7791" for the MMCIF found in r8a7791 SoCs
>         - "renesas,sh-mmcif" for the generic MMCIF
> >>
> 
> while in reality, the driver only matches on the latter string and doesn't
> care for the SoC specific strings.

By documenting the binding in that file it exists and may be used in DT
nodes. It may or may not be used by the driver now or in the future.

For better or worse this one way that bindings may be handled.

Strictly speaking it shouldn't be used in DT before it exists,
even only in the documentation. But in this case its just a minor
update to an existing scheme so it seems unlikely to be rejected.

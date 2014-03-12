From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 12 Mar 2014 18:29:36 -0300
Subject: [PATCH 4/6] ARM: mvebu: Add support for NAND controller in
 Armada 38x SoC
In-Reply-To: <5320D3FD.8010704@cogentembedded.com>
References: <1394637404-7651-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1394637404-7651-5-git-send-email-ezequiel.garcia@free-electrons.com>
 <5320CEE7.6020506@cogentembedded.com>
 <20140312203007.GA7396@arch.cereza>
 <5320D3FD.8010704@cogentembedded.com>
Message-ID: <20140312212936.GA2384@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mar 13, Sergei Shtylyov wrote:
> On 03/12/2014 11:30 PM, Ezequiel Garcia wrote:
> 
> >>>The Armada 38x SoC family has a NAND controller, compatible
> >>>with the controller in Armada 370/375/XP SoCs. Add support for
> >>>it in the devicetree file.
> 
> >>>Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> >>>---
> >>>  arch/arm/boot/dts/armada-38x.dtsi | 10 ++++++++++
> >>>  1 file changed, 10 insertions(+)
> 
> >>>diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> >>>index 76cc27e..18d8f80 100644
> >>>--- a/arch/arm/boot/dts/armada-38x.dtsi
> >>>+++ b/arch/arm/boot/dts/armada-38x.dtsi
> >>>@@ -345,6 +345,16 @@
> >>>  				clocks = <&mainpll>;
> >>>  				clock-output-names = "nand";
> >>>  			};
> >>>+
> >>>+			nand at d0000 {
> 
> >>    ePAPR standard [1] tells us:
> 
> >>The name of a node should be somewhat generic, reflecting the function of
> >>the device and not its precise programming model. If appropriate, the name
> >>should be one of the following choices:
> 
> >>[...]
> >>? flash
> 
> >I think 'nand' is generic enough, isn't it?
> 
>    It is but not more generic than "flash". :-)
> 

Right.

> >FWIW, quite a few other SoCs have chosen 'nand' for the node name, including
> >the other Armada variants. Was this a wrong choice?
> 
>    I guess. There's a lot of wrong choices now all over the
> arch/arm/boot/dts/ because people are probably not aware of the necessary
> documentation such as http://devicetree.org/Device_Tree_Usage (pointing to
> ePAPR and having a passage on the generic device names too).
> 

OK, I guess it's fine. Let's try to do things from now on, at least. I'll fix
this and send a new series.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com

From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 3 Jul 2018 08:04:16 +0100
Subject: [v3 01/10] dt-bindings: mediatek: mmsys: Add support for mfd
In-Reply-To: <4ead47f6-2f69-2afa-bfcc-a240a9845dc4@gmail.com>
References: <cover.1524820923.git.mbrugger@suse.com>
 <64ca273429d92f581568a48f3efe6035af65f579.1524820923.git.mbrugger@suse.com>
 <20180430103029.GD5147@dell>
 <4ead47f6-2f69-2afa-bfcc-a240a9845dc4@gmail.com>
Message-ID: <20180703070416.GD20176@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 Jun 2018, Matthias Brugger wrote:

> 
> 
> On 30/04/18 12:30, Lee Jones wrote:
> > On Fri, 27 Apr 2018, matthias.bgg at kernel.org wrote:
> > 
> >> From: Matthias Brugger <mbrugger@suse.com>
> >>
> >> Add binding description for the mmsys mfd for some Mediatek
> >> devices. mmsys has some registers to control clock gates (which is
> >> used in the clk driver) and some registers to set the routing and enable
> >> the differnet blocks of the display subsystem.
> >>
> >> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> >> ---
> >>  .../bindings/arm/mediatek/mediatek,mmsys.txt       |  2 --
> >>  .../bindings/display/mediatek/mediatek,disp.txt    |  2 +-
> >>  .../devicetree/bindings/mfd/mediatek,mmsys.txt     | 27 ++++++++++++++++++++++
> >>  3 files changed, 28 insertions(+), 3 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mmsys.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> >> index 4eb8bbe15c01..4468345f8b1a 100644
> >> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> >> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> >> @@ -6,10 +6,8 @@ The Mediatek mmsys controller provides various clocks to the system.
> >>  Required Properties:
> >>  
> >>  - compatible: Should be one of:
> >> -	- "mediatek,mt2701-mmsys", "syscon"
> >>  	- "mediatek,mt2712-mmsys", "syscon"
> >>  	- "mediatek,mt6797-mmsys", "syscon"
> >> -	- "mediatek,mt8173-mmsys", "syscon"
> >>  - #clock-cells: Must be 1
> >>  
> >>  The mmsys controller uses the common clk binding from
> >> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> >> index 383183a89164..85a3b4ec06cd 100644
> >> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> >> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> >> @@ -9,7 +9,7 @@ function block.
> >>  
> >>  All DISP device tree nodes must be siblings to the central MMSYS_CONFIG node.
> >>  For a description of the MMSYS_CONFIG binding, see
> >> -Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt.
> >> +Documentation/devicetree/bindings/mfd/mediatek,mmsys.txt
> >>  
> >>  DISP function blocks
> >>  ====================
> >> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mmsys.txt b/Documentation/devicetree/bindings/mfd/mediatek,mmsys.txt
> >> new file mode 100644
> >> index 000000000000..2331ae16917e
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mmsys.txt
> >> @@ -0,0 +1,27 @@
> >> +MediaTek MMSYS Multifunction Device Driver
> > 
> > What is "MMSYS"?
> > 
> > "Multi-Function Driver"s are specific to Linux.
> > 
> > What actually is the device?
> 
> It's includes all the DRM parts of the SoC together with the clocks for the
> device. MMSYS IMHO stands for Multi-Media-System.

Please update the document with that information.

Is there a datasheet I can view?

> >> +MMSYS is a multifunction device with the following sub modules:
> >> +- clocks for the multi-media subsystem
> >> +- central node for the DRM subsystem.
> >> +
> >> +This document describes the binding for MFD device. The MFD takes care to initailize
> >> +the clock driver and the DRM driver. More info see
> >> +Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> >> +
> >> +Required properties:
> >> +- compatible: Should be one of:
> >> +	- "mediatek,mt2701-mmsys", "syscon"
> >> +	- "mediatek,mt8173-mmsys", "syscon"
> >> +- #clock-cells: Must be 1
> >> +
> >> +Optional properties:
> >> +- power-domains: list of powerdomains needed for the subsystem to work
> >> +
> >> +Example:
> >> +
> >> +mmsys: clock-controller at 14000000 {
> >> +	compatible = "mediatek,mt8173-mmsys", "syscon";
> >> +	reg = <0 0x14000000 0 0x1000>;
> >> +	power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
> >> +	#clock-cells = <1>;
> >> +};
> > 

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

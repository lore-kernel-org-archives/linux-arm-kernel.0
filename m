From: david@lechnology.com (David Lechner)
Date: Thu, 7 Apr 2016 11:29:37 -0500
Subject: [PATCH v3 00/16] da8xx USB clocks
In-Reply-To: <1458863503-31121-1-git-send-email-david@lechnology.com>
References: <1458863503-31121-1-git-send-email-david@lechnology.com>
Message-ID: <57068AF1.8050909@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/24/2016 06:51 PM, David Lechner wrote:
> This is a reworking of the v2 series based of feedback and review. There were
> very many suggestions, so hopefully I didn't miss any. Here are the highlights...
>
> New stuff:
>
> * Fixed the davinci device tree declarations to use the preferred DT address
>    convention so that the items I have added can be correct too.
> * Moved that davinci clock init so that we don't have to call ioremap in the
>    clock mux functions.
> * Added a new "syscon" device for the CFGCHIP registers. This is used by the
>    USB PHY driver and will be used in the future in common clock framework
>    drivers.
>
> Changed:
>
> * USB clocks are moved to a common file instead of having duplicated code.
> * PHY driver uses syscon for CFGCHIP registers instead of using them directly.
>
> David Lechner (16):
>    dt: davinci: use proper address after @
>    mfd: da8xx-cfgchip: New header file for CFGCHIP registers.
>    ARM: davinici: da8xx: move usb code to new file
>    ARM: davinci: Move clock init after ioremap.
>    ARM: davinci: add set_parent callback for mux clocks
>    ARM: davinci: da850: use clk->set_parent for async3
>    ARM: davinci: da8xx: add usb phy clocks
>    dt-bindings: Add bindings for phy-da8xx-usb
>    phy: da8xx-usb: new driver for DA8xx SoC USB PHY
>    ARM: davinci: da8xx: Add CFGCHIPn syscon platform declaration.
>    ARM: davinci: da8xx: Add USB PHY platform declaration
>    ARM: dt: da850: Add cfgchip syscon node
>    ARM: dt: da850: Add usb phy node
>    usb: ohci-da8xx: Remove code that references mach
>    usb: musb: da8xx: Use devm in probe
>    usb: musb: da8xx: Remove mach code
>


Any further comments before I submit a v4 patchset? Particularly on 
patches 3 and 4 which are new in this v3 submission and have not been 
commented on yet.

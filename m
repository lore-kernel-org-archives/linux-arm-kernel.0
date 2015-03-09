From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 9 Mar 2015 01:22:53 +0000
Subject: [PATCH v6 0/3] irqchip: vf610-mscm: add MSCM interrupt router
 driver
In-Reply-To: <a64c8b81761a9886c83128dcf7749b6d@agner.ch>
References: <1425249689-32354-1-git-send-email-stefan@agner.ch>
 <20150308053110.GF21207@io.lakedaemon.net>
 <a64c8b81761a9886c83128dcf7749b6d@agner.ch>
Message-ID: <20150309012253.GI21207@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 09, 2015 at 12:43:56AM +0100, Stefan Agner wrote:
> On 2015-03-08 06:31, Jason Cooper wrote:
> > On Sun, Mar 01, 2015 at 11:41:26PM +0100, Stefan Agner wrote:
> > ...
> >> Stefan Agner (3):
> >>   irqchip: vf610-mscm-ir: add support for MSCM interrupt router
> >>   irqchip: vf610-mscm: dt-bindings: add MSCM bindings
> >>   ARM: dts: vf610: add Miscellaneous System Control Module (MSCM)
> >>
> >>  .../arm/freescale/fsl,vf610-mscm-cpucfg.txt        |  14 ++
> >>  .../bindings/arm/freescale/fsl,vf610-mscm-ir.txt   |  33 ++++
> >>  arch/arm/boot/dts/vf500.dtsi                       | 137 +------------
> >>  arch/arm/boot/dts/vfxxx.dtsi                       |  49 +++++
> >>  arch/arm/mach-imx/Kconfig                          |   1 +
> >>  drivers/irqchip/Makefile                           |   1 +
> >>  drivers/irqchip/irq-vf610-mscm-ir.c                | 212 +++++++++++++++++++++
> >>  7 files changed, 314 insertions(+), 133 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,vf610-mscm-cpucfg.txt
> >>  create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,vf610-mscm-ir.txt
> >>  create mode 100644 drivers/irqchip/irq-vf610-mscm-ir.c
> > 
> > Applied patches 1 and 2 to irqchip/vybrid.  Please let me know if you need to
> > base other work off of this.
> 
> Thx. Some patches in the patchset to run Linux on the Cortex-M4 of
> Vybrid is based on this driver. I will post a rebased version of that
> probably tomorrow.

What I meant, is: will you be submitting patches which have build or runtime
dependencies on this branch?  If so, I'll make sure to leave irqchip/vybrid up
after I pull it into irqchip/core so that patches going into other trees and
can depend on it.

It's no extra work on my part, I just need to know not to clean it up ;-)

thx,

Jason.

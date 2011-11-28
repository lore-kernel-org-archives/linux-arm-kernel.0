From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 28 Nov 2011 14:42:45 +0000
Subject: [PATCH v2 0/4] Versatile Express DT support
In-Reply-To: <4ED399C8.9080908@gmail.com>
References: <1322060508-11298-1-git-send-email-pawel.moll@arm.com>
 <4ED399C8.9080908@gmail.com>
Message-ID: <20111128144245.GB2465@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2011 at 08:25:12AM -0600, Rob Herring wrote:
> On 11/23/2011 09:01 AM, Pawel Moll wrote:
> > Hello again,
> > 
> > This version of the series (hopefully) addresses all the suggestions
> > made by Dave, Rob and Russell.
> > 
> > The compatible values are specific for the tiles now and the memory
> > map variant is defined as a custom property in the motherboard node.
> > 
> > Tested on V2P-CA9 coretile both with ATAGs and DT and V2P-CA5s with DT.
> > 
> > All comments, as always, welcomed!
> > 
> > Pawel
> > 
> > 
> > 
> > Pawel Moll (4):
> >   ARM: vexpress: Get rid of MMIO_P2V
> >   ARM: vexpress: Add DT support in v2m
> >   ARM: vexpress: Initial RS1 memory map support
> >   ARM: vexpress: DT-based support for CoreTiles Express A5x2 and A9x4
> > 
> >  Documentation/devicetree/bindings/arm/vexpress    |  101 ++++++++
> >  arch/arm/boot/dts/vexpress-v2m-rs1.dtsi           |  192 +++++++++++++++
> >  arch/arm/boot/dts/vexpress-v2m.dtsi               |  191 +++++++++++++++
> >  arch/arm/boot/dts/vexpress-v2p-ca5s.dts           |  132 ++++++++++
> >  arch/arm/boot/dts/vexpress-v2p-ca9.dts            |  146 +++++++++++
> >  arch/arm/include/asm/hardware/arm_timer.h         |    5 +
> >  arch/arm/mach-vexpress/Kconfig                    |   35 +++
> >  arch/arm/mach-vexpress/Makefile                   |    1 +
> >  arch/arm/mach-vexpress/Makefile.boot              |    6 +
> >  arch/arm/mach-vexpress/core.h                     |   21 ++-
> >  arch/arm/mach-vexpress/ct-ca9x4.c                 |   52 +---
> >  arch/arm/mach-vexpress/include/mach/ct-ca9x4.h    |   13 +-
> >  arch/arm/mach-vexpress/include/mach/debug-macro.S |   37 +++-
> >  arch/arm/mach-vexpress/include/mach/motherboard.h |   58 +++--
> >  arch/arm/mach-vexpress/include/mach/uncompress.h  |   13 +-
> >  arch/arm/mach-vexpress/platsmp.c                  |    4 +-
> >  arch/arm/mach-vexpress/v2m.c                      |  265 ++++++++++++++++++---
> >  arch/arm/mach-vexpress/v2p-ca5s_ca9.c             |  115 +++++++++
> >  18 files changed, 1272 insertions(+), 115 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/arm/vexpress
> >  create mode 100644 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
> >  create mode 100644 arch/arm/boot/dts/vexpress-v2m.dtsi
> >  create mode 100644 arch/arm/boot/dts/vexpress-v2p-ca5s.dts
> >  create mode 100644 arch/arm/boot/dts/vexpress-v2p-ca9.dts
> >  create mode 100644 arch/arm/mach-vexpress/v2p-ca5s_ca9.c
> 
> Other than Dave's comments, looks good. For the series:
> 
> Acked-by: Rob Herring <rob.herring@calxeda.com>
> 
> There are a number of compatible strings for various peripherals defined
> without documentation, but you're not really using them so I think it's
> fine for now. BTW, I believe Dave said he was going to document some of
> the primecell peripherals. :)

I hadn't forgotten ... I was going to follow up on those shortly :)

Cheers
---Dave

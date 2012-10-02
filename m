From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Tue, 2 Oct 2012 16:04:54 +0200 (CEST)
Subject: [PATCH 2/2] mtd: sh_flctl: Add device tree support
In-Reply-To: <201210021354.01247.arnd@arndb.de>
References: <1349183522-15321-1-git-send-email-hechtb@gmail.com>
 <1349183522-15321-3-git-send-email-hechtb@gmail.com>
 <201210021354.01247.arnd@arndb.de>
Message-ID: <Pine.LNX.4.64.1210021602250.15778@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd

On Tue, 2 Oct 2012, Arnd Bergmann wrote:

> On Tuesday 02 October 2012, Bastian Hecht wrote:
> > +Required properties:
> > +- compatible : "renesas,shmobile-flctl-sh7372"
> > +- reg : Address range of the FLCTL
> > +- interrupts : flste IRQ number
> > +- nand-bus-width : bus width to NAND chip
> > +
> > +The device tree may optionally contain sub-nodes describing partitions of the
> > +address space. See partition.txt for more detail.
> > +
> > +Example:
> > +
> > +       flctl at e6a30000 {
> > +               #address-cells = <1>;
> > +               #size-cells = <1>;
> > +               compatible = "renesas,shmobile-flctl-sh7372";
> > +               reg = <0xe6a30000 0x100>;
> > +               interrupts = <0x0d80>;
> > +
> > +               nand-bus-width = <16>;
> > +
> > +               system at 0 {
> > +                       label = "system";
> > +                       reg = <0x0 0x8000000>;
> > +               };
> > +
> > +               userdata at 8000000 {
> > +                       label = "userdata";
> > +                       reg = <0x8000000 0x10000000>;
> > +               };
> > +
> > +               cache at 18000000 {
> > +                       label = "cache";
> > +                       reg = <0x18000000 0x8000000>;
> > +               };
> > +       };
> 
> Since you are also adding dma-engine support, I would suggest you specify
> a "dmas" and "dma-names" property as well, so the device can find the
> right dma channel. The code might not do that yet while you're still
> sorting out the dependencies (and the sh dmaengine code is not yet
> converted to DT), but I think it would be good to nail down the binding
> for this device.

Have DMA DT bindings been accepted yet, are they fixed? Wouldn't it be 
better to wait until patches appear in a tree, at least with high 
probability heading towards the mainline, or have they already?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

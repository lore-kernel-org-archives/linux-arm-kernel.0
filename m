From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 28 Oct 2013 15:50:36 -0700
Subject: [PATCH 1/2] mmc: arasan: Add driver for Arasan SDHCI
In-Reply-To: <1873048.2t2L2zW4W9@flatron>
References: <1381864085-8806-1-git-send-email-soren.brinkmann@xilinx.com>
 <1587218.cW45zK0ty2@flatron>
 <b6ced7bb-e8df-4cc1-95a1-df575e37dea7@CO1EHSMHS001.ehs.local>
 <1873048.2t2L2zW4W9@flatron>
Message-ID: <9bba3f23-e6b8-4a9a-93ab-4f89f525a4a2@CO1EHSMHS030.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 11:19:13PM +0100, Tomasz Figa wrote:
> On Monday 28 of October 2013 14:47:38 S?ren Brinkmann wrote:
> > On Mon, Oct 28, 2013 at 10:16:49PM +0100, Tomasz Figa wrote:
> > > Hi Soren,
> > > 
> > > On Tuesday 15 of October 2013 12:08:04 Soren Brinkmann wrote:
> > > > Add a driver for Arasan's SDHCI controller core.
> > > > 
> > > > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > > > ---
> > > > 
> > > >  .../devicetree/bindings/mmc/arasan,sdhci.txt       |  23 +++
> > > >  MAINTAINERS                                        |   1 +
> > > >  drivers/mmc/host/Kconfig                           |  12 ++
> > > >  drivers/mmc/host/Makefile                          |   1 +
> > > >  drivers/mmc/host/sdhci-of-arasan.c                 | 224
> > > > 
> > > > +++++++++++++++++++++ 5 files changed, 261 insertions(+)
> > > > 
> > > >  create mode 100644
> > > > 
> > > > Documentation/devicetree/bindings/mmc/arasan,sdhci.txt create mode
> > > > 100644 drivers/mmc/host/sdhci-of-arasan.c
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > > > b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt new file
> > > > mode
> > > > 100644
> > > > index 000000000000..20f0fc25e270
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > > > @@ -0,0 +1,23 @@
> > > > +Device Tree Bindings for the Arasan SDCHI Controller
> > > > +
> > > > +  The bindings follow the mmc[1] and the clock bindings[2]. Only
> > > > deviations are +  documented here.
> > > > +
> > > > +  [1] Documentation/devicetree/bindings/mmc/mmc.txt
> > > > +  [2] Documentation/devicetree/bindings/clock/clock-bindings.txt
> > > > +
> > > 
> > > > +Required Properties:
> > > According to the example below, the list of required properties lacks
> > > interrupt-related properties.
> > 
> > Well, the interrupt bindings seem to differ between platforms and
> > architecture and looking at documentation for other sdhci bindings it
> > seemed to be okay to avoid documenting them in this place.
> 
> Sure, but I believe that this controller always has an interrupt signal, 
> so at least it should be marked that interrupts need to be specified.
Okay, I'll add these lines:
  - interrupts: Interrupt specifier                                              
  - interrupt-parent: Phandle for the interrupt controller that services                                 
                      interrupts for this device.

	S?ren

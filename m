From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Wed, 23 Feb 2011 08:58:11 +0100
Subject: [PATCH v3] dmaengine: mxs-dma: add dma support for i.MX23/28
In-Reply-To: <20110223055709.GC20346@S2100-06.ap.freescale.net>
References: <1298283699-14635-1-git-send-email-shawn.guo@freescale.com>
	<1298433701.23371.236.camel@vkoul-udesk3>
	<20110223055709.GC20346@S2100-06.ap.freescale.net>
Message-ID: <19812.48659.899411.205912@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo writes:
> On Wed, Feb 23, 2011 at 09:31:41AM +0530, Koul, Vinod wrote:
> > On Mon, 2011-02-21 at 15:51 +0530, Shawn Guo wrote:
> > > This patch adds dma support for Freescale MXS-based SoC i.MX23/28,
> > > including apbh-dma and apbx-dma.
> > > 
> > > * apbh-dma and apbx-dma are supported in the driver as two mxs-dma
> > >   instances.
> > > 
> > > * apbh-dma is different between mx23 and mx28, hardware version
> > >   register is used to differentiate.
> > > 
> > > * mxs-dma supports pio function besides data transfer.  The driver
> > >   uses dma_data_direction DMA_NONE to identify the pio mode, and
> > >   steals sgl and sg_len to get pio words and numbers from clients.
> > > 
> > > * mxs dmaengine has some very specific features, like sense function
> > >   and the special NAND support (nand_lock, nand_wait4ready).  These
> > >   are too specific to implemented in generic dmaengine driver.
> > > 
> > > * The driver refers to imx-sdma and only a single descriptor is
> > >   statically assigned to each channel.
> > > 
> > > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > > ---
> > >  arch/arm/mach-mxs/include/mach/dma.h |   26 ++
> > >  drivers/dma/Kconfig                  |    8 +
> > >  drivers/dma/Makefile                 |    1 +
> > >  drivers/dma/mxs-dma.c                |  719 ++++++++++++++++++++++++++++++++++
> > >  4 files changed, 754 insertions(+), 0 deletions(-)
> > >  create mode 100644 arch/arm/mach-mxs/include/mach/dma.h
> > >  create mode 100644 drivers/dma/mxs-dma.c
> > [snip]
> > 
> > > +#define MXS_DMA_APBH           0
> > > +#define MXS_DMA_APBX           1
> > > +#define dma_is_apbh()          (mxs_dma->dev_id == MXS_DMA_APBH)
> > > +
> > > +#define APBH_VERSION_LATEST    3
> > > +#define apbh_is_old()          (mxs_dma->version < APBH_VERSION_LATEST)
> > > +
> > > +#define HW_APBHX_CTRL0                         0x000
> > > +#define  BM_APBH_CTRL0_APB_BURST8_EN           (1 << 29)
> > > +#define  BM_APBH_CTRL0_APB_BURST_EN            (1 << 28)
> > > +#define  BP_APBH_CTRL0_CLKGATE_CHANNEL         (8)
> > > +#define  BP_APBH_CTRL0_RESET_CHANNEL           (16)
>
There is no need to enclose bare number in macro definitions in
parenthesis.
...


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________

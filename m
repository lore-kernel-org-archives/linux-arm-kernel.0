From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 24 Apr 2013 22:43:20 +0800
Subject: [PATCH 2/2] dma: imx-sdma: move to generic device tree bindings
In-Reply-To: <201304241626.22518.arnd@arndb.de>
References: <1366812273-10833-1-git-send-email-shawn.guo@linaro.org>
 <1366812273-10833-3-git-send-email-shawn.guo@linaro.org>
 <201304241626.22518.arnd@arndb.de>
Message-ID: <20130424144318.GD2736@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 24, 2013 at 04:26:22PM +0200, Arnd Bergmann wrote:
> On Wednesday 24 April 2013, Shawn Guo wrote:
> > +/*
> > + * This enumerates peripheral types. Used for SDMA.
> > + */
> > +#define IMX_DMATYPE_SSI                0  /* MCU domain SSI */
> > +#define IMX_DMATYPE_SSI_SP     1  /* Shared SSI */
> > +#define IMX_DMATYPE_MMC                2  /* MMC */
> > +#define IMX_DMATYPE_SDHC       3  /* SDHC */
> > +#define IMX_DMATYPE_UART       4  /* MCU domain UART */
> > +#define IMX_DMATYPE_UART_SP    5  /* Shared UART */
> > +#define IMX_DMATYPE_FIRI       6  /* FIRI */
> > +#define IMX_DMATYPE_CSPI       7  /* MCU domain CSPI */
> > +#define IMX_DMATYPE_CSPI_SP    8  /* Shared CSPI */
> > +#define IMX_DMATYPE_SIM                9  /* SIM */
> > +#define IMX_DMATYPE_ATA                10 /* ATA */
> > +#define IMX_DMATYPE_CCM                11 /* CCM */
> > +#define IMX_DMATYPE_EXT                12 /* External peripheral */
> > +#define IMX_DMATYPE_MSHC       13 /* Memory Stick Host Controller */
> > +#define IMX_DMATYPE_MSHC_SP    14 /* Shared Memory Stick Host Controller */
> > +#define IMX_DMATYPE_DSP                15 /* DSP */
> > +#define IMX_DMATYPE_MEMORY     16 /* Memory */
> > +#define IMX_DMATYPE_FIFO_MEMORY        17 /* FIFO type Memory */
> > +#define IMX_DMATYPE_SPDIF      18 /* SPDIF */
> > +#define IMX_DMATYPE_IPU_MEMORY 19 /* IPU Memory */
> > +#define IMX_DMATYPE_ASRC       20 /* ASRC */
> > +#define IMX_DMATYPE_ESAI       21 /* ESAI */
> 
> These macros don't seem helpful to me, since they are used in only one
> place each. Why not put the literal numbers into the dts file directly?

Using macros will help us to:

1) Improve the readability of "dmas" property in dts
2) Keep the values stay in sync between kernel and DT

Shawn

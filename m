From: ranjit.waghmode@xilinx.com (Ranjit Abhimanyu Waghmode)
Date: Wed, 5 Aug 2015 05:01:15 +0000
Subject: [LINUX RFC 1/2] mtd: spi-nor: add dual parallel mode support
In-Reply-To: <20150803160829.GX20873@sirena.org.uk>
References: <1438592707-30713-1-git-send-email-ranjit.waghmode@xilinx.com>
 <1438592707-30713-2-git-send-email-ranjit.waghmode@xilinx.com>
 <20150803160829.GX20873@sirena.org.uk>
Message-ID: <7CFCFE83B8145347A1D424EC939F1C3C01492420@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

> -----Original Message-----
> From: Mark Brown [mailto:broonie at kernel.org]
> Sent: Monday, August 03, 2015 9:38 PM
> To: Ranjit Abhimanyu Waghmode
> Cc: dwmw2 at infradead.org; computersforpeace at gmail.com; Michal Simek;
> Soren Brinkmann; zajec5 at gmail.com; ben at decadent.org.uk; marex at denx.de;
> b32955 at freescale.com; knut.wohlrab at de.bosch.com; juhosg at openwrt.org;
> beanhuo at micron.com; linux-mtd at lists.infradead.org; linux-
> kernel at vger.kernel.org; linux-spi at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; Harini Katakam; Punnaiah Choudary Kalluri; Ranjit
> Abhimanyu Waghmode; ran27jit at gmail.com
> Subject: Re: [LINUX RFC 1/2] mtd: spi-nor: add dual parallel mode support
> 
> On Mon, Aug 03, 2015 at 02:35:06PM +0530, Ranjit Waghmode wrote:
> 
> >  drivers/mtd/devices/m25p80.c  |  1 +
> >  drivers/mtd/spi-nor/spi-nor.c | 92 ++++++++++++++++++++++++++++++++++--
> -------
> >  include/linux/mtd/spi-nor.h   |  3 ++
> >  include/linux/spi/spi.h       |  2 +
> >  4 files changed, 79 insertions(+), 19 deletions(-)
> 
> You need to at least split this into two patches, one adding a new SPI interface
> and another using it in MTD.  Probably the MTD core and driver changes need
> splitting too.  Please see SubmittingPatches for discussion of splitting things.
> 

I will split and resend the same.

> > diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h index
> > d673072..8dec349 100644
> > --- a/include/linux/spi/spi.h
> > +++ b/include/linux/spi/spi.h
> > @@ -355,6 +355,8 @@ struct spi_master {
> >  #define SPI_MASTER_NO_TX	BIT(2)		/* can't do buffer write */
> >  #define SPI_MASTER_MUST_RX      BIT(3)		/* requires rx */
> >  #define SPI_MASTER_MUST_TX      BIT(4)		/* requires tx */
> > +#define SPI_MASTER_DATA_STRIPE		BIT(7)		/* support
> data stripe */
> > +#define SPI_MASTER_BOTH_CS		BIT(8)		/* enable both
> chips */
> 
> This is really not adequate description for a new API, I can't tell what "data
> stripe" is supposed to mean at all and I've got at best a vague idea what "both
> chips" really means.  This means other developers won't be able to tell how to
> use or implement these flags either, and it means I can't really review this.  You
> need to provide more information here, both in the code and in the commit
> message.
> 

I'm sorry about that. I have added description in cover letter, but will add more information about the same here too.

> I'd also expect some handling in the core for these, for example error handling if
> they can't be supported.

Will update and send you the updated version.

Thanks,
Ranjit

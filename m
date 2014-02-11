From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 11 Feb 2014 10:59:34 +0800
Subject: [PATCH v4 0/3] serial: fsl_lpuart: add DMA support
In-Reply-To: <c1c2915231eb4595b89327e589bc521d@BL2PR03MB338.namprd03.prod.outlook.com>
References: <1390363773-24108-1-git-send-email-yao.yuan@freescale.com>
 <20140127075025.GC4765@S2101-09.ap.freescale.net>
 <c1c2915231eb4595b89327e589bc521d@BL2PR03MB338.namprd03.prod.outlook.com>
Message-ID: <20140211025932.GB31484@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 01:50:14AM +0000, Yao Yuan wrote:
> Hi, Shawn
> 
> Here I just want the DMA be a selectable property for each board. 
> Is it suitable?

No, it's not.  Just like IRQ line, DMA channel is a SoC level resource.
It should just be there once the SoC is out there.  Nothing to do with
board level configuration.

Shawn

> 
> > -----Original Message-----
> > From: Shawn Guo [mailto:shawn.guo at linaro.org]
> > Sent: Monday, January 27, 2014 3:50 PM
> > To: Yuan Yao-B46683
> > Cc: gregkh at linuxfoundation.org; linux at arm.linux.org.uk; arnd at arndb.de;
> > mark.rutland at arm.com; linux-arm-kernel at lists.infradead.org; linux-
> > serial at vger.kernel.org
> > Subject: Re: [PATCH v4 0/3] serial: fsl_lpuart: add DMA support
> > 
> > On Wed, Jan 22, 2014 at 12:09:30PM +0800, Yuan Yao wrote:
> > > Changed in v4:
> > > - Move dma properties from dtsi to dts.
> > 
> > Why this change?  DMA is a SoC level resource rather than board one.
> > 
> > Shawn
> 

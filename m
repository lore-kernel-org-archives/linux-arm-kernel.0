From: nsekhar@ti.com (Nori, Sekhar)
Date: Thu, 3 Feb 2011 18:29:22 +0530
Subject: [PATCH v1 1/4] davinci: da8xx/omap-l1: add support for SPI
In-Reply-To: <4D4A9E49.60606@criticallink.com>
References: <1296596979-18524-1-git-send-email-michael.williamson@criticallink.com>
	<1296596979-18524-2-git-send-email-michael.williamson@criticallink.com>
	<4D494C6A.30507@mvista.com> <4D49543A.1070302@criticallink.com>
	<B85A65D85D7EB246BE421B3FB0FBB59302487782C9@dbde02.ent.ti.com>
	<4D496EC7.1010808@criticallink.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024877837A@dbde02.ent.ti.com>
	<4D4A9E49.60606@criticallink.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024880B1D9@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Thu, Feb 03, 2011 at 17:53:37, Michael Williamson wrote:
> Hi Sekhar,
> 
> On 2/2/2011 10:37 AM, Nori, Sekhar wrote:
> 
> > Hi Mike,
> > 
> > On Wed, Feb 02, 2011 at 20:18:39, Michael Williamson wrote:
> >  
> >>> Since all the platform device definitions for DA8XX devices happens
> >>> in devices-da8xx.c, it makes sense to get rid of the DA830_DMACH_*
> >>> enum altogether and instead just define the channel numbers used in
> >>> devices-da8xx.c above the actual usage.
> >>>
> >>> Mike, is that something you are willing take-up?
> >>>
> >>
> >>
> >> I can take this up as a separate patch series. I'd like to keep the 
> >> spi platform support series isolated to that subject matter, if that's
> >> OK.
> > 
> > Yes, the clean-up can be a separate series - but it will have to
> > precede the SPI series.
> 
> > 
> 
> 
> Quick question:
> 
> In addition to cleaning up the enums in edma.h, are you also asking to 
> pull the channel / base resources for ASP currently defined in asp.h 
> into devices-da8xx.c as well?  Or should that be left alone? E.G., 
> these defines look like they should go in devices-da8xx and come out 
> of asp.h:
> 
> DAVINCI_DA8XX_MCASP0_REG_BASE
> DAVINCI_DA830_MCASP1_REG_BASE
> DAVINCI_DA8XX_DMA_MCASP0_AREVT
> DAVINCI_DA8XX_DMA_MCASP0_AXEVT
> DAVINCI_DA830_DMA_MCASP1_AREVT
> DAVINCI_DA830_DMA_MCASP1_AXEVT
> 
> If moved, there are other #defines that should then be shuffled out of asp.h
> to other files for other chips/platforms for completeness, E.G.
> 
> DAVINCI_DM646X_DMA_MCASP0_AXEVT0 should go to dm646x.c.
> 
> I'm not too keen on shuffling stuff around like that if I can't test it beyond
> compiling.  Especially if it's not adding any functionality.  But, I will submit
> it if it's necessary to get the SPI support in.

I don't think cleaning up all this ASP stuff is necessary to get SPI in.
Just do:

1) Get rid of the DA830 DMA event enum in edma.h
2) define local macros in devices-da8xx.c for the DMA events used in that 
   file.

The ASP clean-up can be taken-up at a later time.

Thanks for your efforts on this.

Best Regards,
Sekhar

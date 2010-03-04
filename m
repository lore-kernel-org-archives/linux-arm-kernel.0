From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 4 Mar 2010 20:26:23 +0100
Subject: [PATCH] V4L/DVB: mx1-camera: compile fix
In-Reply-To: <Pine.LNX.4.64.1003041811160.4825@axis700.grange>
References: <1267721687-19697-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<Pine.LNX.4.64.1003041811160.4825@axis700.grange>
Message-ID: <20100304192623.GA14587@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guennadi,

On Thu, Mar 04, 2010 at 06:13:38PM +0100, Guennadi Liakhovetski wrote:
> > +#undef DMA_BASE 
> > +#define DMA_BASE MX1_IO_ADDRESS(MX1_DMA_BASE_ADDR)
> 
> I don't like this. Why the "undef"? Is DMA_BASE already defined? where and 
> what is it? If it is - we better use a different name, if not - just 
> remove the undef, please.
yes, it's not pretty, but I wanted to make a minimal patch.

arch/arm/plat-mxc/include/mach/dma-mx1-mx2.h has:

	#define DMA_BASE IO_ADDRESS(DMA_BASE_ADDR)

so that was used before.  I don't really know the driver, just made it
compile again.  If you have a nice suggestion, I will happily implement
it.
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

From: andy@warmcat.com (Andy Green)
Date: Tue, 22 Sep 2009 13:23:00 +0100
Subject: SPI, DMA and an i.MX31
In-Reply-To: <87077C4F48609F4392621D9F99DDE20901202E02@tesla.star.galaxy.io>
References: <87077C4F48609F4392621D9F99DDE20901202DFF@tesla.star.galaxy.io>	<BLU105-W229F8F8F533B107510C600BAE10@phx.gbl>	<87077C4F48609F4392621D9F99DDE20901202E00@tesla.star.galaxy.io>	<4AB7C020.2070205@gmail.com>
	<4AB839FF.4000803@windriver.com>
	<87077C4F48609F4392621D9F99DDE20901202E02@tesla.star.galaxy.io>
Message-ID: <4AB8C1A4.4020403@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/22/09 10:00, Somebody in the thread at some point said:

Hi Rene -

> Wow, there seems to be some interest in this :-)

Yes, I'm working on an iMX31 board at the moment and would love to see 
DMA at the platform level too.

> At the moment I'm just trying to get it to compile. If that works I
> should somehow verify that the api is 'still' working (there are)
> drivers that could be compiled to thest it, right :?)

Take a look at ./drivers/mmc/host/mxcmmc.c -->

#ifdef CONFIG_ARCH_MX2
#include <mach/dma-mx1-mx2.h>
#define HAS_DMA
#endif

If you jiggle that around to match your DMA patch, then you should be 
able to test the SD Card relatively straightforward since the same 
driver is tested with DMA on those platforms presumably.

-Andy

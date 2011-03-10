From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 10 Mar 2011 13:17:24 +0000
Subject: [PATCH 1/8] macb: unify at91 and avr32 platform data
In-Reply-To: <4D78CCBC.2010807@atmel.com>
References: <1299751843-9743-1-git-send-email-jamie@jamieiles.com>
	<1299751843-9743-2-git-send-email-jamie@jamieiles.com>
	<4D78CCBC.2010807@atmel.com>
Message-ID: <20110310131724.GG6198@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2011 at 02:06:04PM +0100, Nicolas Ferre wrote:
> On 3/10/2011 11:10 AM, Jamie Iles :
> > --- a/drivers/net/macb.c
> > +++ b/drivers/net/macb.c
> > @@ -18,12 +18,10 @@
> >  #include <linux/netdevice.h>
> >  #include <linux/etherdevice.h>
> >  #include <linux/dma-mapping.h>
> > +#include <linux/platform_data/macb.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/phy.h>
> >  
> > -#include <mach/board.h>
> > -#include <mach/cpu.h>
> 
> I did not bouble check but do we need no more cpu_is_ macros?

No, I couldn't see any in there and it builds for all of the AT91 
targets and all of the AVR32 ones that I tried.  I can't see any macros 
in there that are likely to use cpu_is_* internally either.

Jamie

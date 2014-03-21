From: alan@linux.intel.com (Alan Cox)
Date: Fri, 21 Mar 2014 00:04:05 +0000
Subject: [RFC] possible removal of omap-serial
In-Reply-To: <20140320235210.GB26964@saruman.home>
References: <20140320235210.GB26964@saruman.home>
Message-ID: <1395360245.22077.43.camel@acox1-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-03-20 at 18:52 -0500, Felipe Balbi wrote:
> Hi folks,
> 
> I've been toying with the idea of removing
> drivers/tty/serial/omap-serial.c since that's, to put it bluntly, an
> ungly copy of 8250 driver.
> 
> The original concern was wrt suspend/resume but I think it'd be a far
> better approach to implement runtime PM in 8250 and write a rather small
> 8250-omap.c glue (much like 8250-acorn.c or 8250-dw.c) just to get the
> OMAP-specific details out of the way.
> 
> The question I have is: omap-serial.c calls the serial devnodes ttyO\d,
> instead of ttyS\d so removing omap-serial.c would have a direct impact
> in userland. I wonder if it's an acceptable "regression" considering
> we'd be able to reuse 8250 gaining proper Flow Control support, proper
> DMA support, years and years of bug-fixes, etc.
> 
> What do you guys say ?

I think it would be better even if we have to support calling it ttyO%d
somehow.

Alan

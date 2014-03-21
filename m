From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 20 Mar 2014 17:12:28 -0700
Subject: [RFC] possible removal of omap-serial
In-Reply-To: <20140320235210.GB26964@saruman.home>
References: <20140320235210.GB26964@saruman.home>
Message-ID: <20140321001228.GA18131@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 20, 2014 at 06:52:10PM -0500, Felipe Balbi wrote:
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

Breaking device node names is a contentious issue for serial ports, I
don't think you can do that :(

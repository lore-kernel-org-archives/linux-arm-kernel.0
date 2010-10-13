From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 13 Oct 2010 19:41:43 -0400 (EDT)
Subject: [PATCH] serial: DCC(JTAG) serial and console emulation support
In-Reply-To: <20101013232604.GA13146@n2100.arm.linux.org.uk>
References: <1286305668-19987-1-git-send-email-dwalker@codeaurora.org>
	<201010132145.30550.arnd@arndb.de>
	<1286999522.28336.15.camel@c-dwalke-linux.qualcomm.com>
	<201010132210.17061.arnd@arndb.de>
	<1287001466.28336.31.camel@c-dwalke-linux.qualcomm.com>
	<alpine.LFD.2.00.1010131638360.2764@xanadu.home>
	<1287002975.28336.44.camel@c-dwalke-linux.qualcomm.com>
	<alpine.LFD.2.00.1010131831470.2764@xanadu.home>
	<20101013232604.GA13146@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1010131936090.2764@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 14 Oct 2010, Russell King - ARM Linux wrote:

> On Wed, Oct 13, 2010 at 06:51:52PM -0400, Nicolas Pitre wrote:
> > 3) All serial drivers could have migrated to a uniform device node 
> >    namespace when RMK revamped support for serial devices, with dynamic 
> >    allocation just like everything else.
> 
> Wrong.  There was no dynamic allocation, because the layer above did
> not support it.
> 
> >  Unlike for IDE disks, this 
> >    didn't happen unfortunately because some people couldn't get over a 
> >    possible device name change (I wonder how they survived the 
> >    transition to libata).
> 
> I was not, and still am firmly of the opinion that my decision was
> the right one to reject your "approach" to forcefully unifying the
> serial devices.  It was more of a hack, introducing multiple
> special cases for the old 8250-style ports to make it half sort of
> work.

I didn't say my patch was right.  But I still think that the general 
idea, which obviously needed more work, was right.  But people didn't 
even agree on the idea.

> Until the tty layer gets fixed so that it doesn't need to be told
> that there will be N tty ports attached to D tty driver at the point
> in time when D is registered with the tty subsystem, my opinion on
> this isn't going to change.

I totally agree.  But that's beside my point.  People even didn't agree 
on the idea that serial port _could_ have dynamically assigned device 
nodes.  In that context there is no point "fixing" the tty layer.  
That's orthogonal to the work you did on unifying serial support as much 
as possible which was excellent.



Nicolas

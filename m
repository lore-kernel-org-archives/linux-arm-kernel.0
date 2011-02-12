From: nico@fluxnic.net (Nicolas Pitre)
Date: Sat, 12 Feb 2011 13:50:44 -0500 (EST)
Subject: The p2v branch
In-Reply-To: <20110212184138.GD22402@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1102121304500.14920@xanadu.home>
	<20110212184138.GD22402@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1102121347120.14920@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 12 Feb 2011, Russell King - ARM Linux wrote:

> On Sat, Feb 12, 2011 at 01:32:48PM -0500, Nicolas Pitre wrote:
> > I finally was able to complete this series and test it satisfactorily.  
> > This required some hacking to the OMAP UART debugging code so it would 
> > stop fighting against me and forcefully collaborate.
> 
> It should at least build with 6651/1 in place.

Not if you do try to load the kernel somewhere else in memory to 
exercize its ability to live with a different phys offset.

> The only fight
> remaining is against the (imho misguided) attempt to select the debug
> port based on the machine ID.  I normally end up hard-coding the
> addresses.

That's what I ended up doing too, but something better and IMHO simpler 
could be done, which would also be fully position independent.


Nicolas

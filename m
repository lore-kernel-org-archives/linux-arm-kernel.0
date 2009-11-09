From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 09 Nov 2009 14:31:23 -0500 (EST)
Subject: [PATCH] Use definition for cmpxchg swi
In-Reply-To: <20091109190852.GD3808@shareable.org>
References: <20091108200459.GA32760@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0911082033580.16711@xanadu.home>
	<20091109085137.GA14453@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0911090953010.16711@xanadu.home>
	<20091109173040.GA24358@n2100.arm.linux.org.uk>
	<20091109190852.GD3808@shareable.org>
Message-ID: <alpine.LFD.2.00.0911091422310.16711@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 9 Nov 2009, Jamie Lokier wrote:

> Russell King - ARM Linux wrote:
> > I'll add a comment then.
> > 
> > Note, however, that the original code was buggy - it resulted in
> > the '0xfff0' syscall being called instead of '0xffff0' - note the
> > extra 4 bits there.
> 
> Meaning that nobody has ever actually used the original code? :-)

Hard to tell.  This is certainly the last of the last resorts.

> I notice that it loads the syscall number register for EABI
> compatibility, but that instruction could be trivially omitted with
> OABI-compatible kernels, couldn't it?

Maybe, but I don't think we should care that much.  This is only to 
support maybe one or two dev boards in existence on the planet that 
might even not be used anymore, and being the solution of last resort 
means it is already much much slower than the alternatives.  So this is 
not worth the bother.

> By the way, did you change it to LDR to make it faster?  (I.e. does
> that make it faster?)

It's most probably only a case of making the define usage simpler.


Nicolas

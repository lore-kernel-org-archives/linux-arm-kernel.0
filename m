From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 25 Feb 2010 13:30:56 -0500 (EST)
Subject: [PATCH] Clean up ARM compressed loader
In-Reply-To: <4B86483C.6000108@marcansoft.com>
References: <1266978217-7023-1-git-send-email-hector@marcansoft.com>
	<20100224223418.GB25587@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1002241824520.1946@xanadu.home>
	<20100224234215.GA21985@n2100.arm.linux.org.uk>
	<4B85BCE0.7000903@marcansoft.com>
	<20100225000114.GB21985@n2100.arm.linux.org.uk>
	<4B85C4A4.4060005@marcansoft.com>
	<alpine.LFD.2.00.1002242309030.1946@xanadu.home>
	<4B86483C.6000108@marcansoft.com>
Message-ID: <alpine.LFD.2.00.1002251322060.1946@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Feb 2010, Hector Martin wrote:

> Nicolas Pitre wrote:
> > Obviously.  But that's the core of the argument: we made sure that the 
> > previous implementation didn't use any static within functions.  Why do 
> > you need to do that?  This is usually a bad idea anyway as this makes 
> > the function non reentrant.
> 
> Static inside functions doesn't imply being non-reentrant (any more than
> using global variables does).

Usually it does, unless as you mention those are used read-only.
I think we don't have to teach each other how a C compiler works, right?

But just to make sure we're on the same page: if you need a global 
variable, or a static variable within a function, it is preferable if 
they're truly read-only by marking them const.  This has the advantage 
of not having to bother with .data relocation in RAM when booting a 
kernel directly from ROM as they get allocated to the .rodata section 
which is included in .text by default by the linker.


Nicolas

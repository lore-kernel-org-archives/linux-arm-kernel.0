From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Jul 2010 12:30:03 +0100
Subject: [PATCH] ARM: Versatile Express: Add default memory layout
In-Reply-To: <1279797596.9564.25.camel@e102109-lin.cambridge.arm.com>
References: <20100721165509.26047.70564.stgit@e102109-lin.cambridge.arm.com>
	<20100722103038.GE31293@n2100.arm.linux.org.uk>
	<1279796069.9564.2.camel@e102109-lin.cambridge.arm.com>
	<20100722105729.GK31293@n2100.arm.linux.org.uk>
	<1279797089.9564.21.camel@e102109-lin.cambridge.arm.com>
	<20100722111631.GM31293@n2100.arm.linux.org.uk>
	<1279797596.9564.25.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100722113003.GN31293@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 22, 2010 at 12:19:56PM +0100, Catalin Marinas wrote:
> On Thu, 2010-07-22 at 12:16 +0100, Russell King - ARM Linux wrote:
> > The kernel boot requirements document has for the last _8_ years said:
> > 
> >    The boot loader must pass at a minimum the size and location of the system
> >    memory, and root filesystem location. Therefore, the minimum tagged list
> >    should look:
> > 
> >            +-----------+
> >    base -> | ATAG_CORE |  |
> >            +-----------+  |
> >            | ATAG_MEM  |  | increasing address
> >            +-----------+  |
> >            | ATAG_NONE |  |
> >            +-----------+  v
> > 
> > and still u-boot gets it wrong...  Now tell me why I hate boot loaders
> > soo much.
> 
> Maybe it's time to ignore all boot loaders and do everything in the
> kernel :)

Maybe, but then we can never do things like pass command line arguments
to the kernel, or discover where system RAM is, etc.

It's also an argument for avoiding DT!  If boot loaders can't even get
the most basic of information right...

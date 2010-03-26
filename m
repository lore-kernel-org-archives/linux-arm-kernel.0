From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Mar 2010 23:00:59 +0000
Subject: RFC: ARM Boot standard for passing device tree blob
In-Reply-To: <4BACF238.3040405@firmworks.com>
References: <fa686aa41003240811l6f40c8cfs6fdad496facdc089@mail.gmail.com>
	<20100325210409.GH24984@n2100.arm.linux.org.uk>
	<1269610665.807.51.camel@e102109-lin.cambridge.arm.com>
	<4BACF238.3040405@firmworks.com>
Message-ID: <20100326230059.GB29179@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 26, 2010 at 07:43:20AM -1000, Mitch Bradley wrote:
> What is the reason for turning off the data caches?  Leaving all caches  
> turned on and coherent with one another has always worked well for me at  
> the interface from firmware to a booted program.

With the data caches on, you need the MMU to be setup and operational.
That's impractical when you're passing control between differing pieces
of software which may have different ideas about how to setup the MMU
and where to place the page tables.  If you accidentally overwrite the
page tables, things quickly become undebuggable.

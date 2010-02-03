From: dan@debian.org (Daniel Jacobowitz)
Date: Wed, 3 Feb 2010 12:44:26 -0500
Subject: 32-bit Thumb-2 breakpoints
In-Reply-To: <20100203172301.GD19037@shareable.org>
References: <20100111215816.GA1068@caradoc.them.org>
	<20100111223503.GD7925@n2100.arm.linux.org.uk>
	<20100111225436.GA7408@caradoc.them.org>
	<20100111231027.GA30714@shareable.org>
	<20100111231702.GA9485@caradoc.them.org>
	<20100203172301.GD19037@shareable.org>
Message-ID: <20100203174426.GA10898@caradoc.them.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2010 at 05:23:01PM +0000, Jamie Lokier wrote:
> Daniel Jacobowitz wrote:
> > Thankfully, both branches into IT blocks and branches
> > leaving IT blocks not at the last instruction are forbidden.
> 
> Forbidden as in throws a fault, or forbidden as in "can we use this to
> break out of GDB single-stepping to give third-parties a hard time
> tracing my secret code"?

Forbidden as in "the architecture documentation says it has
unpredictable behavior".

That's generally where I draw the line at trying to handle bad code.
In practice, I will make a wild guess that current processors fault
branches during an IT block and don't do anything fancy for branches
into an IT block, or else it messes up in some hard-to-reproduce way.

-- 
Daniel Jacobowitz
CodeSourcery

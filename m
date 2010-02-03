From: dan@debian.org (Daniel Jacobowitz)
Date: Wed, 3 Feb 2010 08:48:22 -0500
Subject: 32-bit Thumb-2 breakpoints
In-Reply-To: <20100203132824.GA27048@n2100.arm.linux.org.uk>
References: <20100203005038.GA16356@caradoc.them.org>
	<1265197942.1970.34.camel@pc1117.cambridge.arm.com>
	<20100203132824.GA27048@n2100.arm.linux.org.uk>
Message-ID: <20100203134822.GA27441@caradoc.them.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2010 at 01:28:24PM +0000, Russell King - ARM Linux wrote:
> Software breakpoints are a pain in the backside if you have threaded
> programs, because when you insert a breakpoint into one thread, it's
> active in all threads - you can't insert a breakpoint into only one
> thread.
> 
> If we have the ability to set hardware breakpoints, I'd like to see
> that used in preference to software breakpoints, and only resort to
> software breakpoints if there's no other alternative.

GDB has quite good support for this platform-independent problem,
not to mention that it's sometimes a feature.  I don't think it's a
problem.  The latest addition is displaced stepping support,
available for ARM, which is used to bypass software breakpoints
hit by an uninteresting thread without having to stop the rest
of the program.

There's a lot of reasons to avoid using hardware breakpoints; for
instance, software breakpoints are faster when installing the
breakpoint in every thread, and there's usually contention
with watchpoint resources where the hardware-ness makes a
bigger impact.

-- 
Daniel Jacobowitz
CodeSourcery

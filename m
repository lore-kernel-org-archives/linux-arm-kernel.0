From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Feb 2010 14:43:20 +0000
Subject: 32-bit Thumb-2 breakpoints
In-Reply-To: <20100203134822.GA27441@caradoc.them.org>
References: <20100203005038.GA16356@caradoc.them.org>
	<1265197942.1970.34.camel@pc1117.cambridge.arm.com>
	<20100203132824.GA27048@n2100.arm.linux.org.uk>
	<20100203134822.GA27441@caradoc.them.org>
Message-ID: <20100203144320.GH22275@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2010 at 08:48:22AM -0500, Daniel Jacobowitz wrote:
> On Wed, Feb 03, 2010 at 01:28:24PM +0000, Russell King - ARM Linux wrote:
> > Software breakpoints are a pain in the backside if you have threaded
> > programs, because when you insert a breakpoint into one thread, it's
> > active in all threads - you can't insert a breakpoint into only one
> > thread.
> > 
> > If we have the ability to set hardware breakpoints, I'd like to see
> > that used in preference to software breakpoints, and only resort to
> > software breakpoints if there's no other alternative.
> 
> GDB has quite good support for this platform-independent problem,
> not to mention that it's sometimes a feature.  I don't think it's a
> problem.  The latest addition is displaced stepping support,
> available for ARM, which is used to bypass software breakpoints
> hit by an uninteresting thread without having to stop the rest
> of the program.

You should be aware that there has been a move to rid the kernel of
software-based breakpointing implementations through 'utrace' which
I've been more or less ignoring because of that (because it means
that we lose the ability to set any breakpoints.)

Just to be clear, I'm not objecting to your patch (which I think is
fine) - I'm just trying to make sure that the same ground isn't being
covered in multiple ways by different people.

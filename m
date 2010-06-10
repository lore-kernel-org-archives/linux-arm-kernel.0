From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 Jun 2010 15:20:15 +0100
Subject: Context Switching is Broken
In-Reply-To: <004801cb08a7$913a9f90$b3afdeb0$@deacon@arm.com>
References: <503171.97993.qm@web51806.mail.re2.yahoo.com>
	<20100610140136.GA32362@n2100.arm.linux.org.uk>
	<004801cb08a7$913a9f90$b3afdeb0$@deacon@arm.com>
Message-ID: <20100610142015.GC32362@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 10, 2010 at 03:16:49PM +0100, Will Deacon wrote:
> > On Thu, Jun 10, 2010 at 04:11:35AM -0700, Herman Swartz wrote:
> > > Context switching is broken. The man page for context is example code
> > > that doesn't work, but should. Does a bug report need to be submitted?
> > 
> > $ man context
> > No manual entry for context
> > 
> > ?
> > 
> 
> Quite. man makecontext has a fairly scary example, maybe that's it.

In which case it's a question for libc people - the kernel has nothing
to do with makecontext, getcontext, setcontext and swapcontext.

I believe for glibc, these are simply unimplemented on ARM, and linking
a program which uses makecontext with glibc would result in the linker
issuing:

warning: makecontext is not implemented and will always fail

Same for the other three functions.

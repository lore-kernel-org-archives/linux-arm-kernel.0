From: horms@verge.net.au (Simon Horman)
Date: Thu, 22 Jul 2010 18:14:12 +0900
Subject: ARM Machine SoC I/O setup and PAD initialization code
In-Reply-To: <20100722084649.GK6802@n2100.arm.linux.org.uk>
References: <201007211029.29529.david.jander@protonic.nl>
	<20100721084726.GC6009@n2100.arm.linux.org.uk>
	<20100722023250.GC27663@verge.net.au>
	<20100722072034.GA6802@n2100.arm.linux.org.uk>
	<20100722072948.GA7101@verge.net.au>
	<20100722084649.GK6802@n2100.arm.linux.org.uk>
Message-ID: <20100722091409.GA15757@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 22, 2010 at 09:46:49AM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 22, 2010 at 04:29:48PM +0900, Simon Horman wrote:
> > On Thu, Jul 22, 2010 at 08:20:34AM +0100, Russell King - ARM Linux wrote:
> > > On Thu, Jul 22, 2010 at 11:32:53AM +0900, Simon Horman wrote:
> > > > Would it be feasible to  use Linux + kexec as the boot loader as
> > > > a long term solution to fixing boot loaders by eliminating them?
> > > 
> > > So what you're proposing is that a broken boot loader should boot a
> > > version of Linux to fix the pin MUX, which then kexecs a kernel which
> > > doesn't have that code?
> > > 
> > > What's the point of that - when the first kernel will be able to run
> > > the system?
> > 
> > Ok, point taken, its impossible to remove the boot loaders.

For the record, what I was proposing was removing the broken boot loader
and replacing it with something that isn't broken. And I was wondering
if that is feasible or not. But as you point out (elsewhere) that
may not be relevant to the original question.

> No, my point was that if you're going to put pin mux code into the
> kernel, there's no point building the pin mux code out of the kernel
> which you're going to use to run your device.
> 
> So, what we tend to do as a general rule on ARM is to put the pin mux
> code into the kernel so that we're less reliant on any boot loader to
> get it right.  And as I've already said, we have some cases where we
> need to change the pin muxing at runtime, and at least one case where
> it needs to be changed by the device driver operating on the pins.

Ok, so the boot-loader is irrelevant to the pin mux code in the kernel?

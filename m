From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Apr 2011 16:50:14 +0100
Subject: Status of arch/arm in linux-next
In-Reply-To: <BANLkTikr-J0HSW74dPvGfuJe6GdCBs151w@mail.gmail.com>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
	<BANLkTikr-J0HSW74dPvGfuJe6GdCBs151w@mail.gmail.com>
Message-ID: <20110415155014.GN1611@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2011 at 04:30:50PM +0200, Martin Guy wrote:
> On 14 April 2011 11:44, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > This morning, I looked at linux-next to find out how arch/arm is doing
> > for the next merge window.
> >
> > $ git diff -C --cumulative v2.6.39-rc1... arch
> > ?19.7% arch/arm/mach-imx/
> > ?19.2% arch/arm/mach-mx3/
> > ? 3.4% arch/arm/mach-mxc91231/
> > ?18.1% arch/arm/mach-ux500/
> > ?74.1% arch/arm/
> > ? 3.2% arch/m68k/
> > ? 4.0% arch/mips/lantiq/
> > ? 6.9% arch/mips/
> > ? 3.1% arch/x86/kvm/
> > ? 7.6% arch/x86/
> > ?100.0% arch/
> 
> One reason for high ARM activity is that the arm port has far more
> different supported computers and drivers for more different hardware
> than any other processor, so more activity in the arm tree than any
> other is unlikely to go away unless we stop developing for ARM
> platforms.

No, if you read Linus' complaints, this argument doesn't apply.  Why?
Because we should have invented some way to sort this stuff out so that
we had data structures passed into the kernel - or a pre-kernel shim -
which sorted out stuff for the kernel.  You'll notice that Linus said
that using ACPI would be better than what we're currently doing with
platform support.

While I don't agree completely with that, as there's platform specific
functions which can't be handled using that method (unless we start
passing bytecode and have an interpreter in the kernel) Linus has a
point when we end up with massive chunks of platform specific data in
the kernel.

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Dec 2010 10:32:07 +0000
Subject: [PATCH 22/22] ARM: SMP: remove smp_mpidr.h
In-Reply-To: <7ba9887da1b3a9057e833c1fae3458e7@mail.gmail.com>
References: <20101203200746.GA10245@n2100.arm.linux.org.uk>
	<E1POcD1-0007sP-Rs@rmk-PC.arm.linux.org.uk>
	<7ba9887da1b3a9057e833c1fae3458e7@mail.gmail.com>
Message-ID: <20101206103207.GF29563@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 06, 2010 at 03:02:09PM +0530, Santosh Shilimkar wrote:
> Russell,
> > -----Original Message-----
> > From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> > kernel-bounces at lists.infradead.org] On Behalf Of Russell King - ARM
> Linux
> > Sent: Saturday, December 04, 2010 1:56 AM
> > To: linux-arm-kernel at lists.infradead.org; Catalin Marinas
> > Subject: [PATCH 22/22] ARM: SMP: remove smp_mpidr.h
> >
> > With "ARM: CPU hotplug: remove bug checks in platform_cpu_die()", we
> > now do not use hard_smp_processor_id(), we no longer need to read the
> > hardware processor ID.  Remove the include providing this function.
> >
> hard_smp_processor_id() is also useful when wakeup from low power
> modes and wants to run specific restore code on specific
> CPUs. Ofcourse platform have it's own custome macro, but having
> ARM generic is better.

Maybe, but there's no code in the kernel making use of it.  Also note
that there is a tendency to compare the kernel's CPU numbers (which are
the logical numbers) with hard_smp_processor_id() (the physical number)
which may not always be the same thing.

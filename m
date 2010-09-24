From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Sep 2010 08:40:08 +0100
Subject: Could it be a case of deadlock on SMP?
In-Reply-To: <AANLkTi=j5A1=VvE9nz5yGEuOt45-ie98S_SwuD9zXSuk@mail.gmail.com>
References: <AANLkTinNq6WVNT543QcG+1eVB9te1mmypD4pEvpFhqoJ@mail.gmail.com>
	<20100920185927.GC5177@n2100.arm.linux.org.uk>
	<AANLkTi=j5A1=VvE9nz5yGEuOt45-ie98S_SwuD9zXSuk@mail.gmail.com>
Message-ID: <20100924074007.GA11371@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 24, 2010 at 01:17:41PM +0800, Andrew Yan-Pai Chen wrote:
> On Tue, Sep 21, 2010 at 2:59 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Sep 21, 2010 at 02:46:57AM +0800, Andrew Yan-Pai Chen wrote:
> >> We try to verify our dual-core processor (non v7) by LTP tests.
> >
> > Is this a non-ARM SMP implementation then?
> >
> > If this is an ARM SMP implementation, then please provide the
> > CPU model, revision and variant information.
> >
> The CPU we use is still under developing.
> It is a ARM SMP implementation which uses v5te ISA by Faraday Tech.

So it's not the ARM SMP implementation if it's v5te ISA, as it won't
have the load/store exclusive operations necessary for performing
locking safely.

As the ARM SMP implementation works, and the code you're modifying is
common to all SMP implementations, I'd say you have a bug in the CPU
hardware or your implementation, rather than the kernel.

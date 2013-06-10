From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 10 Jun 2013 17:27:29 +0200
Subject: [PATCH 01/06] ARM: shmobile: Introduce SHMOBILE_FIXUP() helper
In-Reply-To: <CANqRtoSKAm_9VXus=zzer2ELrS2NmZ=znZCSJH65imTXGk5ong@mail.gmail.com>
References: <20130605073410.15758.37563.sendpatchset@w520>
 <201306061917.52550.arnd@arndb.de>
 <CANqRtoSKAm_9VXus=zzer2ELrS2NmZ=znZCSJH65imTXGk5ong@mail.gmail.com>
Message-ID: <201306101727.29876.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 June 2013, Magnus Damm wrote:
> On Fri, Jun 7, 2013 at 2:17 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday 06 June 2013, Magnus Damm wrote:
> 
> My approach with this series was more to make sure all boards keep on
> working regardless what their boot loader pass. This since I too do
> not trust the boot loader - especially on older boards. Perhaps the
> more acceptable approach is to pretend to start trusting the
> information by the boot loader and deal with the fallout if that
> happens. Things may break when removing CONFIG_MEMORY_START/SIZE since
> the MEM_SIZE and PHYS_OFFSET change in arch/arm/kernel/atags_parse.c
> 
> Anyway I can update my romImage series so it uses appended DTB with
> both AP4EVB and Mackerel. Then this series can simply be thrown away.

That sounds like a good idea, but it seems that AP4EVB does not
yet use DT_MACHINE_START, so I suspect you will need more work.

> > The easiest way is probably to declare that multiplatform booting
> > on shmobile is only supported for DT-enabled boards and that support
> > for non-DT booting will be removed at the same time as
> > non-multiplatform booting on shmobile. This is the same thing we are
> > doing e.g. on Exynos and the various Marvell embedded (non-PXA/MMP)
> > chips.  The time line for this not set yet, and I think that will
> > be one of the hot topics at this year's ARM subarch maintainer summit
> > that I hope we will have the chance to do during the kernel summit.
> > FWIW, my take on this is that at some point we will require both DT
> > and multiplatform for all ARMv6 and ARMv7 platforms anyway (not
> > for the older ones, in particular StrongARM and XScale), but we have
> > to come up with a timing that works for everyone.
> 
> Yeah, I agree with your idea but I wonder about the timing. Actually,
> I was thinking that the prime candidate boards for multiplatform are
> our DT -reference boards. Still blocked on common clock framework
> though... I will try to sort out the memory bits first.

Ok.

	Arnd

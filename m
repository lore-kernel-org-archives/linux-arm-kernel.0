From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 3 Jul 2013 16:51:04 +0200
Subject: Proposal: mach-dt
In-Reply-To: <51D437C6.9000909@arm.com>
References: <1372839486.487159774@f54.mail.ru>
 <51D43127.6080206@codeaurora.org> <51D437C6.9000909@arm.com>
Message-ID: <201307031651.05181.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 July 2013, Marc Zyngier wrote:
> On 03/07/13 15:11, Christopher Covington wrote:
> > On 07/03/2013 10:10 AM, Marc Zyngier wrote:
> >> On 03/07/13 15:03, Christopher Covington wrote:
> >>> On 07/03/2013 05:20 AM, Marc Zyngier wrote:
> >>>> On 03/07/13 09:18, Alexander Shiyan wrote:
> >>>>
> >>>> Hi Alexander,
> >>>>
> >>>>> More and more platforms are now using devicetree.
> >>>>> Ideally the platform code contains only one function "of_platform_populate".
> >>>>> My idea is to make a generic architecture (mach-dt) with the call then add support
> >>>>> for compatible subarchitectures as they become available in "compatible"-property.
> >>>>> Your opinion?
> >>>>
> >>>> Well, my (admittedly partial) opinion is that mach-virt is an incredibly
> >>>> nicer sounding name, 'specially as you can mistype it as mach-triv.
> >>>
> >>> As mentioned before, I disagree and would love to see the the
> >>> virtualization-specific name replaced by something more suitably generic.
> >>
> >> I think you're missing the point. The right fix would to remove it
> >> entirely and make it the basic default. There are patches for that already.
> > 
> > Where?
> 
> There were patches from Arnd (CC-ed) a while ago, moving some of the
> mach-virt SMP stuff to smp.c. Don't have the pointers handy, but surely
> Arnd knows where they are.
> 
> Once SMP is done, the rest should be pretty trivial.

In 3.11, mach-virt is basically empty. The SMP functions were moved out
already and everything is optional, so you should not need to even build
arch/arm/mach-virt/virt.c any more, except to get a particular platform
name in /proc/cpuinfo.

We have a couple of real (as opposed to virtual) platforms that are
almost at the same point and only have one or two functions left in them.

I'm definitely open for suggestions what to do about them. Putting all
the trivial files into a shared directory would be one possibility,
as would removing the files entirely by making the code more generic.

Note that arm64 platforms by definition have no such machine specific
code, and they should be able to boot a 32 bit kernel as well without
needing it.

	Arnd

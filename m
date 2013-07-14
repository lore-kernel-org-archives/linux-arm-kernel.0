From: will.deacon@arm.com (Will Deacon)
Date: Sun, 14 Jul 2013 22:53:25 +0100
Subject: v3.10 - big endian core support
In-Reply-To: <51DFEF75.8080600@codethink.co.uk>
References: <CALicx6u89THSiRa4FzGZrcoG8q+o_BD8qVEC4CYXEjPUVK_fJw@mail.gmail.com>
 <20130712134726.0a909165@skate> <51DFEF75.8080600@codethink.co.uk>
Message-ID: <20130714215325.GB7382@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 12, 2013 at 12:58:45PM +0100, Ben Dooks wrote:
> On 12/07/13 12:47, Thomas Petazzoni wrote:
> > Dear Vijay Kilari,
> >
> > On Fri, 12 Jul 2013 17:09:12 +0530, Vijay Kilari wrote:
> >
> >>> Ben Dooks has a separate branch on top of this base branch for
> >>> big-endian support, that adds atags compat code to convert the ATAGs
> >>> data from LE to BE. See the baserock/311/be/atags branch in
> >>> git://git.baserock.org/delta/linux. Or
> >>> http://git.baserock.org/cgi-bin/cgit.cgi/delta/linux.git/log/?h=baserock/311/be/atags.
> >>
> >>   ARM VE TC2 board, enabling CONFIG_THUMB2_KERNEL failed to boot in BE mode
> >> It hangs at very early stage of boot
> >
> > Yeah, the Thumb2 code is not supported by Ben Dooks patches, it's part
> > of the TODO-list. I think Ben said he would probably not have much time
> > to work on this. I might be able to spare some time on this, so just
> > let me know if I should start working on this. If I remember correctly,
> > it's mainly the fixup_pv_table code that needed some Thumb2/BE love.
> >
> > Will, is getting Thumb2 working a requirement to get the BE support
> > merged, or can we for now make the BE option depends on !THUMB2_KERNEL ?
> 
> I would like to sort out getting this code merged as it seems to have
> been tested by several people now outside Codethink.
> 
> I could try doing the THUMB2 support, but I do not have a lot of
> experience with building THUMB2 kernels.

I think we should try and get Thumb-2 supported before merging this as there
isn't any real reason why the instruction set should cause endianness
issues. We're also only almost at -rc1, so there's still time to fix this
properly for 3.12 instead of adding a fake Kconfig dependency.

As for building a Thumb-2 kernel; just enable the option in menuconfig and
you're done. The compiler should "do the right thing".

Will

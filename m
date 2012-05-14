From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 May 2012 21:07:51 +0000
Subject: [PATCH 03/03] ARM: Undelete KZM9D mach-type
In-Reply-To: <CANqRtoTYWGhto7Zf=C=WHrT5fjc1p=6GE0cnozYLUuqbz=+LhA@mail.gmail.com>
References: <20120514105424.8596.38355.sendpatchset@w520>
 <20120514123034.GD10453@n2100.arm.linux.org.uk>
 <CANqRtoTYWGhto7Zf=C=WHrT5fjc1p=6GE0cnozYLUuqbz=+LhA@mail.gmail.com>
Message-ID: <201205142107.51335.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 May 2012, Magnus Damm wrote:
> On Mon, May 14, 2012 at 9:30 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, May 14, 2012 at 07:54:51PM +0900, Magnus Damm wrote:
> >> From: Magnus Damm <damm@opensource.se>
> >>
> >> Undelete the KZM9D mach-type to allow build of board
> >> for EMEV2 SoC support.
> >
> > If you've converted to use DT for KZM9D, do you still need this?
> 
> Good question. I guess it depends on how we want to make use of DT on
> that piece of hardware. I do intend to convert the KZM9D board (not to
> be mistaken for KZM9G!) to DT (and drop the generic EMEV2 SoC DT
> unless someone really wants it at this timing), but I'm still not sure
> if the SMP code in V2 is the way we want to do it. I suspect that
> there is no way to support SMP without static entity mappings, so
> perhaps I should rework that part and redo a V3? Or perhaps I should
> interpret the EMEV2 silence as a good thing. =)

I don't understand why you want to have a KZM9D board file at all,
since it from looking at it, I can find nothing that is truely
board specific and doesn't already have bindings. This is different
from the other boards that you just converted to DT_MACHINE_START
but still left using individual board files because some bindings
are missing.

The only board specific device you add for KZM9D is smsc911x, and
that has bindings, all the other devices can just be hardcoded
for the soc because they are always the same, until we have bindings
for all of them. Am I missing something?

> Unfortunately the KZM9D board only takes uImages, but good news is
> that it actually feeds us the correct mach-type. This seems to be a
> pretty common thing around here these days. I'm trying to get people
> to actually store the DTB in the boot loader and pass it along, but
> that seems rather far away at this point.

The preferred way would be to store the dtb on the same medium that
contains the kernel, so you can update them together if necessary,
even though we try to keep dtb files compatible across kernel versions.
I would not want to rely on a hardcoded dtb file in the boot loader.

	Arnd

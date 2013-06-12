From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 12 Jun 2013 08:22:18 +0200 (CEST)
Subject: [PATCH v2] ARM: shmobile: uImage load address rework
In-Reply-To: <CANqRtoQJMtRsJp43cEYF7GvS_DiJUwu3nDppKCqObYPsQHY-EA@mail.gmail.com>
References: <20130610092857.19175.25629.sendpatchset@w520>
 <Pine.LNX.4.64.1306111552480.9621@axis700.grange>
 <CANqRtoQJMtRsJp43cEYF7GvS_DiJUwu3nDppKCqObYPsQHY-EA@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.1306120820280.23454@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Jun 2013, Magnus Damm wrote:

> Hi Guennadi,
> 
> On Tue, Jun 11, 2013 at 10:54 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > Hi Magnus
> >
> > On Mon, 10 Jun 2013, Magnus Damm wrote:
> >
> >> From: Magnus Damm <damm@opensource.se>
> >>
> >> This is V2 of the mach-shmobile uImage load address rework patch.
> >>
> >> Rework the mach-shmobile uImage load address calculation by storing
> >> the per-board load addresses in Makefile.boot. This removes the
> >> CONFIG_MEMORY_START dependency from Makefile.boot, and it also makes
> >> it possible to create safe kernel images that boot on multiple boards.
> >>
> >> This is one of several series of code that reworks code not to rely on
> >> CONFIG_MEMORY_START/SIZE which in turn is needed for ARCH_MULTIPLATFORM.
> >>
> >> Signed-off-by: Magnus Damm <damm@opensource.se>
> >> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >> Reviewed-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >> ---
> >
> > This patch seems to break compilation when none of CONFIG_MACH_* is set,
> > e.g. when trying to build a generic SoC kernel with only DT-based board
> > support, or am I missing something?
> 
> Thanks for your feedback. I believe the current code already covers
> the in-tree REFERENCE DT boards. Perhaps there is some board missing?
> 
> If you want to build an uImage for a certain DT board then perhaps you
> can add it to the list with an incremental patch?
> 
> Or even better, use zImage instead of uImage, then we can have a
> single binary for all boards.
> 
> So if you build the kernel for no board at all, either set the
> LOADADDR variable as the help text says, or simply do not build for
> uImage.
> 
> Makes sense?

Ok, understand, thanks.

Regards
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

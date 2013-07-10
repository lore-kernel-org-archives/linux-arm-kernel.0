From: horms@verge.net.au (Simon Horman)
Date: Wed, 10 Jul 2013 10:23:10 +0900
Subject: [PATCH 01/02] ARM: shmobile: Introduce r8a7790_read_mode_pins()
In-Reply-To: <CANqRtoTvSGvNWwBQ9XD43CtdJNJCebzC2xtXUQcFSXxATkuNpQ@mail.gmail.com>
References: <20130709125007.4388.15701.sendpatchset@w520>
 <20130709125016.4388.47414.sendpatchset@w520>
 <51DC08A5.2080705@cogentembedded.com>
 <CANqRtoTvSGvNWwBQ9XD43CtdJNJCebzC2xtXUQcFSXxATkuNpQ@mail.gmail.com>
Message-ID: <20130710012309.GS32603@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 09, 2013 at 10:05:15PM +0900, Magnus Damm wrote:
> Hi Sergei,
> 
> On Tue, Jul 9, 2013 at 9:57 PM, Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> wrote:
> > Hello.
> >
> >
> > On 09-07-2013 16:50, Magnus Damm wrote:
> >
> >> From: Magnus Damm <damm@opensource.se>
> >
> >
> >> Break out the r8a7790 boot mode code into a separate
> >> function so it can be shared by multiple users.
> >
> >
> >> Signed-off-by: Magnus Damm <damm@opensource.se>
> >> ---
> >
> >
> > [...]
> >
> >
> >> --- 0001/arch/arm/mach-shmobile/setup-r8a7790.c
> >> +++ work/arch/arm/mach-shmobile/setup-r8a7790.c 2013-07-09
> >> 19:59:37.000000000 +0900
> >> @@ -201,6 +201,20 @@ void __init r8a7790_add_standard_devices
> >>         r8a7790_register_thermal();
> >>   }
> >>
> >> +#define MODEMR 0xe6160060
> >> +
> >> +u32 __init r8a7790_read_mode_pins(void)
> >> +{
> >> +       void __iomem *modemr = ioremap_nocache(MODEMR, PAGE_SIZE);
> >
> >
> >    Why ioremap the whole page if you only need 4 bytes, and the address is
> > not aligned to page?
> 
> Because the original code did so. =)
> 
> But yes, indeed, using two pages seems kind of pointless.

Lets fix that up in another patch, it seems orthogonal to this change.

From: tony@atomide.com (Tony Lindgren)
Date: Thu, 8 Nov 2018 07:54:59 -0800
Subject: mainline/master boot bisection: v4.19-12838-g71e56028173b on
 beagle-xm
In-Reply-To: <CAOesGMgAxvERhQjnyZ7P4vqhhWdBdA20XrFnDn48Na5wrEAkEA@mail.gmail.com>
References: <5bdebe88.1c69fb81.3857a.05d1@mx.google.com>
 <a4d3b4ea-fcc5-f65b-70e2-bd12f089d0e6@collabora.com>
 <CAOesGMgcuGKgNiN44jOS_9qRo3es8W6kt5-o676ouwpcAZC6KQ@mail.gmail.com>
 <0ca97dae-86ee-8b75-52be-09cdaea3999f@collabora.com>
 <4b7922f2-6428-3011-0338-9c0662712b8a@collabora.com>
 <CAOesGMgAxvERhQjnyZ7P4vqhhWdBdA20XrFnDn48Na5wrEAkEA@mail.gmail.com>
Message-ID: <20181108155459.GJ56134@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Olof Johansson <olof@lixom.net> [181107 16:17]:
> On Wed, Nov 7, 2018 at 8:09 AM Guillaume Tucker
> <guillaume.tucker@collabora.com> wrote:
> >
> > On 06/11/2018 10:54, Guillaume Tucker wrote:
> > > On 05/11/2018 14:33, Olof Johansson wrote:
> > >> On Mon, Nov 5, 2018 at 1:43 AM Guillaume Tucker
> > >> <guillaume.tucker@collabora.com> wrote:
> > >>>
> > >>> Hi Linus,
> > >>>
> > >>> Please see below, the kernelci.org automated boot bisection found
> > >>> that the OMAP3 BeagleBoard-xM is failing to boot with SMP
> > >>> disabled and PREEMPT enabled in multi_v7_defconfig.  There is no
> > >>> log output after the bootloader so the kernel seems to be
> > >>> crashing very early on.
> > >>
> > >> Can you enable DEBUG_LL to capture what goes wrong?
> > >
> > > Yes I've scheduled a re-run of the automated bisection with
> > > DEBUG_LL turned on, but the beagle-xm board is currently offline
> > > in lab-baylibre.  I'll keep you posted when I get some results.
> >
> > Unfortunately, enabling the DEBUG_LL config didn't help.  There's
> > still no visible kernel log at all from the failing LAVA jobs:
> >
> >     http://lava.baylibre.com:10080/scheduler/alljobs?length=25&search=lava-bisect-9638#table
> >
> >
> > This might be a hard one to debug without physical access to the
> > board, but please let me know if you think there's anything else
> > I can try.  For example, if there's a known older kernel revision
> > where the combination of SMP=n and PREEMPT=y worked then I could
> > try to run an automated boot bisection based on that.
> 
> Is this only beagle-xm, or do we see it on all OMAP3 hardware?

Seems to not happen on three other omap3 boards I've tried with.

Regards,

Tony

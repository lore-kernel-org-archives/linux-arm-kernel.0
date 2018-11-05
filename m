From: zhlcindy@gmail.com (Li Zhang)
Date: Mon, 5 Nov 2018 15:19:50 +0800
Subject: kvm-unit-tests gicv2 cases fail
In-Reply-To: <86a7mt2ix9.wl-marc.zyngier@arm.com>
References: <CAD8of+q29DrQa4Ay6karXC19vXzX++2T8FR-V1SAjGuO0ejYhQ@mail.gmail.com>
 <20181101101048.GJ12057@e113682-lin.lund.arm.com>
 <86a7mt2ix9.wl-marc.zyngier@arm.com>
Message-ID: <CAD8of+qMPs=miB6O_wyS6E8cyO3PjubDUmLV0p6Oikb9g15s1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 1, 2018 at 6:25 PM Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> [Thanks Christoffer for cc'ing me]
>
> On Thu, 01 Nov 2018 10:10:48 +0000,
> Christoffer Dall <christoffer.dall@arm.com> wrote:
> >
> > On Thu, Oct 18, 2018 at 05:17:57PM +0800, Li Zhang wrote:
> > > Hi,
> > >
> > > I run kvm-units-test on ARM server(QDF2400), but gicv2-ipi,
> > > gicv2-active cases fail.
> >
> > I didn't think QDF2400 has GICv2 on GICv3 support?
> >
> > Do the test cases fail or are they reported as skipped?
> >
> > > By debuging kvm-unit-tests source code, I found that interrupt is not
> > > handled. do_handle_exception is not called.
> > >
> > > By looking into KVM source code, it has GICv2 emulation on GICv3 support.
> > > I've tried a lot of kernel versions, from v4.12~v4.19 in mainline,
> > > these cases always fail.
> > > Is it possible that hardware/software disables this?
>
> Most implementations do not have the v2 compatibility interface, and
> nobody really needs it. This is a convenient way to run older VMs that
> do not know about GICv3 (32bit VMs, for example), but that's in no way
> a common setup.

I see, thanks for your explanation.

>
> > >
> > > It seems that GICv2 is a little old for ARM server, I am confused when
> > > we can use it.
> > > Do we need to care about these cases?
> > >
> >
> > I don't think you need to care.  I believe Marc has run the
> > GICv2-on-GICv3 tests on his supported platforms with recent
> > kvm-unit-tests and other have reported succes as well.
>
> Here you go (on my Chromebook running 4.18):
>
> PASS gicv2-ipi (3 tests)
> PASS gicv2-mmio (17 tests)
> PASS gicv2-mmio-up (17 tests)
> PASS gicv2-mmio-3p (17 tests)
> PASS gicv3-ipi (3 tests)
> PASS gicv2-active (1 tests)
> PASS gicv3-active (1 tests)
>
> Thanks,
>
>         M.
>
> --
> Jazz is not dead, it just smell funny.



-- 

Best Regards
-Li

From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 20 Dec 2013 22:53:13 +0100
Subject: [PATCH 1/2] ARM: EXYNOS: Support Suspend-to-RAM on EXYNOS5420
In-Reply-To: <CAOesGMi7cGZyHLBMpc7UTBbQkiRBij6rDyuA+E+9tUmsb131zw@mail.gmail.com>
References: <1387195271-3613-1-git-send-email-a.kesavan@samsung.com>
 <346894265.CPBN0v9Elj@flatron>
 <CAOesGMi7cGZyHLBMpc7UTBbQkiRBij6rDyuA+E+9tUmsb131zw@mail.gmail.com>
Message-ID: <4034332.29qpdhiElM@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 of December 2013 13:37:36 Olof Johansson wrote:
> On Fri, Dec 20, 2013 at 1:19 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> > Hi,
> >
> > On Friday 20 of December 2013 15:56:38 sunil joshi wrote:
> >> Hi Abhilash,
> >> I saw another patch in chrome tree ..by Andrew Bresticker
> >> which may be relevant here ..
> >>
> >> Just wondering if you missed adding this ? or this is not needed ?
> >> You did not face any issue in getting core to suspend ?
> >>
> >> ------------------------------------------------------------------------------------------
> >> commit 95402d816b9f1a05ce633f7ff64b4c939c142482
> >> Author: Andrew Bresticker <abrestic@chromium.org>
> >> Date:   Mon Jul 15 13:14:36 2013 -0700
> >>
> >>     arm: exynos: disable all interrupts on Exynos5420 before suspend
> >>
> >>     Disable all interrupts from the GIC before entering suspend on
> >>     Exynos5420 as is done on Exynos5250.  If interrupts are enabled, we
> >>     may receive an interrupt after entering WFI but before the PMU has
> >>     suspended the system, causing suspend to fail.
> >>
> >>     BUG=chrome-os-partner:20523
> >>     TEST=Run suspend_stress_test on Pit and observe that entering suspend
> >>     no longer occasionally fails with the "Failed to suspend the system"
> >>     error in exynos_cpu_suspend().
> >
> > A question about this for Chromium and LSI guys:
> >
> > If you find out that there is already a pending interrupt before you enter
> > the sleep mode, isn't it more reasonable to cancel the process ASAP and
> > handle the event instead of entering the sleep just to leave it?
> >
> > I believe this should be both more efficient with respect to power usage
> > and latency, because sleep-wakeup transition takes time and power.
> >
> > Do you have any reason to think the opposite?
> 
> If it's expected to be a rare or very rare event, it's not a given
> that the added complexity of dealing with the aborted suspend that
> late is worth it.

I think that the code to support this is already in place, just printing
an unfortunate message about "suspend failures". It doesn't add any
significant complexity too.

I'm not sure about the frequency of such events, though, and any real
effect of this or the other behavior in such case and so there is my
question about this.

Best regards,
Tomasz

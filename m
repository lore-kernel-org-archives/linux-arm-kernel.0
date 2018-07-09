From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Mon, 9 Jul 2018 23:46:20 +0200
Subject: [PATCH 1/2] Revert "tick: Prefer a lower rating device only if
 it's CPU local device"
In-Reply-To: <CAOi56cWaeh+c9+OgpxdjTarnRdaKrNFC=ddBPT2j9v1rHT8EOg@mail.gmail.com>
References: <1531151136-18297-1-git-send-email-sudeep.holla@arm.com>
 <CAOi56cWaeh+c9+OgpxdjTarnRdaKrNFC=ddBPT2j9v1rHT8EOg@mail.gmail.com>
Message-ID: <CAFBinCA6gZ9fw0yGvs_FWuGoZG-d2CL2R5qYp3_u1T=Atn8tgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 9, 2018 at 8:24 PM Kevin Hilman <khilman@baylibre.com> wrote:
>
> On Mon, Jul 9, 2018 at 8:45 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > This reverts commit 1332a90558013ae4242e3dd7934bdcdeafb06c0d.
> >
> > The original issue was not because of incorrect checking of cpumask for
> > both new and old tick device. It was incorrectly analysed was due to the
> > misunderstanding of the comment and misinterpretation of the return
> > value from tick_check_preferred. The main issue is with the clockevent
> > driver that sets the cpumask to cpu_all_mask instead of cpu_possible_mask.
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> And verified to fix a regression on the 32-bit ARM platform mesion8b-odroidc1.
I also tested it on Meson8b as well as Meson8m2


Regards
Martin

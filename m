From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Tue, 4 Jun 2013 10:29:38 +0200
Subject: [PATCH 01/10] clocksource: dw_apb_timer_of: use the clocksource
 as sched clock if necessary
In-Reply-To: <CACRpkdYAvUQ+aymJm1Fw1bE1aGdO7RUqLR9byvoT7ECTk4tkpw@mail.gmail.com>
References: <201306030055.15413.heiko@sntech.de>
 <201306030056.03522.heiko@sntech.de>
 <CACRpkdYAvUQ+aymJm1Fw1bE1aGdO7RUqLR9byvoT7ECTk4tkpw@mail.gmail.com>
Message-ID: <201306041029.39053.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 4. Juni 2013, 08:34:44 schrieb Linus Walleij:
> On Mon, Jun 3, 2013 at 12:56 AM, Heiko St?bner <heiko@sntech.de> wrote:
> > Currently the dw_apb_timer always expects a separate special timer to be
> > availbable for the sched_clock. Some devices using dw_apb_timers do not
> > have the sptimer but can use the clocksource as sched_clock.
> > Therefore this patch adds using the clocksource timer as
> > a fallback if no usable sched timer is found.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> 
> Is this really what the patch does? I mean "ass the clocksourse as
> fallback", it seems more like that is controlled from the device tree,
> this looks more like some more careful handling of the device tree
> input making the sched_timer optional, it doesn't really "add"
> anything, does it?

Right, the commit message is probably based a bit to much on the before-state 
of the driver, always expecting the "sptimer" and panicing if not found.

How about:

Currently the dw_apb_timer always expects a separate special timer to be
availbable for the sched_clock. Some devices using dw_apb_timers do not
have this sptimer but can use the clocksource as sched_clock instead.

Therefore enable the driver to distiguish between devices with and without
sptimer based on the devicetree data and select the correct timer as
sched_clock.

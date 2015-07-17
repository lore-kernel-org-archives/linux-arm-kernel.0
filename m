From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 17 Jul 2015 07:28:19 +0200 (CEST)
Subject: [PATCH 14/41] clocksource: mxs: Migrate to new 'set-state'
 interface
In-Reply-To: <5505013f2020eef13aa55f7d748f79e344ce6c69.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
 <5505013f2020eef13aa55f7d748f79e344ce6c69.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <1002917180.81547.1437110899188.JavaMail.open-xchange@oxbsltgw05.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

[add Fabio, Marek and Pengutronix to CC]

> Viresh Kumar <viresh.kumar@linaro.org> hat am 18. Juni 2015 um 12:54
> geschrieben:
>
>
> Migrate mxs driver to the new 'set-state' interface provided by
> clockevents core, the earlier 'set-mode' interface is marked obsolete
> now.
>
> This also enables us to implement callbacks for new states of clockevent
> devices, for example: ONESHOT_STOPPED.
>
> Also drop:
> - 'mxs_clockevent_mode': as we have helpers available from core for the
> same.
> same state twice and so perhaps the check wasn't required.
> - 'clock_event_mode_label': CLOCK_EVT_MODE_* shouldn't be used anymore
> by drivers and it was used just to print old-state:new-state. The
> debug prints are called from mxs_irq_clear() now based on the
> state-name passed to it. The printed name will be same for shutdown
> and resume states as they use the same callback pointer.
>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> ---
> @Shawn: Please let me know if you want to print "resume" for resume
> state, as that will require a separate callback for resume state, just
> to print the name correctly. I thought it might not be worth enough :)
> ---

sorry for the late feedback. I've tested the patch with an i.MX23 and an i.MX28
board without any problems.

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

Regards
Stefan

From: stano@meduna.org (Stanislav Meduna)
Date: Tue, 06 Nov 2012 09:34:39 +0100
Subject: scheduler clock for MXS
In-Reply-To: <20121105222859.GI28327@n2100.arm.linux.org.uk>
References: <50919AFF.3060602@meduna.org> <5093D8DE.70505@meduna.org>
 <20121105025753.GA26528@S2100-06.ap.freescale.net>
 <50978370.9060001@meduna.org>
 <20121105134655.GB27260@S2100-06.ap.freescale.net>
 <5097E4A9.3090008@meduna.org> <20121105222859.GI28327@n2100.arm.linux.org.uk>
Message-ID: <5098CB9F.9030401@meduna.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.11.2012 23:28, Russell King - ARM Linux wrote:

> It most certainly does handle the wrapping correctly - it was designed
> to from the very start.

I'm not an expert on Linux kernel and its core infrastructure,
but how is the sched_clock_timer armed for the first time
after calling setup_sched_clock?

The explicitely called update_sched_clock() does _not_ arm it.

Shawn: could you try change the
  update_sched_clock();
to
  sched_clock_poll(sched_clock_timer.data);
right after update_sched_clock call in setup_sched_clock?

Regards
-- 
                                    Stano

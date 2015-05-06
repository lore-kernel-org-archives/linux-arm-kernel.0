From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 May 2015 12:19:49 +0100
Subject: High-resolution timers not supported when using smp_twd on
 Cortex A9
In-Reply-To: <554727A0.3040601@free.fr>
References: <554727A0.3040601@free.fr>
Message-ID: <20150506111949.GP2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 04, 2015 at 10:02:40AM +0200, Mason wrote:
> (The system's clocksource is a 27 MHz 32-bit counter.)
> 
> If I remove the CLOCK_EVT_FEAT_C3STOP flag, then hrtimers are enabled,
> but I assume I would then run into problems in low-power mode, going by
> Russell's commit message.

It seems that you've done the research, and judging from the question
you ask below, you already know the answer:

> Do I have to use a platform-specific clockevent source if I want
> high-resolution timers on the system?

Yes - because the TWD stops in low power modes, which makes it unsuitable
as a high-resolution timer.  These kinds of issues are annoying, but it's
the way things are.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Tue, 29 Nov 2016 17:05:19 +0300
Subject: [PATCH] clocksource/arm_global_timer: reconfigure clockevents
 after cpufreq change
In-Reply-To: <alpine.DEB.2.20.1611291432290.4358@nanos>
References: <1480421716-30782-1-git-send-email-al.kochet@gmail.com>
 <1480421716-30782-2-git-send-email-al.kochet@gmail.com>
 <alpine.DEB.2.20.1611291432290.4358@nanos>
Message-ID: <2F6A5074-F54E-4B16-AB3D-DE7301E363FC@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Thomas!

> 29 ????. 2016 ?., ? 16:42, Thomas Gleixner <tglx@linutronix.de> ???????(?):
> 
> The frequency change would not only affect the clockevent device, it also
> would affect the clocksource. So the patch is incomplete, but see below.
Looks like kernel disallow change clocksource and shed_clock rate at
runtime. I haven?t found any function for that.

> 29 ????. 2016 ?., ? 16:42, Thomas Gleixner <tglx@linutronix.de> ???????(?):
> 
> That's broken and the clk framework should keep the CORE_PERI clock at a
> constant rate by reprogramming the divider of the CPU clock.

Thank you for the hint.

> Assumptions w/o real impact are a perfect reason not to apply that
> patch. This want's a proper proof that the global timer really changes and
> this hackery is required, which I seriously doubt.

It really changes. It changes like it changes for smp-twd. I guess they are
driven by same clock CORE_PERI.

Thank you for help.

Alexander.

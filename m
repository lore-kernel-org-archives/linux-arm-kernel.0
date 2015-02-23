From: tony@atomide.com (Tony Lindgren)
Date: Mon, 23 Feb 2015 15:59:47 -0800
Subject: New l3-noc error with CPUFREQ_DT built-in with v4.0-rc1
Message-ID: <20150223235947.GC25954@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nishanth,

Olof told me about a new L3 error happening on omap5-uevm with
v4.0-rc1:

WARNING: CPU: 0 PID: 0 at drivers/bus/omap_l3_noc.c:147 l3_interrupt_handler+0x214/0x340()
4000000.ocp:L3 Custom Error: MASTER MPU TARGET L4PER2 (Idle): Data Access in Supervisor mode during Functional access
...

I tried bisecting this with no luck, but narrowed it down to
having CONFIG_CPUFREQ_DT=y causing it, while =m wont' trigger
it. This got changed by commit 40d1746d2eee ("ARM:
omap2plus_defconfig: use CONFIG_CPUFREQ_DT").

Any ideas?

Regards,

Tony

From: will.deacon@arm.com (Will Deacon)
Date: Wed, 27 Jan 2010 17:26:27 -0000
Subject: [PATCH 5/5] arm/perfevents: implement perf event support for ARMv6
In-Reply-To: <201001261847.44774.jpihet@mvista.com>
References: <1263471256-3739-1-git-send-email-jamie.iles@picochip.com>
	<20100126160929.GG4260@wear.picochip.com>
	<201001261711.44598.jpihet@mvista.com>
	<201001261847.44774.jpihet@mvista.com>
Message-ID: <000701ca9f75$dbe071f0$93a155d0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

* Jean Pihet wrote:

> Here is the latest version of the patch, after review on the ML. 
> Adds the Performance Events support for ARMv7 processor, using
> the PMNC unit in HW.

I tested this on a dual-core Cortex-A9 [Realview PBX board].
One thing I noticed was that, even if you don't add the PMU IRQs to
kernel/pmu.c, perf will still report event counts [I guess this is
due to sampling on context switch etc]. However, if the IRQs are
defined, but for some reason we fail to request them, then the
armpmu_reserve_hardware function will fail. Actually, the return
value appears to be uninitialised if you don't have any IRQs defined.

Anyway, apart from that, it appeared to work fine.

Tested-by: Will Deacon <will.deacon@arm.com>

Will

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 25 Sep 2015 17:05:46 +0100
Subject: [PATCH] arm-cci500: Workaround pmu_event_set_period
In-Reply-To: <1443196253-22765-1-git-send-email-suzuki.poulose@arm.com>
References: <1443196253-22765-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20150925160546.GQ21513@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As you're posting an update to CCI500, I thought I'd hijack this
thread to complain about the same thing that I complained about
with CCI400:

+config ARM_CCI500_PMU
+       bool "ARM CCI500 PMU support"
+       default y
+       depends on (ARM && CPU_V7) || ARM64
+       depends on PERF_EVENTS
+       select ARM_CCI_PMU

Why "default y" ?  Not all ARMv7 CPUs have the CCI bus, and what it
means is that when moving forward, it's a pain to remember to turn
the option off amongst all the other Kconfig questions.

Only make things "default y" if it was something that was built in
a previous kernel and not building it in a later kernel would cause
a regression, or where it's absolutely necessary to do so.

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

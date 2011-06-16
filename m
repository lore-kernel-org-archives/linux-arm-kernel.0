From: khilman@ti.com (Kevin Hilman)
Date: Thu, 16 Jun 2011 09:15:57 -0700
Subject: [PATCH v2 00/18] GPIO: OMAP: Driver Cleanup and Fixes
In-Reply-To: <1308058321-12875-1-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Tue, 14 Jun 2011 19:01:43 +0530")
References: <1308058321-12875-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <87ei2trbuq.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> This series is continuation of cleanup of OMAP GPIO driver and fixes.
> The cleanup include getting rid of cpu_is_* checks wherever possible,
> use of gpio_bank list instead of static array, use of unique platform
> specific value associated data member to OMAP platforms to avoid
> cpu_is_* checks. The series also include PM runtime support.

A quick test of this series on 3430/n900 shows that it prevents PER
retention.  I see CM_FCLKEN_PER=0000c000 (debounce clock for GPIO banks
3 & 4 are still enabled.)

Can you retest with debounce enabled on one of the GPIOs for one of your platforms?

Kevin

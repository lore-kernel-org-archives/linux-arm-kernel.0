From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Dec 2011 08:42:45 +0000
Subject: [PATCH 5/5 v2] ARM: OMAP1: recalculate loops per jiffy after
 dpll1 reprogram
In-Reply-To: <1322526332-14088-1-git-send-email-jkrzyszt@tis.icnet.pl>
References: <1322364751-29980-6-git-send-email-jkrzyszt@tis.icnet.pl>
 <1322526332-14088-1-git-send-email-jkrzyszt@tis.icnet.pl>
Message-ID: <20111209084245.GB14547@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2011 at 01:25:32AM +0100, Janusz Krzysztofik wrote:
> However, the result of cpufreq_scale() differs from that of
> (re)calibrate_delay() by ca. 6%, i.e., 70.40 vs. 74.54. Please advise if
> this approximation is acceptable.

You don't say which figure is what.

Note that calibrate_delay() is itself inaccurate - the loops_per_jiffy
is the number of loops which can be executed between two timer ticks
_minus_ the time to process the timer interrupt itself.  So, it's
actually always a little less than the theoretical number of loops
within that time period.

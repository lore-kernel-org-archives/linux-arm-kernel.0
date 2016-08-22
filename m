From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 22 Aug 2016 15:10:46 +0100
Subject: [PATCHv2] arm: l2x0: add PMU support
In-Reply-To: <1471602346-26466-1-git-send-email-mark.rutland@arm.com>
References: <1471602346-26466-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1471875046.5473.11.camel@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-08-19 at 11:25 +0100, Mark Rutland wrote:
> The L2C-220 (AKA L220) and L2C-310 (AKA PL310) cache controllers
> feature
> a Performance Monitoring Unit (PMU), which can be useful for tuning
> and/or debugging. This hardware is always present and the relevant
> registers are accessible to non-secure accesses. Thus, no special
> firmware interface is necessary.
> 
> This patch adds support for the PMU, plugging into the usual perf
> infrastructure. The overflow interrupt is not always available (e.g.
> on
> RealView PBX A9 it is not wired up at all), and the hardware counters
> saturate, so the driver does not make use of this. Instead, the
> driver
> periodically polls and reset counters as required to avoid losing
> events due to saturation.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Kim Phillips <kim.phillips@arm.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Will Deacon <will.deacon@arm.com>

For what it's worth, it's enthusiastically

Acked-by: Pawel Moll <pawel.moll@arm.com>

Thanks!

Pawel

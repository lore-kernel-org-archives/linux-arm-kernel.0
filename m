From: kim.phillips@arm.com (Kim Phillips)
Date: Thu, 18 Aug 2016 19:05:46 -0500
Subject: [PATCH] arm: l2x0: add PMU support
In-Reply-To: <1471451191-18090-1-git-send-email-mark.rutland@arm.com>
References: <1471451191-18090-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20160818190546.3c81388f8bd6d311bd28207c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Aug 2016 17:26:31 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> The L2C-220 (AKA L220) and L2C-310 (AKA PL310) cache controllers feature
> a Performance Monitoring Unit (PMU), which can be useful for tuning
> and/or debugging. This hardware is always present and the relevant
> registers are accessible to non-secure accesses. Thus, no special
> firmware interface is necessary.
>
> This patch adds support for the PMU, plugging into the usual perf
> infrastructure. The overflow interrupt is not always available (e.g. on
> RealView PBX A9 it is not wired up at all), and the hardware counters
> saturate, so the driver does not make use of this. Instead, the driver
> periodically polls and reset counters as required to avoid losing
> events due to saturation.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Kim Phillips <kim.phillips@arm.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Will Deacon <will.deacon@arm.com>
> ---

FWIW, I was able to test this successfully on a pandaboard.

Thanks,

Kim
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

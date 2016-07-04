From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 04 Jul 2016 14:39:44 +0100
Subject: [PATCH 1/2] arm-ccn: ensure perf synchronisation
In-Reply-To: <1467136218-15789-2-git-send-email-mark.rutland@arm.com>
References: <1467136218-15789-1-git-send-email-mark.rutland@arm.com>
 <1467136218-15789-2-git-send-email-mark.rutland@arm.com>
Message-ID: <1467639584.22236.1.camel@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dnia 2016-06-28, Tue o godzinie 18:50 +0100, Mark Rutland pisze:
> Currently the IRQ core is permitted to make the CCN PMU IRQ handler
> threaded, and will allow userspace to change the CPU affinity of the
> interrupt behind our back. Both of these could violate our
> synchronisation requirements with the core perf code, which relies upon
> strict CPU affinity and disabling of interrupts to guarantee mutual
> exclusion in some cases.
> 
> As with the CPU PMU drivers, we should request the interrupt with
> IRQF_NOBALANCING and IRQF_NO_THREAD, to avoid these issues.

> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

Acked-by: Pawel Moll <pawel.moll@arm.com>

In principle, because still had no chance to test it...

Thanks!

Pawel

From: will.deacon@arm.com (Will Deacon)
Date: Wed, 2 Mar 2011 12:10:55 -0000
Subject: [patch v2 2/3] arm: pmu: allow platform specifc irq
	enable/disable handling
In-Reply-To: <1299063420-22203-3-git-send-email-tom.leiming@gmail.com>
References: <1299063420-22203-1-git-send-email-tom.leiming@gmail.com>
	<1299063420-22203-3-git-send-email-tom.leiming@gmail.com>
Message-ID: <001001cbd8d2$e25c9080$a715b180$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> -----Original Message-----
> From: tom.leiming at gmail.com [mailto:tom.leiming at gmail.com]
> Sent: 02 March 2011 10:57
> To: linux at arm.linux.org.uk
> Cc: linux-arm-kernel at lists.infradead.org; Will Deacon; Ming Lei
> Subject: [patch v2 2/3] arm: pmu: allow platform specifc irq enable/disable handling
> 
> From: Ming Lei <tom.leiming@gmail.com>
> 
> This patch introduces .enable_irq and .disable_irq into
> struct arm_pmu_platdata, so platform specific irq enablement
> can be handled after request_irq, and platform specific irq
> disablement can be handled before free_irq.
> 
> This patch is for support of  pmu irq routed from CTI on omap4.
> 
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> ---
>  arch/arm/include/asm/pmu.h   |   15 ++++++++++++---
>  arch/arm/kernel/perf_event.c |   15 ++++++++++++---
>  2 files changed, 24 insertions(+), 6 deletions(-)

[...]

Looks good to me. Unfortunately, I don't have an OMAP4 to test this
on (contributions welcome :) so I've just eyeballed the code:

Reviewed-by: Will Deacon <will.deacon@arm.com>

You'll need to wait for the ux500 stuff to be merged before you can
get this upstream (Linus W is handling the pull request afaik).

Will

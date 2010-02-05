From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 5 Feb 2010 09:13:50 +0000
Subject: [PATCH 2/5] arm/oprofile: reserve the PMU when starting
In-Reply-To: <20100205060153.GA21979@mvista.com>
References: <1263471256-3739-1-git-send-email-jamie.iles@picochip.com>
	<1263471256-3739-2-git-send-email-jamie.iles@picochip.com>
	<1263471256-3739-3-git-send-email-jamie.iles@picochip.com>
	<20100205060153.GA21979@mvista.com>
Message-ID: <20100205091350.GB18726@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 05, 2010 at 01:01:54AM -0500, George G. Davis wrote:
> From 18018f4e439ebcf9358790887502764b18459c9c Mon Sep 17 00:00:00 2001
> From: George G. Davis <gdavis@mvista.com>
> Date: Fri, 5 Feb 2010 00:38:01 -0500
> Subject: [PATCH] ARM: Fix ARM11 MPCore OProfile breakage due to ARM patch 5901/2
> 
> The recent "fe6c67f ARM: 5901/2: arm/oprofile: reserve the PMU when
> starting" commit broke OProfile support on ARM11 MPCore targets by
> adding a misplaced "} else {" clause in function em_start() which
> results in a call to release_pmu() even though the PMU is in use
> which in turn results in an oops while using OProfile.  Removing
> the stray else clause fixes the problem.
> 
> Signed-off-by: George G. Davis <gdavis@mvista.com>
> ---
>  arch/arm/oprofile/op_model_mpcore.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/oprofile/op_model_mpcore.c b/arch/arm/oprofile/op_model_mpcore.c
> index f73ce87..0d4f099 100644
> --- a/arch/arm/oprofile/op_model_mpcore.c
> +++ b/arch/arm/oprofile/op_model_mpcore.c
> @@ -246,7 +246,6 @@ static int em_start(void)
>  		if (ret) {
>  			arm11_release_interrupts(pmu_irqs->irqs,
>  						 pmu_irqs->num_irqs);
> -		} else {
>  			release_pmu(pmu_irqs);
>  			pmu_irqs = NULL;
>  		}
> 
> 
> --
Hi George,

Good catch. Looks good to me.

Jamie

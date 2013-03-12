From: srinidhi.kasagar@stericsson.com (Srinidhi Kasagar)
Date: Tue, 12 Mar 2013 11:12:29 +0530
Subject: [PATCH] ARM: ux500: Remove duplicate ux500_l2x0_unlock function
In-Reply-To: <20130312045823.GA526@android11.spreadtrum.com>
References: <20130312045823.GA526@android11.spreadtrum.com>
Message-ID: <20130312054226.GA811@bnru09>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 05:58:23 +0100, Steve zhan wrote:
> Hi Linus:
>     Pls check/apply the below patch.
> Thanks.

NAK, I think you have not read the comment i guess. See below.

> 
> -----
> steve
> 
> commit f962757a91b1c83a080e7c5b05cc6fb7828f1d84
> Author: steve.zhan <zhanzhenbo@gmail.com>
> Date:   Tue Mar 12 00:12:53 2013 +0800
> 
>     ARM: ux500: Remove duplicate ux500_l2x0_unlock function
>     
>     To avoids code duplication, remove reduplicate l2 cache unlock
>     function "ux500_l2x0_unlock" in the ux500_l2x0_init, as arm\mm
>     \cache-l2x0.c l2x0_init will call l2x0_unlock function to
>     make sure that I&D is not locked down when starting.
>     
>     Signed-off-by: steve.zhan <zhanzhenbo@gmail.com>
> 
> diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.c
> index 1c1609d..372bdf6 100644
> --- a/arch/arm/mach-ux500/cache-l2x0.c
> +++ b/arch/arm/mach-ux500/cache-l2x0.c
> @@ -15,26 +15,6 @@
>  
>  static void __iomem *l2x0_base;
>  
> -static int __init ux500_l2x0_unlock(void)
> -{
> -	int i;
> -
> -	/*
> -	 * Unlock Data and Instruction Lock if locked. Ux500 U-Boot versions
> -	 * apparently locks both caches before jumping to the kernel. The
> -	 * l2x0 core will not touch the unlock registers if the l2x0 is
> -	 * already enabled, so we do it right here instead. The PL310 has

The l2x0 core will unlock only if l2x0 is already not enabled. So we need this.

/srinidhi

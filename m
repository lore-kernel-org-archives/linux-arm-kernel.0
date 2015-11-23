From: horms@verge.net.au (Simon Horman)
Date: Sun, 22 Nov 2015 17:11:05 -0800
Subject: [PATCH] mach-shmobile/setup-r8a7793.c: proper constness with
 __initconst
In-Reply-To: <alpine.LFD.2.20.1511212036580.22569@knanqh.ubzr>
References: <alpine.LFD.2.20.1511212036580.22569@knanqh.ubzr>
Message-ID: <20151123011105.GF29534@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[CC: linux-sh]

On Sat, Nov 21, 2015 at 08:41:07PM -0500, Nicolas Pitre wrote:
> Both the pointer array and the pointed data have to be const when using
> __initconst to be correct.  This also fixes LTO builds that otherwise
> fail with section mismatch errors.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Thanks, I have queued this up as a fix for v4.4 with the following tag:

Fixes: ec60d95b4fac ("ARM: shmobile: Basic r8a7793 SoC support")

> diff --git a/arch/arm/mach-shmobile/setup-r8a7793.c b/arch/arm/mach-shmobile/setup-r8a7793.c
> index 1d2825cb7a..5fce87f7f2 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7793.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7793.c
> @@ -19,7 +19,7 @@
>  #include "common.h"
>  #include "rcar-gen2.h"
>  
> -static const char *r8a7793_boards_compat_dt[] __initconst = {
> +static const char * const r8a7793_boards_compat_dt[] __initconst = {
>  	"renesas,r8a7793",
>  	NULL,
>  };
> 

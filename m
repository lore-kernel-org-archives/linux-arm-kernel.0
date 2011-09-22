From: khilman@ti.com (Kevin Hilman)
Date: Thu, 22 Sep 2011 16:11:38 -0700
Subject: [PATCH 02/10] cpufreq: OMAP: Add SMP support for OMAP4+
In-Reply-To: <1316725648-26710-3-git-send-email-khilman@ti.com> (Kevin
	Hilman's message of "Thu, 22 Sep 2011 14:07:20 -0700")
References: <1316725648-26710-1-git-send-email-khilman@ti.com>
	<1316725648-26710-3-git-send-email-khilman@ti.com>
Message-ID: <87sjnonped.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman <khilman@ti.com> writes:

> From: Russell King <rmk+kernel@arm.linux.org.uk>
>
> On OMAP SMP configuartion, both processors share the voltage
> and clock. So both CPUs needs to be scaled together and hence
> needs software co-ordination.

[...]

> diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
> index a6b2be7..f9b4c4d 100644
> --- a/drivers/cpufreq/omap-cpufreq.c
> +++ b/drivers/cpufreq/omap-cpufreq.c
> @@ -23,6 +23,7 @@
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/opp.h>
> +#include <linux/cpu.h>
>  
>  #include <asm/system.h>
>  #include <asm/smp_plat.h>

Thanks to checkpatch, I blindly removed an "#include <asm/cpu.h>" here
without re-testing.  Turns out it was important.

Added it back, and updated the version available in my
for_3.2/omap-cpufreq branch.

Kevin

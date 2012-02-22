From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Feb 2012 09:52:50 +0000
Subject: [PATCH v2 07/19] ARM: at91/pm_slowclock: function slow_clock()
 accepts parameters
In-Reply-To: <5b8fbdf669825987a82b3b89b2e7f02239cad816.1329903206.git.nicolas.ferre@atmel.com>
References: <0d78171672a30e8ec8084f54a557e9948260356d.1329903206.git.nicolas.ferre@atmel.com>
 <5b8fbdf669825987a82b3b89b2e7f02239cad816.1329903206.git.nicolas.ferre@atmel.com>
Message-ID: <20120222095250.GV22562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 22, 2012 at 10:39:33AM +0100, Nicolas Ferre wrote:
> @@ -232,7 +246,7 @@ static int at91_pm_enter(suspend_state_t state)
>  				/* copy slow_clock handler to SRAM, and call it */
>  				memcpy(slow_clock, at91_slow_clock, at91_slow_clock_sz);
>  #endif
> -				slow_clock();
> +				slow_clock(at91_pmc_base, at91_ramc0_base, at91_ramc1_base);

This should be updated to use the fncpy() stuff if there's any chance that
you'll be supporting Thumb-2.  Using fncpy() is probably a good idea even
if you aren't.  See asm/fncpy.h

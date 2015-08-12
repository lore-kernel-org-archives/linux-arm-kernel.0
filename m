From: tony@atomide.com (Tony Lindgren)
Date: Wed, 12 Aug 2015 00:25:36 -0700
Subject: [PATCH] ARM: OMAP3: clock: remove un-used core dpll re-program
 code
In-Reply-To: <1437034091-18306-1-git-send-email-t-kristo@ti.com>
References: <1437034091-18306-1-git-send-email-t-kristo@ti.com>
Message-ID: <20150812072535.GQ4215@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [150716 01:10]:
> Remove the OMAP3 core DPLL re-program code, and the associated SRAM
> code that does the low-level programming of the DPLL divider, idling
> of the SDRAM etc.
> 
> This code was never fully implemented in the kernel; things missing
> were driver side handling of core clock changes (they need to account
> for their functional clock rate being changed on-the-fly), and the whole
> framework required for handling this. Thus, there is not much point
> to keep carrying the low-level support code either.

OK I'm applying this into omap-for-v4.3/soc. If we ever need the code
it will be in the git history.

Regards,

Tony

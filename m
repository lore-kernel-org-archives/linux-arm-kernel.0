From: tony@atomide.com (Tony Lindgren)
Date: Wed, 12 Aug 2015 03:56:42 -0700
Subject: [PATCH] ARM: OMAP3: clock: remove un-used core dpll re-program
 code
In-Reply-To: <20150812072535.GQ4215@atomide.com>
References: <1437034091-18306-1-git-send-email-t-kristo@ti.com>
 <20150812072535.GQ4215@atomide.com>
Message-ID: <20150812105642.GW4215@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [150812 00:29]:
> * Tero Kristo <t-kristo@ti.com> [150716 01:10]:
> > Remove the OMAP3 core DPLL re-program code, and the associated SRAM
> > code that does the low-level programming of the DPLL divider, idling
> > of the SDRAM etc.
> > 
> > This code was never fully implemented in the kernel; things missing
> > were driver side handling of core clock changes (they need to account
> > for their functional clock rate being changed on-the-fly), and the whole
> > framework required for handling this. Thus, there is not much point
> > to keep carrying the low-level support code either.
> 
> OK I'm applying this into omap-for-v4.3/soc. If we ever need the code
> it will be in the git history.

Actually I'll wait on this one and apply it later on as it currently
adds merge conflicts into Linux next.

Regards,

Tony

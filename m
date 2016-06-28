From: tony@atomide.com (Tony Lindgren)
Date: Tue, 28 Jun 2016 00:03:54 -0700
Subject: [RESEND PATCHv2 06/28] ARM: OMAP2+: hwmod: fetch main_clk based
 on hwmod name
In-Reply-To: <1465844702-12200-7-git-send-email-t-kristo@ti.com>
References: <1465844702-12200-1-git-send-email-t-kristo@ti.com>
 <1465844702-12200-7-git-send-email-t-kristo@ti.com>
Message-ID: <20160628070354.GE28140@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [160613 12:07]:
> With the transition to hwmod module clocks, all hwmods will have
> their main clocks named <hwmod_name>_mod_ck. Use this info to
> fetch main_clk, and use it if found.
> 
> Also, if a main_clk is found based on the hwmod name, disable
> the direct PRCM modulemode access from hwmod.

Makes sense, otherwise unknown number of things will break before
we have the clock phandles available in the dts files for these:

Acked-by: Tony Lindgren <tony@atomide.com>

Or let me know if you want me to queue this separately.

Regards,

Tony

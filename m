From: tony@atomide.com (Tony Lindgren)
Date: Fri, 26 May 2017 08:44:16 -0700
Subject: [PATCHv3 1/3] ARM: OMAP2+: hwmod: assign main clock from DT if
 available
In-Reply-To: <1495127772-7486-2-git-send-email-t-kristo@ti.com>
References: <1495127772-7486-1-git-send-email-t-kristo@ti.com>
 <1495127772-7486-2-git-send-email-t-kristo@ti.com>
Message-ID: <20170526154416.GC3717@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [170518 10:19]:
> Fix the main clock assignment to assign clkctrl clk from DT as the main
> clock if available. If main clock is assigned via DT, the direct PRCM
> access for module handling is not used on OMAP4+ architectures either,
> as it is assumed the main clock will be doing this instead.

Is this still needed based on what we chatted last week?

I'd like to avoid adding the clkctrl clocks to the wrong node
as we then end up moving them again later on when we have support
for the wrapper device..

Regards,

Tony

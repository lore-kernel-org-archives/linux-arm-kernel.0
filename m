From: tony@atomide.com (Tony Lindgren)
Date: Tue, 7 Aug 2012 00:28:52 -0700
Subject: [RFC 1/6] ARM: OMAP3: PRM: move prcm interrupt handlers to PRM
 driver code
In-Reply-To: <87ipd4g4a5.fsf@ti.com>
References: <1342197459-7920-1-git-send-email-t-kristo@ti.com>
 <1342197459-7920-2-git-send-email-t-kristo@ti.com>
 <87ipd4g4a5.fsf@ti.com>
Message-ID: <20120807072852.GN11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [120730 17:36]:
> 
> At first, I wasn't sure why this was happening on Overo boards and not
> on the other boards, but then I notcied there was a *lot* more pm_wkup
> interrupts during boot on Overo compared to the other boards.  This is
> because of the GPIO IRQ for the network interface as well as the network
> stack itself setting timers, resulting in a lot more pm_wkup events
> during boot and making the race more likely.

Also happens if you may have somehow both edges selected for GPIO
interrupts. Might be worth checking at least just in case of bugs
somewhere..

Tony

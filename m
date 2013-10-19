From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 19 Oct 2013 17:40:28 +0000 (UTC)
Subject: [PATCH 05/11] ARM: OMAP3: CM/PM: add API for accessing module
 clock enable registers
In-Reply-To: <1381508141-15244-6-git-send-email-t-kristo@ti.com>
References: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
 <1381508141-15244-6-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.02.1310191737390.12900@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Oct 2013, Tero Kristo wrote:

> PRCM chain handler needs these to properly acknowledge wakeup events.
> Currently this functionality is implemented as direct register accesses,
> but as the CM code should eventually move to its own driver, separate
> API calls are now added for this purpose. PM core code is also changed
> to use these APIs.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

In theory, shouldn't the clock code know which clocks are enabled and 
disabled?  Seems like if it can use standard CCF code for this, this code 
might also be able to avoid slow PRM/CM register accesses.  
That prcm_clear_mod_irqs() function should probably be a hwmod-based 
interface anyway...


- Paul

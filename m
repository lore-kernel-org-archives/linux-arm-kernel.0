From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 22 Mar 2012 16:34:59 +0800
Subject: [PATCH] ARM: mxs: enforce semantics of
 clk_prepare()/clk_unprepare() and clk_enable()/clk_disable()
In-Reply-To: <1332404298-18891-1-git-send-email-LW@KARO-electronics.de>
References: <1332404298-18891-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <20120322083457.GE2213@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 22, 2012 at 09:18:17AM +0100, Lothar Wa?mann wrote:
> After introducing clk_prepare()/clk_unprepare() there may still be
> drivers out there that don't use the new functions.
> This patch warns about drivers calling clk_enable() without a
> preceding clk_prepare() and various other invalid sequences of calls
> to clk_enable()/clk_disable() and clk_prepare()/clk_unprepare().
> 

I plan to migrate the mxs clock driver to common clk framework in the
next merge window.  Thus, I do not see much point to take this patch.

> To not make a system unusable due to excessive warning messages the
> warnings are limited to 1 per clk by a flag in the 'flags' member of
> struct clk.
> 
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
>  arch/arm/mach-mxs/clock.c              |   98 ++++++++++++++++++++++++++++----
>  arch/arm/mach-mxs/include/mach/clock.h |    6 ++
>  2 files changed, 93 insertions(+), 11 deletions(-)

-- 
Regards,
Shawn

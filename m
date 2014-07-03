From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 3 Jul 2014 22:35:59 +0800
Subject: [PATCH] ARM: imx: build cpu_is_imx6sl function conditionally
In-Reply-To: <4295402.oOSEcbAj2f@wuerfel>
References: <4295402.oOSEcbAj2f@wuerfel>
Message-ID: <20140703143558.GG30239@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 04:22:54PM +0200, Arnd Bergmann wrote:
> imx6q_pm_enter calls imx6sl_set_wait_clk when run on an imx6sl
> based machine. However if support for imx6sl is not enabled
> at compile time, this prevents us from building the kernel and
> we get this link error instead:
> 
> arch/arm/mach-imx/built-in.o: In function `imx6q_pm_enter':
> :(.text+0x4b84): undefined reference to `imx6sl_set_wait_clk'
> 
> This makes the cpu_is_imx6sl function conditionally return false
> if imx6sl is disabled at compile-time, which matches what the
> older cpu_is_mx* macros did. We have similar inline functions for
> the other imx6 variants, but so far I have not run into a case
> where the extra #ifdef is necessary.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks.

From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 15 Jan 2014 19:27:54 +0800
Subject: [PATCH] ARM: imx: clk-imx6sl: Suppress duplicate const sparse
 warning
In-Reply-To: <1389766774-16661-1-git-send-email-Ying.Liu@freescale.com>
References: <1389766774-16661-1-git-send-email-Ying.Liu@freescale.com>
Message-ID: <20140115112753.GJ1896@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 15, 2014 at 02:19:34PM +0800, Liu Ying wrote:
> There should be no duplicate const specifiers for those static
> constant character string arrays defined for clock mux options.
> Also, the arrays are only taken as the 5th argument for the
> imx_clk_mux() function, which is in the type of 'const char
> **parents'.  So, let's remove the 2nd const specifier right
> after 'char'.
> 
> This patch fixes these sparse warnings:
> arch/arm/mach-imx/clk-imx6sl.c:21:25: warning: duplicate const
> arch/arm/mach-imx/clk-imx6sl.c:22:25: warning: duplicate const
> arch/arm/mach-imx/clk-imx6sl.c:23:25: warning: duplicate const
> arch/arm/mach-imx/clk-imx6sl.c:24:25: warning: duplicate const
> arch/arm/mach-imx/clk-imx6sl.c:25:25: warning: duplicate const
> arch/arm/mach-imx/clk-imx6sl.c:26:25: warning: duplicate const
> arch/arm/mach-imx/clk-imx6sl.c:27:25: warning: duplicate const
> arch/arm/mach-imx/clk-imx6sl.c:28:25: warning: duplicate const
> arch/arm/mach-imx/clk-imx6sl.c:29:25: warning: duplicate const
> arch/arm/mach-imx/clk-imx6sl.c:30:25: warning: duplicate const
> arch/arm/mach-imx/clk-imx6sl.c:31:25: warning: duplicate const
> arch/arm/mach-imx/clk-imx6sl.c:32:25: warning: duplicate const
> arch/arm/mach-imx/clk-imx6sl.c:33:25: warning: duplicate const
> arch/arm/mach-imx/clk-imx6sl.c:34:25: warning: duplicate const
> arch/arm/mach-imx/clk-imx6sl.c:35:25: warning: duplicate const
> arch/arm/mach-imx/clk-imx6sl.c:36:25: warning: duplicate const
> arch/arm/mach-imx/clk-imx6sl.c:37:25: warning: duplicate const
> arch/arm/mach-imx/clk-imx6sl.c:38:25: warning: duplicate const
> arch/arm/mach-imx/clk-imx6sl.c:39:25: warning: duplicate const
> arch/arm/mach-imx/clk-imx6sl.c:40:25: warning: duplicate const
> arch/arm/mach-imx/clk-imx6sl.c:41:25: warning: duplicate const
> 
> Signed-off-by: Liu Ying <Ying.Liu@freescale.com>

Applied both, thanks.

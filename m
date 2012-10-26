From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Oct 2012 21:01:44 +0000
Subject: [GIT PULL] i.MX fixes for -rc
In-Reply-To: <20121024075656.GW27665@pengutronix.de>
References: <20121024075656.GW27665@pengutronix.de>
Message-ID: <201210262101.44700.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 October 2012, Sascha Hauer wrote:
>       ARM i.MX25: Fix PWM per clock lookups

This patch is now causing build errors in imx_v4_v5_defconfig:

arch/arm/mach-imx/clk-imx25.c: In function 'mx25_clocks_init':
arch/arm/mach-imx/clk-imx25.c:206:26: error: 'pwm_ipg_per' undeclared (first use in this function)
arch/arm/mach-imx/clk-imx25.c:206:26: note: each undeclared identifier is reported only once for each function it appears in

Any idea what went wrong? The symbol doesn't seem to exist anywhere in
v3.7-rc2. Should I revert this patch for now?

	Arnd

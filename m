From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 17 Jan 2013 18:56:32 +0800
Subject: [PATCH] ARM: imx: select HAVE_IMX_SRC when SMP is enabled
In-Reply-To: <1358419936.2731.221.camel@sauron.fi.intel.com>
References: <1350977942-15964-1-git-send-email-shawn.guo@linaro.org>
 <1358419936.2731.221.camel@sauron.fi.intel.com>
Message-ID: <20130117105631.GM26179@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 17, 2013 at 12:52:16PM +0200, Artem Bityutskiy wrote:
> Err, sorry, the issue I get is a bit different, but similar:
> 
> arch/arm/mach-imx/built-in.o: In function `imx6q_restart':
> platform-spi_imx.c:(.text+0x2220): undefined reference to `imx_src_prepare_restart'
> arch/arm/mach-imx/built-in.o: In function `imx6q_pm_enter':
> platform-spi_imx.c:(.text+0x22e4): undefined reference to `imx_set_cpu_jump'
> arch/arm/mach-imx/built-in.o: In function `imx6q_init_irq':
> platform-spi_imx.c:(.init.text+0x7280): undefined reference to `imx_src_init'
> make[1]: *** [vmlinux] Error 1
> 
The fix [1] is on the way to mainline.

Shawn

[1] http://article.gmane.org/gmane.linux.ports.arm.kernel/209206

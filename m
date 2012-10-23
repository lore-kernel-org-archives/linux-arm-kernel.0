From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 23 Oct 2012 18:48:51 +0800
Subject: IMX breaking Versatile Express build
In-Reply-To: <20121023090805.GQ21164@n2100.arm.linux.org.uk>
References: <20121023090805.GQ21164@n2100.arm.linux.org.uk>
Message-ID: <20121023104846.GB3253@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 10:08:05AM +0100, Russell King - ARM Linux wrote:
> The latest Versatile Express specific build is failing due to:
> 
> arch/arm/mach-imx/built-in.o: In function `imx_cpu_die':
> platform-imx-dma.c:(.text+0x1624): undefined reference to `imx_enable_cpu'
> arch/arm/mach-imx/built-in.o: In function `imx_boot_secondary':
> platform-imx-dma.c:(.cpuinit.text+0x14): undefined reference to `imx_set_cpu_jump'
> platform-imx-dma.c:(.cpuinit.text+0x20): undefined reference to `imx_enable_cpu'
> 
We have a fix [1] for that waiting for arm-soc folks to pick up.

Shawn

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/194310

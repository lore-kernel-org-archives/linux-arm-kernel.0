From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Sep 2011 20:39:29 +0200
Subject: [PATCH 2/6] arm/imx6q: add core definitions and low-level debug
	uart
In-Reply-To: <1315303120-24203-3-git-send-email-shawn.guo@linaro.org>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
	<1315303120-24203-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <3922347.lxZAT2yslI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 September 2011 17:58:36 Shawn Guo wrote:
> --- /dev/null
> +++ b/arch/arm/plat-mxc/include/mach/mx6q.h
> @@ -0,0 +1,29 @@
> +#ifndef __MACH_MX6Q_H__
> +#define __MACH_MX6Q_H__
> +
> +/* static mappings */
> +#define IMX6Q_VA(x)            (0xf4000000 + (x))

This should return a 'void __iomem *' pointer, not an integer.

> +#define MX6Q_SCU_BASE_ADDR     0x00a00000
> +#define MX6Q_CCM_BASE_ADDR     0x020c4000
> +#define MX6Q_ANATOP_BASE_ADDR  0x020c8000
> +#define MX6Q_UART4_BASE_ADDR   0x021f0000
> +
> +#define MX6Q_SCU_BASE_VADDR    IMX6Q_VA(MX6Q_SCU_BASE_ADDR)
> +#define MX6Q_CCM_BASE_VADDR    IMX6Q_VA(MX6Q_CCM_BASE_ADDR)
> +#define MX6Q_ANATOP_BASE_VADDR IMX6Q_VA(MX6Q_ANATOP_BASE_ADDR)
> +#define MX6Q_UART4_BASE_VADDR  IMX6Q_VA(MX6Q_UART4_BASE_ADDR)

The list is reasonably short, but I think you can still try harder to remove
some of the remaining elements. I can understand the need for UART4
(for ll_debug), but I don't really understand what the others are and
why you cannot get the values from the device tree and ioremap them.

Maybe you can add a few comments to explain these if they are indeed
necessary.

	Arnd

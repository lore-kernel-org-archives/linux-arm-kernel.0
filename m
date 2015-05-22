From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 22 May 2015 23:35:27 +0800
Subject: [PATCH] ARM: imx: make imx51/3 suspend optional
In-Reply-To: <2236337.NNZMvqcbY8@wuerfel>
References: <2236337.NNZMvqcbY8@wuerfel>
Message-ID: <20150522153525.GM24844@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 02:06:30PM +0200, Arnd Bergmann wrote:
> A recent change to the imx53 power management caused a build
> regression when CONFIG_SOC_IMX53 is disabled:
> 
> mach-imx/built-in.o:(.init.rodata+0x60): undefined reference to `imx53_suspend'
> mach-imx/built-in.o:(.init.rodata+0x64): undefined reference to `imx53_suspend_sz'
> 
> This avoids the problem by compiling the code in question
> conditionally on the presence of CONFIG_SOC_IMX53. For
> consistency, I'm also changing the same thing for
> CONFIG_SOC_IMX51.
> 
> An additional benefit of this approach is reduced code size
> for kernels that only include support for one of the two
> SoCs.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 41c1b15afa2c7 ("ARM: imx53: Set DDR pins to high impedance when in suspend to RAM.")
> ---
> Please apply on top of the broken commit

Applied.  Thanks for the fixing, Arnd.

Shawn

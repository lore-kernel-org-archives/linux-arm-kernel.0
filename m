From: olof@lixom.net (Olof Johansson)
Date: Tue, 18 Feb 2014 16:04:31 -0800
Subject: [PATCH RESEND] ARM: imx6: build pm-imx6q.c independently of
 CONFIG_PM
In-Reply-To: <1392690905-16839-1-git-send-email-shawn.guo@linaro.org>
References: <1392690905-16839-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20140219000431.GC25055@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 10:35:05AM +0800, Shawn Guo wrote:
> When building a kernel image with only CONFIG_CPU_IDLE but no CONFIG_PM,
> we will get the following link error.
> 
>   LD      init/built-in.o
> arch/arm/mach-imx/built-in.o: In function `imx6q_enter_wait':
> platform-spi_imx.c:(.text+0x25c0): undefined reference to `imx6q_set_lpm'
> platform-spi_imx.c:(.text+0x25d4): undefined reference to `imx6q_set_lpm'
> arch/arm/mach-imx/built-in.o: In function `imx6q_cpuidle_init':
> platform-spi_imx.c:(.init.text+0x75d4): undefined reference to `imx6q_set_chicken_bit'
> make[1]: *** [vmlinux] Error 1
> 
> Since pm-imx6q.c has been a collection of library functions that access
> CCM low-power registers used by not only suspend but also cpuidle and
> other drivers, let's build pm-imx6q.c independently of CONFIG_PM to fix
> above error.
> 
> Reported-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: stable at vger.kernel.org
> Acked-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> ---
> Kevin, Olof, Arnd,
> 
> Please apply this fix for v3.14.  Thanks.

Applied, thanks.


-Olof

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 23 Feb 2015 10:45:44 +0100
Subject: [PATCH] ARM: sunxi: Have ARCH_SUNXI select RESET_CONTROLLER for
 clock driver usage
In-Reply-To: <1423477400-30520-1-git-send-email-wens@csie.org>
References: <1423477400-30520-1-git-send-email-wens@csie.org>
Message-ID: <20150223094544.GC25269@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 09, 2015 at 06:23:20PM +0800, Chen-Yu Tsai wrote:
> As the sunxi usb clocks all contain a reset controller, it is not
> possible to build the sunxi clock driver without RESET_CONTROLLER
> enabled. Doing so results in an undefined symbol error:
> 
>     drivers/built-in.o: In function `sunxi_gates_clk_setup':
>     linux/drivers/clk/sunxi/clk-sunxi.c:1071: undefined reference to
> 	`reset_controller_register'
> 
> This is possible if building a minimal kernel without PHY_SUN4I_USB.
> 
> The dependency issue is made visible at compile time instead of
> link time by the new A80 mmc clocks, which also use a reset control
> itself.
> 
> This patch makes ARCH_SUNXI select ARCH_HAS_RESET_CONTROLLER and
> RESET_CONTROLLER.
> 
> Reported-by: Lourens Rozema <ik@lourensrozema.nl>
> Fixes: 559482d1f950 ARM: sunxi: Split the various SoCs support in Kconfig
> Cc: <stable@vger.kernel.org> # 3.16+
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied with Arnd Acked-by.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150223/992ecf70/attachment.sig>

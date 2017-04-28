From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 28 Apr 2017 09:35:42 +0200
Subject: [PATCH] clk: sunxi-ng: always select CCU_GATE
In-Reply-To: <20170427110239.2389266-1-arnd@arndb.de>
References: <20170427110239.2389266-1-arnd@arndb.de>
Message-ID: <20170428073542.jamyyjgafirqtth4@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1;4601;0c
On Thu, Apr 27, 2017 at 01:02:31PM +0200, Arnd Bergmann wrote:
> When the base driver is enabled but all SoC specific drivers are turned
> off, we now get a build error after code was added to always refer to the
> clk gates:
> 
> drivers/clk/built-in.o: In function `ccu_pll_notifier_cb':
> :(.text+0x154f8): undefined reference to `ccu_gate_helper_disable'
> :(.text+0x15504): undefined reference to `ccu_gate_helper_enable'
> 
> This changes the Kconfig to always require the gate code to be built-in
> when CONFIG_SUNXI_CCU is set.
> 
> Fixes: 02ae2bc6febd ("clk: sunxi-ng: Add clk notifier to gate then ungate PLL clocks")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Stephen, Mike, can you apply this patch directly? This affects the
current (4.11) release, so we probably don't want to have the overhead
of a PR here :/

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170428/b43c9300/attachment.sig>

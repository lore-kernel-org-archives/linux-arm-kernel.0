From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 27 Apr 2017 09:04:36 +0200
Subject: [PATCH v2] clk: sunxi-ng: Fix dependency on SUNXI_CCU_GATE
In-Reply-To: <20170426115319.30951-1-clabbe.montjoie@gmail.com>
References: <20170426115319.30951-1-clabbe.montjoie@gmail.com>
Message-ID: <20170427070436.3qu4mzepq4gmmymi@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 26, 2017 at 01:53:19PM +0200, Corentin Labbe wrote:
> When CONFIG_SUNXI_CCU is set but no other SUNXI_CCU is selected i got
> the following build error:
> drivers/built-in.o: In function `ccu_pll_notifier_cb':
> drivers/clk/sunxi-ng/ccu_common.c:71: undefined reference to `ccu_gate_helper_disable'
> drivers/clk/sunxi-ng/ccu_common.c:73: undefined reference to `ccu_gate_helper_enable'
> 
> The problem is the function ccu_pll_notifier_cb in ccu_common.c need
> some function from ccu_gate.c which is not compiled since SUNXI_CCU_GATE
> is not selected.
> 
> This patch remove SUNXI_CCU_GATE and compile ccu_gate.c unconditionnaly
> since all other combination of options select SUNXI_CCU_GATE finally.
> 
> Fixes: 02ae2bc6febd ("clk: sunxi-ng: Add clk notifier to gate then ungate PLL clocks")
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

I think Chen-Yu had some comments that you didn't address.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170427/ca785aac/attachment.sig>

From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Thu, 27 Apr 2017 10:12:49 +0200
Subject: [PATCH v2] clk: sunxi-ng: Fix dependency on SUNXI_CCU_GATE
In-Reply-To: <20170427070436.3qu4mzepq4gmmymi@lukather>
References: <20170426115319.30951-1-clabbe.montjoie@gmail.com>
 <20170427070436.3qu4mzepq4gmmymi@lukather>
Message-ID: <20170427081249.GA25781@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 27, 2017 at 09:04:36AM +0200, Maxime Ripard wrote:
> On Wed, Apr 26, 2017 at 01:53:19PM +0200, Corentin Labbe wrote:
> > When CONFIG_SUNXI_CCU is set but no other SUNXI_CCU is selected i got
> > the following build error:
> > drivers/built-in.o: In function `ccu_pll_notifier_cb':
> > drivers/clk/sunxi-ng/ccu_common.c:71: undefined reference to `ccu_gate_helper_disable'
> > drivers/clk/sunxi-ng/ccu_common.c:73: undefined reference to `ccu_gate_helper_enable'
> > 
> > The problem is the function ccu_pll_notifier_cb in ccu_common.c need
> > some function from ccu_gate.c which is not compiled since SUNXI_CCU_GATE
> > is not selected.
> > 
> > This patch remove SUNXI_CCU_GATE and compile ccu_gate.c unconditionnaly
> > since all other combination of options select SUNXI_CCU_GATE finally.
> > 
> > Fixes: 02ae2bc6febd ("clk: sunxi-ng: Add clk notifier to gate then ungate PLL clocks")
> > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> 
> I think Chen-Yu had some comments that you didn't address.
> 

I have changed subject as requested

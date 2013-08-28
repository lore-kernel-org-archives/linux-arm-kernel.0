From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 27 Aug 2013 18:12:04 -0700
Subject: [GIT PULL] Allwinner sunXi clock patches for 3.12
In-Reply-To: <20130826091434.GA4980@lukather>
References: <20130826091434.GA4980@lukather>
Message-ID: <20130828011204.8231.86567@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Maxime Ripard (2013-08-26 02:14:34)
> Hi Mike,
> 
> Please pull the following branch with the sunxi additions to the clk
> driver for the 3.12 merge window, based on your current clk-next.
> 
> Please note that the patch "clk: sunxi: fix initialization of basic
> clocks" from Emilio, that you told was applied, wasn't in your clk-next
> branch, so I took it, as it conflicted with later patches.

Ah, right. I had that patch in my local branch so I got a conflict with
OF_CLK_DECLARE for the osc clock. I went with the version in your pull
request ("sun4i_osc" versus "sunxi_osc").

Regards,
Mike

> 
> Thanks!
> Maxime
> 
> The following changes since commit bddbd13453d838a30baf84869c56076c8ce2b211:
> 
>   Merge tag 'zynq-clk-for-3.12' of git://git.xilinx.com/linux-xlnx into clk-next (2013-08-20 14:58:48 -0700)
> 
> are available in the git repository at:
> 
> 
>   https://github.com/mripard/linux.git tags/sunxi-clk-for-3.12
> 
> for you to fetch changes up to 1fb2e4aab8b31b15e6be5debacb4203333360fd2:
> 
>   clk: sunxi: Add Allwinner A20 gates (2013-08-26 10:58:21 +0200)
> 
> ----------------------------------------------------------------
> Allwinner clock changes for 3.12
> 
> These patches mostly do some cleanup to introduce the basic gated clocks for
> the Allwinner A10s, A20 and A31 SoCs.
> 
> ----------------------------------------------------------------
> Emilio L?pez (1):
>       clk: sunxi: fix initialization of basic clocks
> 
> Maxime Ripard (5):
>       clk: sunxi: Add A10s gates
>       clk: sunxi: Rename the structure to prepare the addition of sun6i
>       clk: sunxi: Allow to specify the divider width from the dividers data
>       clk: sunxi: Add A31 clocks support
>       clk: sunxi: Add Allwinner A20 gates
> 
>  Documentation/devicetree/bindings/clock/sunxi.txt  |  12 +
>  .../bindings/clock/sunxi/sun5i-a10s-gates.txt      |  75 +++++++
>  .../bindings/clock/sunxi/sun6i-a31-gates.txt       |  83 +++++++
>  .../bindings/clock/sunxi/sun7i-a20-gates.txt       |  98 +++++++++
>  drivers/clk/sunxi/clk-sunxi.c                      | 241 +++++++++++++++++----
>  5 files changed, 464 insertions(+), 45 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/sunxi/sun5i-a10s-gates.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/sunxi/sun6i-a31-gates.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/sunxi/sun7i-a20-gates.txt
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com

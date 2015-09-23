From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 22 Sep 2015 17:53:00 -0700
Subject: [PATCH v2 2/2] ARM: imx31: Do not call mxc_timer_init twice when
 booting with DT
In-Reply-To: <1441791315-25390-2-git-send-email-alexander.stein@systec-electronic.com>
References: <1441791315-25390-1-git-send-email-alexander.stein@systec-electronic.com>
 <1441791315-25390-2-git-send-email-alexander.stein@systec-electronic.com>
Message-ID: <20150923005300.GD3529@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 09, 2015 at 11:35:15AM +0200, Alexander Stein wrote:
> mxc_timer_init must not be called from within mx31_clocks_init_dt. It will
> eventually be called by imx31_timer_init_dt
> (drivers/clocksource/timer-imx-gpt.c).
> This arranges the initialization code similar to clk-imx27.c
> 
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> ---
> * Added in v2
> * Compile tested only due to lack of hardware

Compile tested?  I see the following compile issues.

  CC      drivers/clk/imx/clk-imx31.o
drivers/clk/imx/clk-imx31.c: In function ?mx31_clocks_init?:
drivers/clk/imx/clk-imx31.c:152:2: error: too few arguments to function ?_mx31_clocks_init?
drivers/clk/imx/clk-imx31.c:65:20: note: declared here
drivers/clk/imx/clk-imx31.c: In function ?mx31_clocks_init_dt?:
drivers/clk/imx/clk-imx31.c:226:2: error: void value not ignored as it ought to be
drivers/clk/imx/clk-imx31.c:227:1: warning: control reaches end of non-void function [-Wreturn-type]

Shawn

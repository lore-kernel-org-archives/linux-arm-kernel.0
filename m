From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 Jul 2016 15:49:44 +0100
Subject: [GIT PULL] STi late updates for v4.8
In-Reply-To: <5784F935.9050000@st.com>
References: <5784F935.9050000@st.com>
Message-ID: <20160712144944.GG1611@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Jul 2016, Patrice Chotard wrote:

> Hi Olof, Arnd and Kevin,
> 
> Please consider this first round of STi late updates for v4.8:
> 
> 
> The following changes since commit 6ca59e6e1fc3a8d7ccbf85ff036bd6ff40847c1a:
> 
>   clk: st: clkgen-pll: Detect critical clocks (2016-06-30 12:17:11 -0700)

This should be one of the -rcs.

> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git tags/sti-late-v4.8
> 
> for you to fetch changes up to cf4b5ceb95b1e8842bc4f061a8ba8c395b5dbc6d:
> 
>   spi: st-ssc4: Remove 'no clocking' hack (2016-07-12 13:22:55 +0200)
> 
> ----------------------------------------------------------------
> Highlights:
> -----------
> - Add STi DT critical clocks declaration
> - Remove SPI hack wich has dependecy with critical clocks
> 
> These 2 STi DT patches and SPI hack MUST be applied after patches
> contained into Stephen Boyd's branch clk-next/clk-st-critical.
> This to ensure not to break SPI.

Okay, good.

> ----------------------------------------------------------------
> Lee Jones (3):
>       ARM: sti: stih407-family: Supply defines for CLOCKGEN A0
>       ARM: sti: stih410-clocks: Identify critical clocks
>       spi: st-ssc4: Remove 'no clocking' hack

Doh!  Both this and the diff below need to contain the driver/clk
patches, as Olof already mentioned.

>  arch/arm/boot/dts/stih410-clock.dtsi     |  9 ++++++++
>  drivers/spi/spi-st-ssc4.c                | 36 +++++---------------------------
>  include/dt-bindings/clock/stih407-clks.h |  4 ++++
>  3 files changed, 18 insertions(+), 31 deletions(-)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

From: robh@kernel.org (Rob Herring)
Date: Wed, 30 Nov 2016 14:48:59 -0600
Subject: [PATCH v2 2/9] clk: stm32f4: Add PLL_I2S & PLL_SAI for
 STM32F429/469 boards
In-Reply-To: <1479998749-20358-3-git-send-email-gabriel.fernandez@st.com>
References: <1479998749-20358-1-git-send-email-gabriel.fernandez@st.com>
 <1479998749-20358-3-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20161130204859.gfqw6wdbq4repcje@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2016 at 03:45:42PM +0100, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> This patch introduces PLL_I2S and PLL_SAI.
> Vco clock of these PLLs can be modify by DT (only n multiplicator,
> m divider is still fixed by the boot-loader).
> Each PLL has 3 dividers. PLL should be off when we modify the rate.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>  .../devicetree/bindings/clock/st,stm32-rcc.txt     |   2 +
>  drivers/clk/clk-stm32f4.c                          | 342 ++++++++++++++++++++-
>  include/dt-bindings/clock/stm32f4-clock.h          |   4 +-
>  3 files changed, 332 insertions(+), 16 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

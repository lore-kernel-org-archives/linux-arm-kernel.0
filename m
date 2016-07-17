From: robh@kernel.org (Rob Herring)
Date: Sun, 17 Jul 2016 15:53:35 -0500
Subject: [PATCH] clk: zynq: avoid retrieving clock names from DT property
In-Reply-To: <1468682123-1434-1-git-send-email-yamada.masahiro@socionext.com>
References: <1468682123-1434-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20160717205335.GA24048@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 17, 2016 at 12:15:23AM +0900, Masahiro Yamada wrote:
> The "clock-output-names" property is useful for generic clock
> providers such as fixed-clock, fixed-factor-clock, etc.
> 
> On the other hand, it should not be used for really SoC-specific
> clock providers like this one.  As you see in "enum zynq_clk" in
> this driver, it is written as if it already knows all the clock
> names.  Besides, this is instantiated only once, so no clock name
> conflict would happen even if the clock names are hard-coded in the
> driver.
> 
> The device tree (arch/arm/boot/dts/zynq-7000.dtsi) will be fixed
> later.

This should be done now so dts files and docs are in sync.

> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> This patch was tested on Zynq Zedboard.
> 
> 
>  .../devicetree/bindings/clock/zynq-7000.txt         | 13 -------------
>  drivers/clk/zynq/clkc.c                             | 21 ++++++++++++---------
>  2 files changed, 12 insertions(+), 22 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

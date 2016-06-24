From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 24 Jun 2016 16:00:00 +0800
Subject: [PATCH v2 0/4] ASoC: sunxi: Add i2s controller support
In-Reply-To: <20160615211123.31068-1-maxime.ripard@free-electrons.com>
References: <20160615211123.31068-1-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64=15sv8GKDKDMA4VOkdE35=TwuX0D0m5JDpVbw6RYn_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2016 at 5:11 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi everyone,
>
> This is the second version of the I2S support for the controller found
> in the Allwinner A10 and later SoCs.
>
> Playback has been tested with an UDA1380 on an A20-Olinuxino. Capture
> is not implemented yet, but will come eventually.
>
> Let me know what you think,
> Maxime
>
> Changes from v1:
>   - Fixed bogus indentation and spurious whitespaces / newlines
>   - Moved the device initialisation in the probe to the startup function
>   - Disabled the device in shutdown
>   - Removed function to get wss and sr to inline them in hw_params
>   - Changed the way to access the divider array
>   - Checked clk_set_rate return code
>   - Fixed condition for invalid bclk and mclk dividers
>   - Added sound-dai-cells to the bindings documentation required properties
>
> Emilio L?pez (1):
>   ARM: sun7i: Add mod1 clock nodes
>
> Maxime Ripard (3):
>   ASoC: sunxi: Add A10 I2S controller binding documentation
>   ASoC: sunxi: Add Allwinner A10 Digital Audio driver
>   ARM: sun7i: Add DAI nodes
>
>  .../devicetree/bindings/sound/sun4i-i2s.txt        |  34 +
>  arch/arm/boot/dts/sun7i-a20.dtsi                   |  87 ++-
>  sound/soc/sunxi/Kconfig                            |   9 +
>  sound/soc/sunxi/Makefile                           |   2 +-
>  sound/soc/sunxi/sun4i-i2s.c                        | 703 +++++++++++++++++++++
>  5 files changed, 832 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/sun4i-i2s.txt
>  create mode 100644 sound/soc/sunxi/sun4i-i2s.c

Tested-by: Chen-Yu Tsai <wens@csie.org>

on a BPI-M1+ with a TI PCM5122-based PiFi DAC+ v2.0, a Raspberry Pi B+
compatible DAC shield.

I kept getting low but audible pops though. Not sure if it's the
ad-hoc setup or some other factor.

ChenYu

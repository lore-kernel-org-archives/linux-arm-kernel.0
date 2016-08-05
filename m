From: patrice.chotard@st.com (Patrice Chotard)
Date: Fri, 5 Aug 2016 10:11:03 +0200
Subject: [RESEND PATCH v2 00/13] Clock improvement for video playback
In-Reply-To: <1466068833-5055-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1466068833-5055-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <b6389057-0c53-7095-81a3-617aff678e28@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike

I believe that you and Gabriel found an agreement to include this series in v4.8

Unfortunately it seems it's not the case, for which reason ?

Thanks

Patrice



On 06/16/2016 11:20 AM, Gabriel Fernandez wrote:
> v2:
>   - Simpliflication of clock binding
>     remark from Rob https://lkml.org/lkml/2016/5/25/492
>   - Suppression of stih415-416 support for the clocks (in order
> 	to help simplification of clock binding)
>     (others patchs for the machine and drivers will come)
>
> This serie allows to increase video resolutions and make audio
> adjustment during a video playback.
>
> Gabriel Fernandez (13):
>   drivers: clk: st: Remove stih415-416 clock support
>   drivers: clk: st: Simplify clock binding of STiH4xx platforms
>   drivers: clk: st: Add fs660c32 synthesizer algorithm
>   drivers: clk: st: Add clock propagation for audio clocks
>   drivers: clk: st: Handle clk synchronous mode for video clocks
>   ARM: DT: STiH407: Enable clock propagation for audio clocks
>   ARM: DT: STiH410: Enable clock propagation for audio clocks
>   ARM: DT: STiH418: Enable clock propagation for audio clocks
>   ARM: DT: STiH407: Enable synchronous clock mode for video clocks
>   ARM: DT: STiH410: Enable synchronous clock mode for video clocks
>   ARM: DT: STiH418: Enable synchronous clock mode for video clocks
>   ARM: DT: STi: STiH407: clock configuration to address 720p and 1080p
>   ARM: DT: STi: STiH410: clock configuration to address 720p and 1080p
>
>  .../bindings/clock/st/st,clkgen-divmux.txt         |  49 --
>  .../devicetree/bindings/clock/st/st,clkgen-mux.txt |  20 +-
>  .../devicetree/bindings/clock/st/st,clkgen-pll.txt |  35 +-
>  .../bindings/clock/st/st,clkgen-prediv.txt         |  36 -
>  .../devicetree/bindings/clock/st/st,clkgen-vcc.txt |  61 --
>  .../devicetree/bindings/clock/st/st,clkgen.txt     |  54 +-
>  .../devicetree/bindings/clock/st/st,flexgen.txt    |   4 +
>  .../devicetree/bindings/clock/st/st,quadfs.txt     |  31 +-
>  arch/arm/boot/dts/stih407-clock.dtsi               |   4 +-
>  arch/arm/boot/dts/stih407.dtsi                     |  16 +-
>  arch/arm/boot/dts/stih410-clock.dtsi               |   4 +-
>  arch/arm/boot/dts/stih410.dtsi                     |  16 +-
>  arch/arm/boot/dts/stih418-clock.dtsi               |   4 +-
>  drivers/clk/st/clk-flexgen.c                       |  61 +-
>  drivers/clk/st/clkgen-fsyn.c                       | 481 ++++---------
>  drivers/clk/st/clkgen-mux.c                        | 748 +--------------------
>  drivers/clk/st/clkgen-pll.c                        | 470 +------------
>  17 files changed, 297 insertions(+), 1797 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/st/st,clkgen-divmux.txt
>  delete mode 100644 Documentation/devicetree/bindings/clock/st/st,clkgen-prediv.txt
>  delete mode 100644 Documentation/devicetree/bindings/clock/st/st,clkgen-vcc.txt
>

From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Fri, 17 Jan 2014 00:06:15 -0300
Subject: [PATCH v3 0/8] ARM: sunxi: rename DT clock node names to clk@N
In-Reply-To: <1389257565-19797-1-git-send-email-wens@csie.org>
References: <1389257565-19797-1-git-send-email-wens@csie.org>
Message-ID: <52D89E27.6060204@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

El 09/01/14 05:52, Chen-Yu Tsai escribi?:
> This is v3 of the clock node renaming patch series, which renames
> the clock nodes in sunxi dts to conform to device tree naming
> conventions, i.e. clk at N. Dummy clocks that will be renamed/removed
> later, or clocks sharing registers are not renamed.
>
> Renamed clock nodes have clock-output-names properties added to
> desginate their names. Support for this is added in the first
> patch.
>
> Changes since v2:
>
>    * Dropped Cubietruck dts i2c controller patch. Maxime has taken it.
>    * Changed ARM in commit messages to uppercase.
>    * Add pll5, pll6 clock names to factors_data tied to compatible strings.
>    * Dropped pll5 output name in dts due to the previous change.
>    * Added dts binding documentation for "clock-output-names", as well as
>      examples.
>
> Changes since v1:
>
>    * Fixed pll5, pll6 divs clock name handling
>
> Cheers
> ChenYu
>
> Chen-Yu Tsai (8):
>    clk: sunxi: add clock-output-names dt property support
>    clk: sunxi: update clock-output-names dt binding documentation
>    clk: sunxi: add names for pll5, pll6 parent clocks to factors_data
>    clk: sunxi: get divs parent clock name from parent factor clock
>    ARM: dts: sun4i: rename clock node names to clk at N
>    ARM: dts: sun5i: rename clock node names to clk at N
>    ARM: dts: sun6i: rename clock node names to clk at N
>    ARM: dts: sun7i: rename clock node names to clk at N
>
>   Documentation/devicetree/bindings/clock/sunxi.txt | 36 +++++++++++++++++++----
>   arch/arm/boot/dts/sun4i-a10.dtsi                  | 24 ++++++++-------
>   arch/arm/boot/dts/sun5i-a10s.dtsi                 | 24 ++++++++-------
>   arch/arm/boot/dts/sun5i-a13.dtsi                  | 24 ++++++++-------
>   arch/arm/boot/dts/sun6i-a31.dtsi                  | 12 ++++----
>   arch/arm/boot/dts/sun7i-a20.dtsi                  | 19 +++++++-----
>   drivers/clk/sunxi/clk-sunxi.c                     | 36 ++++++++++++++++-------
>   7 files changed, 117 insertions(+), 58 deletions(-)

The series looks good to me, other than the comment I made. Once that's 
settled, and if Mike, Maxime or anyone else have no further comments, 
I'll queue 1-4 for 3.15.

Cheers, and thanks for working on this!

Emilio

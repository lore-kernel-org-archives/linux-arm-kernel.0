From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 13 Nov 2016 17:55:21 +0800
Subject: [PATCH 7/10] clk: sunxi-ng: Add A13 CCU driver
In-Reply-To: <1fe10e9ca64dce0a06a2d83693cbaf6ee3a76bde.1478625788.git-series.maxime.ripard@free-electrons.com>
References: <cover.326f50aecc25fbe292184527b52a1e3172aba9cf.1478625788.git-series.maxime.ripard@free-electrons.com>
 <1fe10e9ca64dce0a06a2d83693cbaf6ee3a76bde.1478625788.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v66JfjmfZUwPxgft+xgDgfb+Y0Se5qadGiPXqG5HYok72g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 9, 2016 at 1:23 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/clk/sunxi-ng/Kconfig         |  10 +-
>  drivers/clk/sunxi-ng/Makefile        |   1 +-
>  drivers/clk/sunxi-ng/ccu-sun5i-a13.c | 681 ++++++++++++++++++++++++++++-
>  3 files changed, 692 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun5i-a13.c

I'm not sure what to make of this one. Presumably this is the same as the A10s,
with some bits (TS, HDMI, I2S, GPS) removed. BTW you kept the GPS reset control
in this one.

Hans and others have said and IIRC proven that the sun5i is the same die, with
some exposing more peripherals than others. Wouldn't it make sense to use the
same CCU driver for all of them? It's not like Allwinner actually disabled the
clock control or hardware block.

If you don't like it, perhaps you can share the same set of definitions, but
have separate lists of what clocks are registered, for each SoC variant. That
would at least cut down on code size and the effort to maintain 3 copies of
almost the exact same thing.

I guess the same applies to the GR8 CCU driver patch. And the comments from
the previous (A10s CCU driver) patch applies to both.

Let me know what you think.


Regards
ChenYu

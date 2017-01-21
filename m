From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 21 Jan 2017 09:34:15 +0800
Subject: [PATCH v3 5/7] clk: sunxi-ng: Add sun5i CCU driver
In-Reply-To: <a51d856e896b7fe59a1a544a7de3081688e377ff.1484897383.git-series.maxime.ripard@free-electrons.com>
References: <cover.5df5469d9c7a6233e225a875dca513a03b05e871.1484897383.git-series.maxime.ripard@free-electrons.com>
 <a51d856e896b7fe59a1a544a7de3081688e377ff.1484897383.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65uzxu7P3AcnhJJ_rEvT5OL8=d9-jVjU5sWNNqJpkpSRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 3:29 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The Allwinner A10s, A13, R8 and NextThing GR8 are all based on the same
> silicon, and all share the same clocks.
>
> However, they're not packaged in the same way, and therefore not all the
> controllers are actually available on all these SoCs.
>
> Introduce a clock controller driver for all these SoCs with different
> compatibles to take that into account.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

> ---
>  drivers/clk/sunxi-ng/Kconfig          |   10 +-
>  drivers/clk/sunxi-ng/Makefile         |    1 +-
>  drivers/clk/sunxi-ng/ccu-sun5i.c      | 1008 ++++++++++++++++++++++++++-
>  drivers/clk/sunxi-ng/ccu-sun5i.h      |   67 ++-
>  include/dt-bindings/clock/sun5i-ccu.h |  103 +++-
>  include/dt-bindings/reset/sun5i-ccu.h |   32 +-

I thought having these 2 in a separate patch would be better for
cross tree merges?

>  6 files changed, 1221 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun5i.c
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun5i.h
>  create mode 100644 include/dt-bindings/clock/sun5i-ccu.h
>  create mode 100644 include/dt-bindings/reset/sun5i-ccu.h
>

ChenYu

From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 31 Jul 2017 14:00:12 +0200
Subject: [PATCH 0/2] clk: meson: expose clk ids
In-Reply-To: <20170731113832.26490-1-jbrunet@baylibre.com>
References: <20170731113832.26490-1-jbrunet@baylibre.com>
Message-ID: <203231e0-1d9b-ecca-bc04-d5133fb2ec87@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31/2017 01:38 PM, Jerome Brunet wrote:
> In previous cycles, concerns have been raised about the way clocks are
> exposed for the meson clock controller, only when validated and required
> in DT.
> 
> Instead, this patchset expose all the known clocks which may be needed in
> DT later on. The clocks left out are internal clocks which should never be
> used directly in DT. These are mostly internal muxes and dividers of
> composite clocks.
> 
> While this should reduce the patch flow on the related header files, It
> won't stop it completely. There are still many clocks we don't know about
> yet. We tend discover a few in every cycle.
> 
> This patchset depends on these fixes [0] to avoid issues when adding new
> clk ids.
> 
> [0]: https://lkml.kernel.org/r/20170727161755.10393-1-jbrunet at baylibre.com
> 
> Jerome Brunet (2):
>   clk: meson8b: expose every clock in the bindings
>   clk: meson-gxbb: expose almost every clock in the bindings
> 
>  drivers/clk/meson/gxbb.h                 | 117 ++-----------------------------
>  drivers/clk/meson/meson8b.h              | 103 ++-------------------------
>  include/dt-bindings/clock/gxbb-clkc.h    |  60 ++++++++++++++++
>  include/dt-bindings/clock/meson8b-clkc.h |  70 ++++++++++++++++++
>  4 files changed, 141 insertions(+), 209 deletions(-)
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

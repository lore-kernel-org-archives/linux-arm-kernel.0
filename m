From: robh@kernel.org (Rob Herring)
Date: Sat, 8 Oct 2016 20:29:03 -0500
Subject: [PATCH 05/12] ASoC: sun4i-codec: Add support for A31 playback
 through headphone output
In-Reply-To: <20161003110804.28235-6-wens@csie.org>
References: <20161003110804.28235-1-wens@csie.org>
 <20161003110804.28235-6-wens@csie.org>
Message-ID: <20161009012903.GN18158@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 03, 2016 at 07:07:57PM +0800, Chen-Yu Tsai wrote:
> The A31 has a similar codec to the A10/A20. The PCM parts are very
> similar, with just different register offsets. The analog paths are
> very different. There are more inputs and outputs.
> 
> The quirks structure is expanded to include different register offsets
> and separate callbacks for creating the ASoC card. Also the DMA burst
> length is increased to 8. While the A10 DMA engine supports bursts of
> 1, 4 and 8, the A31 engine only supports 1 and 8.
> 
> This patch adds support for the basic playback path of the A31 codec,
> from the DAC to the headphones. Headphone detection, microphone,
> signaling, other inputs/outputs and capture will be added later.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../devicetree/bindings/sound/sun4i-codec.txt      |   6 +-

Acked-by: Rob Herring <robh@kernel.org>

>  sound/soc/sunxi/sun4i-codec.c                      | 396 +++++++++++++++++----
>  2 files changed, 334 insertions(+), 68 deletions(-)

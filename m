From: robh@kernel.org (Rob Herring)
Date: Tue, 15 Nov 2016 16:23:45 -0600
Subject: [PATCH 08/10] ASoC: sun4i-codec: Add support for H3 codec
In-Reply-To: <20161112064648.26779-9-wens@csie.org>
References: <20161112064648.26779-1-wens@csie.org>
 <20161112064648.26779-9-wens@csie.org>
Message-ID: <20161115222345.44b25usz2i6qeact@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 12, 2016 at 02:46:46PM +0800, Chen-Yu Tsai wrote:
> The codec on the H3 is similar to the one found on the A31. One key
> difference is the analog path controls are routed through the PRCM
> block. This is supported by the sun8i-codec-analog driver, and tied
> into this codec driver with the audio card's aux_dev.
> 
> In addition, the H3 has no HP (headphone) and HBIAS support, and no
> MIC3 input. The FIFO related registers are slightly rearranged.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../devicetree/bindings/sound/sun4i-codec.txt      |  3 +

Acked-by: Rob Herring <robh@kernel.org> 

>  sound/soc/sunxi/sun4i-codec.c                      | 71 ++++++++++++++++++++++
>  2 files changed, 74 insertions(+)

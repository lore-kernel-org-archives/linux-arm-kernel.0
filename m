From: robh@kernel.org (Rob Herring)
Date: Sat, 8 Oct 2016 20:29:06 -0500
Subject: [PATCH 10/12] ASoC: sun4i-codec: Add support for A31 board level
 audio routing
In-Reply-To: <20161003110804.28235-11-wens@csie.org>
References: <20161003110804.28235-1-wens@csie.org>
 <20161003110804.28235-11-wens@csie.org>
Message-ID: <20161009012906.GO18158@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 03, 2016 at 07:08:02PM +0800, Chen-Yu Tsai wrote:
> The A31 SoC's codec has various inputs, outputs and microphone bias
> supplies. These can be routed on the board in different ways, such as:
> 
>   - Microphones all use the MBIAS main microphone supply or one mic may
>     use the HBIAS supply, which supports headset detection and buttons.
> 
>   - Line Out may be routed to an audio jack, or an onboard speaker amp
>     with power controls.
> 
> Add support for specifying the audio routes in the device tree.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../devicetree/bindings/sound/sun4i-codec.txt      | 35 ++++++++++++++++++++++

Acked-by: Rob Herring <robh@kernel.org>

>  sound/soc/sunxi/sun4i-codec.c                      | 21 +++++++++++--
>  2 files changed, 54 insertions(+), 2 deletions(-)

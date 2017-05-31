From: robh@kernel.org (Rob Herring)
Date: Wed, 31 May 2017 11:56:51 -0500
Subject: [PATCH v3 4/9] ASoC: sun4i-codec: Add support for V3s codec
In-Reply-To: <20170524100607.29790-5-icenowy@aosc.io>
References: <20170524100607.29790-1-icenowy@aosc.io>
 <20170524100607.29790-5-icenowy@aosc.io>
Message-ID: <20170531165651.4bcmgskmspetw7cx@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 24, 2017 at 06:06:02PM +0800, Icenowy Zheng wrote:
> From: Icenowy Zheng <icenowy@aosc.xyz>
> 
> The codec in the V3s is similar to the one found on the A31. One key
> difference is the analog path controls are routed through the PRCM
> block. This is supported by the sun8i-codec-analog driver, and tied
> into this codec driver with the audio card's aux_dev.
> 
> In addition, the V3s does not have LINEIN, LINEOUT, MBIAS and MIC2,
> MIC3, and the FIFO related registers are like H3.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
> Changes in v3:
> - Change regmap max register.
> - Add a note for further DAP support.
> 
>  .../devicetree/bindings/sound/sun4i-codec.txt      | 11 ++--

Acked-by: Rob Herring <robh@kernel.org>

>  sound/soc/sunxi/sun4i-codec.c                      | 63 ++++++++++++++++++++++
>  2 files changed, 70 insertions(+), 4 deletions(-)

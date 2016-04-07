From: robh@kernel.org (Rob Herring)
Date: Thu, 7 Apr 2016 12:58:11 -0500
Subject: [PATCH] ASoC: rockchip: i2s: configure the sdio pins' iomux mode
In-Reply-To: <1459931902-77324-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1459931902-77324-1-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <20160407175811.GP32257@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 06, 2016 at 04:38:22PM +0800, Sugar Zhang wrote:
> There are 3 i2s sdio pins, which iomux mode is as follows:

s/i2s sdio/I2S\/SDIO muxed/

> 
>  - sdi3_sdo1
>  - sdi2_sdo2
>  - sdi1_sdo3
> 
> we need to configure these pins' iomux mode via the GRF register
> when use multi channel playback/capture.

Why not a pinctrl binding here? If you want SDIO mode, then you need 
similar code in the SDIO driver (or just rely on default mode).

> 
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> ---
> 
>  .../devicetree/bindings/sound/rockchip-i2s.txt     |  5 +++
>  sound/soc/rockchip/rockchip_i2s.c                  | 39 +++++++++++++++++++++-
>  sound/soc/rockchip/rockchip_i2s.h                  |  8 +++++
>  3 files changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
> index 6e86d8a..ad72a7d 100644
> --- a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
> +++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
> @@ -23,6 +23,11 @@ Required properties:
>  - rockchip,playback-channels: max playback channels, if not set, 8 channels default.
>  - rockchip,capture-channels: max capture channels, if not set, 2 channels default.
>  
> +Required properties for controller which support multi channels playback/capture:
> +
> +- rockchip,grf: Should be phandle/offset pair. the phandle of the syscon node for GRF register,

Wrap your lines at less than 80 chars.

> +  and the offset of the GRF for control register.
> +
>  Example for rk3288 I2S controller:
>  
>  i2s at ff890000 {

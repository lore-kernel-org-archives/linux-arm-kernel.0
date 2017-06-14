From: robh@kernel.org (Rob Herring)
Date: Wed, 14 Jun 2017 10:32:32 -0500
Subject: [PATCH v3 1/3] drm/rockchip: dw_hdmi: add RK3399 HDMI support
In-Reply-To: <1496992236-10634-1-git-send-email-mark.yao@rock-chips.com>
References: <1496992228-10582-1-git-send-email-mark.yao@rock-chips.com>
 <1496992236-10634-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <20170614153232.wbaa37zn24uusqlx@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 03:10:36PM +0800, Mark Yao wrote:
> RK3399 and RK3288 shared the same HDMI IP controller, only some light
> difference with GRF configure.
> 
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> ---
> Changes in v3:
>   remove hdmi_phy_configure_dwc_hdmi_3d_tx callbak.
> 
> Changes in v2:
>   reuse hdmi_phy_configure_dwc_hdmi_3d_tx for phy configure
>   fixup Documentation
> 
>  .../bindings/display/rockchip/dw_hdmi-rockchip.txt |  3 +-
>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        | 67 ++++++++++++++++++----
>  2 files changed, 58 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
> index 046076c..495bcf5 100644
> --- a/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
> +++ b/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
> @@ -11,7 +11,8 @@ following device-specific properties.
>  
>  Required properties:
>  
> -- compatible: Shall contain "rockchip,rk3288-dw-hdmi".
> +- compatible: "rockchip,rk3288-dw-hdmi",
> +              "rockchip,rk3399-dw-hdmi";

Is this supposed to be "one of" or both? Please format it as 1 valid 
combination per line. Drop the ',' and the ';' because I see that as dts 
syntax.

>  - reg: See dw_hdmi.txt.
>  - reg-io-width: See dw_hdmi.txt. Shall be 4.
>  - interrupts: HDMI interrupt number

From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 11 Mar 2015 10:28:29 +0100
Subject: [PATCH v2 1/2] drm/bridge: dw-hdmi: support optional supply
 regulators
In-Reply-To: <2265807.RXHBN9kUi4@phil>
References: <2265807.RXHBN9kUi4@phil>
Message-ID: <1426066109.3101.46.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

Am Dienstag, den 10.03.2015, 22:45 +0100 schrieb Heiko Stuebner:
> At least the Rockchip variant of the dw_hdmi can have controllable power supplies
> providing 1.0 and 1.8V. Therefore add the possibility for the generic bridge
> driver to enable supplies provided by the hw-specific drivers.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> changes since v1:
> - follow suggestion from Russell King to keep regulator handling local
>   to the rockchip implementation for the time being and only generalize
>   when a real second implementation needs regulator handling
> 
>  .../devicetree/bindings/drm/bridge/dw_hdmi.txt     |  5 ++++
>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        | 32 +++++++++++++++++++++-
>  2 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/drm/bridge/dw_hdmi.txt b/Documentation/devicetree/bindings/drm/bridge/dw_hdmi.txt
> index a905c14..bb74640 100644
> --- a/Documentation/devicetree/bindings/drm/bridge/dw_hdmi.txt
> +++ b/Documentation/devicetree/bindings/drm/bridge/dw_hdmi.txt
> @@ -22,6 +22,11 @@ Optional properties
>  - ddc-i2c-bus: phandle of an I2C controller used for DDC EDID probing
>  - clocks, clock-names: phandle to the HDMI CEC clock, name should be "cec"
>  
> +Optional supplies:
> +rockchip,rk3288-dw-hdmi handles two optional power supplies:
> +- avdd1v0-supply: 1.0V power supply
> +- avdd1v8-supply: 1.8V power supply

Are these the names used in the Rockchip documentation?

Since the older implementation on i.MX6 uses 1.1V (HDMI_VP) and 2.5V
(HDMI_VPH), I wonder whether each SoC should use their own name or
whether there should be common names that don't include the voltage.
I don't have the Synopsys HDMI TX docs, but I've seen avddhv and avddlv
used of other cores' analog supplies.

regards
Philipp

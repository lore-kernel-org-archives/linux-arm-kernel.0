From: robh@kernel.org (Rob Herring)
Date: Tue, 31 Jul 2018 13:36:44 -0600
Subject: [PATCH v4 1/4] gpio: syscon: rockchip: add GRF GPIO support for
 rk3328
In-Reply-To: <1533016762-5268-2-git-send-email-djw@t-chip.com.cn>
References: <1533016762-5268-1-git-send-email-djw@t-chip.com.cn>
 <1533016762-5268-2-git-send-email-djw@t-chip.com.cn>
Message-ID: <20180731193644.GA10459@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 01:59:19PM +0800, djw at t-chip.com.cn wrote:
> From: Levin Du <djw@t-chip.com.cn>
> 
> In Rockchip RK3328, the output only GPIO_MUTE pin, originally for codec
> mute control, can also be used for general purpose. It is manipulated by
> the GRF_SOC_CON10 register in GRF. Aside from the GPIO_MUTE pin, the HDMI
> pins can also be set in the same way.
> 
> Currently this GRF GPIO controller only supports the mute pin. If needed
> in the future, the HDMI pins support can also be added.
> 
> Signed-off-by: Levin Du <djw@t-chip.com.cn>
> 
> ---
> 
> Changes in v4:
> - Rename the GPIO binding to "rockchip,rk3328-grf-gpio"
> 
> Changes in v3:
> - Change from general gpio-syscon to specific rk3328-gpio-mute
> 
> Changes in v2:
> - Rename gpio_syscon10 to gpio_mute in doc
> 
> Changes in v1:
> - Refactured for general gpio-syscon usage for Rockchip SoCs.
> - Add doc rockchip,gpio-syscon.txt
> 
>  .../bindings/gpio/rockchip,rk3328-grf-gpio.txt     | 32 ++++++++++++++++++++++
>  drivers/gpio/gpio-syscon.c                         | 31 +++++++++++++++++++++
>  2 files changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/rockchip,rk3328-grf-gpio.txt

Reviewed-by: Rob Herring <robh@kernel.org>

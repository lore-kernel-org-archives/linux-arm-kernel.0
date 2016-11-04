From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 04 Nov 2016 09:07:11 +0100
Subject: [PATCH 4/6] ARM: dts: add basic support for Rockchip RK1108 SOC
In-Reply-To: <1478176848-12132-1-git-send-email-andy.yan@rock-chips.com>
References: <1478175975-11779-1-git-send-email-andy.yan@rock-chips.com>
 <1478176848-12132-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <18728215.xtkCC4d9TF@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 3. November 2016, 20:40:48 CET schrieb Andy Yan:
> RK1108 is embedded with an ARM Cortex-A7 single core and a DSP core.
> It is designed for varies application scenario such as car DVR, sports
> DV, secure camera and UAV camera.
> 
> This patch add basic support for it with DMAC / UART / CRU / pinctrl
> enabled.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---
> 
>  arch/arm/boot/dts/rk1108.dtsi     | 420
> ++++++++++++++++++++++++++++++++++++++ arch/arm/mach-rockchip/rockchip.c | 
>  1 +
>  2 files changed, 421 insertions(+)
>  create mode 100644 arch/arm/boot/dts/rk1108.dtsi
> 
> diff --git a/arch/arm/boot/dts/rk1108.dtsi b/arch/arm/boot/dts/rk1108.dtsi
> new file mode 100644
> index 0000000..9dccfea
> --- /dev/null
> +++ b/arch/arm/boot/dts/rk1108.dtsi

[...]

> +	pinctrl: pinctrl {
> +		compatible = "rockchip,rk1108-pinctrl";
> +		rockchip,grf = <&grf>;

missing rockchip,pmu phandle for gpio0 iomuxes and also syscon declaration for 
said pmugrf syscon in this file.


Heiko

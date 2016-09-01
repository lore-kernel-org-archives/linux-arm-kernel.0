From: dianders@chromium.org (Doug Anderson)
Date: Thu, 1 Sep 2016 10:57:49 -0700
Subject: [PATCH v2 3/4] arm64: dts: rockchip: add efuse0 device node for
 rk3399
In-Reply-To: <1470878029-11878-4-git-send-email-finley.xiao@rock-chips.com>
References: <1470878029-11878-1-git-send-email-finley.xiao@rock-chips.com>
 <1470878029-11878-4-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <CAD=FV=XHn-VGYZN0TrONHXrnpXP4a4Gk408SR0Q6xY9kVPV+aA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 10, 2016 at 6:13 PM, Finlye Xiao <finley.xiao@rock-chips.com> wrote:
> From: Finley Xiao <finley.xiao@rock-chips.com>
>
> Add a efuse0 node in the device tree for the ARM64 rk3399 SoC.
>
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)

Oddly this patch seems to have been dropped from v3 and v4 of the
series.  Seems like we still need it?


> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 4c84229..7f764ca 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -899,6 +899,35 @@
>                 status = "disabled";
>         };
>
> +       efuse0: efuse0 at ff690000 {

nit: should be efuse0: efuse at ff690000

AKA get rid of the "0" from the node name and just keep it in the alias.

> +               compatible = "rockchip,rk3399-efuse";
> +               reg = <0x0 0xff690000 0x0 0x80>;
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               clocks = <&cru PCLK_EFUSE1024NS>;
> +               clock-names = "pclk_efuse";
> +
> +               /* Data cells */
> +               cpul_leakage: cpul-leakage {
> +                       reg = <0x1a 0x1>;
> +               };
> +               cpub_leakage: cpub-leakage {
> +                       reg = <0x17 0x1>;
> +               };
> +               gpu_leakage: gpu-leakage {
> +                       reg = <0x18 0x1>;
> +               };
> +               center_leakage: center-leakage {
> +                       reg = <0x19 0x1>;
> +               };
> +               logic_leakage: logic-leakage {
> +                       reg = <0x1b 0x1>;
> +               };
> +               wafer_info: wafer-info {
> +                       reg = <0x1c 0x1>;
> +               };
> +       };

Other than that this looks sane to me.

-Doug

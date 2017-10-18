From: robh@kernel.org (Rob Herring)
Date: Wed, 18 Oct 2017 15:15:35 -0500
Subject: [PATCH v2 6/6] ARM: dts: imx53-tx53: Fix 'ethernet-phy@0' node
 with unit name and no reg property
In-Reply-To: <1508354991-18016-6-git-send-email-marco.franchi@nxp.com>
References: <1508354991-18016-1-git-send-email-marco.franchi@nxp.com>
 <1508354991-18016-6-git-send-email-marco.franchi@nxp.com>
Message-ID: <CAL_JsqK8xgMHyqxRKp2StQsJAVHCmWhnEkFYx3XMzj+e67+tEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 18, 2017 at 2:29 PM, Marco Franchi <marco.franchi@nxp.com> wrote:
> The following build warning is seen with W=1:
>
> Warning (unit_address_vs_reg): Node /soc/aips at 60000000/ethernet at 63fec000/ethernet-phy at 0 has a unit name, but no reg property
>
> Fix this warning by removing '@' from such node.
>
> Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
> ---
> Changes since v1:
> -rebased to imx/dt branch
>  arch/arm/boot/dts/imx53-tx53.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
> index 76e7186..5d93287 100644
> --- a/arch/arm/boot/dts/imx53-tx53.dtsi
> +++ b/arch/arm/boot/dts/imx53-tx53.dtsi
> @@ -225,7 +225,7 @@
>         mac-address = [000000000000]; /* placeholder; will be overwritten by bootloader */
>         status = "okay";
>
> -       phy0: ethernet-phy at 0 {
> +       phy0: ethernet-phy {

Is this MDIO bus? If so, then it should have an address.

>                 interrupts-extended = <&gpio2 4 IRQ_TYPE_EDGE_FALLING>;
>                 device_type = "ethernet-phy";

BTW, this should also go away.

>         };
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

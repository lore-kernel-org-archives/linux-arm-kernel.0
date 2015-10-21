From: robh+dt@kernel.org (Rob Herring)
Date: Wed, 21 Oct 2015 10:18:17 -0500
Subject: [PATCH v1 1/2] dt-bindings: Sync the dts to this document
In-Reply-To: <1445395380-5365-2-git-send-email-wxt@rock-chips.com>
References: <1445395380-5365-1-git-send-email-wxt@rock-chips.com>
 <1445395380-5365-2-git-send-email-wxt@rock-chips.com>
Message-ID: <CAL_JsqJ6ZRjZbtc7dqo-g=CzO+H_FWcRqs2gBGH2HMBBM1xU3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 20, 2015 at 9:42 PM, Caesar Wang <wxt@rock-chips.com> wrote:
> Add the OTP gpio state, we need switch the pin to gpio state
> before the TSADC controller is reset.
>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> ---
>
> Changes in v1:
>   - As the Doug comments, add the 'init' property to sync document.
>
>  Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> index ef802de..28e84f7 100644
> --- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> @@ -27,8 +27,9 @@ tsadc: tsadc at ff280000 {
>         clock-names = "tsadc", "apb_pclk";
>         resets = <&cru SRST_TSADC>;
>         reset-names = "tsadc-apb";
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&otp_out>;
> +       pinctrl-names = "init", "default";
> +       pinctrl-0 = <&otp_gpio>;
> +       pinctrl-1 = <&otp_out>;

Are these optional or required? They only appear in the example.

Rob

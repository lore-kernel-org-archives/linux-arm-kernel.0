From: robh+dt@kernel.org (Rob Herring)
Date: Fri, 1 Apr 2016 10:31:34 -0500
Subject: [PATCH 01/11] ARM: dts: exynos: Fix DTC unit name warnings in
 cros-adc-thermistors
In-Reply-To: <1459493874-2366-1-git-send-email-k.kozlowski@samsung.com>
References: <1459493874-2366-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <CAL_JsqJi0w_j2wcb8f60XKOL3MFxkHFZpoyFhT-CCno_chb9Rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 1, 2016 at 1:57 AM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> Fix following DTC warnings in cros-adc-thermistors:
> Warning (unit_address_vs_reg): Node /adc at 12D10000/ncp15wb473 at 3 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /adc at 12D10000/ncp15wb473 at 4 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /adc at 12D10000/ncp15wb473 at 5 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /adc at 12D10000/ncp15wb473 at 6 has a unit name, but no reg property
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/arm/boot/dts/cros-adc-thermistors.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/cros-adc-thermistors.dtsi b/arch/arm/boot/dts/cros-adc-thermistors.dtsi
> index acd4fe1833f2..87e676917603 100644
> --- a/arch/arm/boot/dts/cros-adc-thermistors.dtsi
> +++ b/arch/arm/boot/dts/cros-adc-thermistors.dtsi
> @@ -13,28 +13,28 @@
>  */
>
>  &adc {
> -       ncp15wb473 at 3 {
> +       ncp15wb473_3 {

Don't use underscores.

>                 compatible = "murata,ncp15wb473";
>                 pullup-uv = <1800000>;
>                 pullup-ohm = <47000>;
>                 pulldown-ohm = <0>;
>                 io-channels = <&adc 3>;

I've not looked at the full binding here, but this case may warrant
adding a reg property as an ADC channel number is what i'd consider an
addressable thing. This is also kind of strange having a phandle to
the parent node.

Rob

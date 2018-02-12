From: robh@kernel.org (Rob Herring)
Date: Mon, 12 Feb 2018 09:19:35 -0600
Subject: [PATCH v2 01/12] ARM: dts: STi: Fix bindings notation
In-Reply-To: <1518446590-16800-2-git-send-email-patrice.chotard@st.com>
References: <1518446590-16800-1-git-send-email-patrice.chotard@st.com>
 <1518446590-16800-2-git-send-email-patrice.chotard@st.com>
Message-ID: <CABGGiswMN1-CQi-guB5y5YFNLhKH3z58b_skxb_q+ZMm7+n1Nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 12, 2018 at 8:42 AM,  <patrice.chotard@st.com> wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
>
> Remove leading 0x and 0s from bindings notation
> Add missing unit-address and remove some which are useless.
>
> This allows to fix several warnings like :
>
> Warning (unit_address_vs_reg): Node XXXX has a reg or ranges property, but no unit name
> Warning (simple_bus_reg): Node XXXX simple-bus unit address format error, expected "123456"
> Warning (unit_address_vs_reg): Node XXXX has a unit name, but no reg property
>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> ---

[...]

> diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
> index a29090077fdf..53c6888d1fc0 100644
> --- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
> @@ -45,7 +45,7 @@
>         };
>
>         soc {
> -               pin-controller-sbc {
> +               pin-controller-sbc at 961f080 {

While you're here changing the node name, these all should be "pinctrl at ..."

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

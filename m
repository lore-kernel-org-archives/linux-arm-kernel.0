From: robh@kernel.org (Rob Herring)
Date: Tue, 3 May 2016 10:37:19 -0500
Subject: [PATCH] ARM: dts: imx: Remove unneeded unit-addresses
In-Reply-To: <1462283851-10820-1-git-send-email-fabio.estevam@nxp.com>
References: <1462283851-10820-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <CAL_JsqKv_7ufFG7DSkxqp9QOEjLEDVofyYMoudtJjqBA78ahcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 3, 2016 at 8:57 AM, Fabio Estevam <fabio.estevam@nxp.com> wrote:
> Building with W=1 option leads to several warnings like:
>
> Warning (unit_address_vs_reg): Node /soc/aips-bus at 02000000/anatop at 020c8000/regulator-1p1 at 110 has a unit name, but no reg property
>
> Fix them by removing the unneeded unit-addresses.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  arch/arm/boot/dts/imx6sl.dtsi | 12 ++++++------
>  arch/arm/boot/dts/imx6sx.dtsi | 12 ++++++------
>  arch/arm/boot/dts/imx6ul.dtsi |  6 +++---
>  arch/arm/boot/dts/imx7d.dtsi  |  2 +-
>  4 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index d12b250..224c0d0 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -461,7 +461,7 @@
>                                              <0 54 IRQ_TYPE_LEVEL_HIGH>,
>                                              <0 127 IRQ_TYPE_LEVEL_HIGH>;
>
> -                               regulator-1p1 at 110 {
> +                               regulator-1p1 {

Presumably these are register offsets which could be useful to have
even if the Linux driver doesn't use them. But either way is fine with
me.

Rob

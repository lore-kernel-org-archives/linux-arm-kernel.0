From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 10 Dec 2017 13:20:21 -0200
Subject: [PATCH v1 4/6] ARM: dts: imx7s: add node and supplies for vdd1p2
In-Reply-To: <20171205222707.11302-5-tyler@opensourcefoundries.com>
References: <20171205222707.11302-1-tyler@opensourcefoundries.com>
 <20171205222707.11302-5-tyler@opensourcefoundries.com>
Message-ID: <CAOMZO5DDFA+8J9tB_jPLqp5fe7RdxV6nUznSh6rDyhMB1c=YZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 5, 2017 at 8:27 PM,  <tyler@opensourcefoundries.com> wrote:
> From: Tyler Baker <tyler@opensourcefoundries.com>
>
> Add the regulator nodes and supplies for vdd1p2. This regulator is
> used to power the GPC and USB HSIC PHY.
>
> Signed-off-by: Tyler Baker <tyler@opensourcefoundries.com>
> ---
>  arch/arm/boot/dts/imx7s.dtsi | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
> index 7b85659..151ab34 100644
> --- a/arch/arm/boot/dts/imx7s.dtsi
> +++ b/arch/arm/boot/dts/imx7s.dtsi
> @@ -522,6 +522,20 @@
>                                         anatop-max-voltage = <1200000>;
>                                         anatop-enable-bit = <0>;
>                                 };
> +
> +                               reg_1p2: regulator-vdd1p2 at 220 {

Using a unit address without a corresponding reg would give you a
warning with W=1.

Please see the patch I sent with Subject:
ARM: dts: imx7s: Add unit address and reg for the anatop nodes

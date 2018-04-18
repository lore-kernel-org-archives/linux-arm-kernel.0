From: stefan@agner.ch (Stefan Agner)
Date: Wed, 18 Apr 2018 17:35:49 +0200
Subject: [PATCH 2/2] ARM: dts: imx6ull: add operating points
In-Reply-To: <20180418145230.10249-2-sebastien.szymanski@armadeus.com>
References: <20180418145230.10249-1-sebastien.szymanski@armadeus.com>
 <20180418145230.10249-2-sebastien.szymanski@armadeus.com>
Message-ID: <c5d92c4e36973e3e18980d410e11ec4f@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.04.2018 16:52, S?bastien Szymanski wrote:
> i.MX6ULL has different operating ranges than i.MX6UL so add the
> operating points for the i.MX6ULL. A 25mV offset is added to the minimum
> allowed values like for the i.MX6UL.

Hi S?bastien,

Last time I checked there was a DC controller missing for the EVK, so I
think it was not possible to go to the highest operating points yet.
Have you tested this on the EVK?

--
Stefan

> 
> Signed-off-by: S?bastien Szymanski <sebastien.szymanski@armadeus.com>
> ---
>  arch/arm/boot/dts/imx6ull.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6ull.dtsi b/arch/arm/boot/dts/imx6ull.dtsi
> index 571ddd71cdba..7e6273be0291 100644
> --- a/arch/arm/boot/dts/imx6ull.dtsi
> +++ b/arch/arm/boot/dts/imx6ull.dtsi
> @@ -46,6 +46,25 @@
>  /* Delete UART8 in AIPS-1 (i.MX6UL specific) */
>  /delete-node/ &uart8;
>  
> +&cpu0 {
> +	operating-points = <
> +		/* kHz	uV */
> +		900000	1275000
> +		792000	1225000
> +		528000	1175000
> +		396000	1025000
> +		198000	950000
> +	>;
> +	fsl,soc-operating-points = <
> +		/* KHz	uV */
> +		900000	1400000
> +		792000	1350000
> +		528000	1175000
> +		396000	1175000
> +		198000	1175000
> +	>;
> +};
> +
>  / {
>  	soc {
>  		aips3: aips-bus at 2200000 {

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 20 Jun 2017 10:57:48 +0200
Subject: [PATCH 1/3] ARM: dts: sunxi: add R_LRADC support for A83T
In-Reply-To: <20170618130018.10684-1-techping.chan@gmail.com>
References: <20170618130018.10684-1-techping.chan@gmail.com>
Message-ID: <20170620085748.apv3wlehyllecb5q@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 18, 2017 at 09:00:16PM +0800, Ziping Chen wrote:
> From: Ziping Chen <techping.chan@gmail.com>
> 
> The Allwinner A83T's R_LRADC is similiar with the
> Allwinner A10's LRADC, they can use the same driver.

There's a typo in similar above.

> Add support for it.
> 
> Signed-off-by: Ziping Chen <techping.chan@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-a83t.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> index 8923ba625b76..ecc75bf6780e 100644
> --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> @@ -301,5 +301,12 @@
>  			interrupt-controller;
>  			#interrupt-cells = <3>;
>  		};
> +
> +		r_lradc: lradc at 01f03c00 {
> +			compatible = "allwinner,sun4i-a10-lradc-keys";

Could you add an A83T specific compatible here?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170620/147d35f7/attachment.sig>

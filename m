From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 Mar 2015 16:17:04 -0700
Subject: [PATCH 2/2] sunxi: a20-LIME2 define board specific operating
 points
In-Reply-To: <55143D0D.6030104@gmail.com>
References: <55143D0D.6030104@gmail.com>
Message-ID: <20150330231704.GB23664@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 05:08:29PM +0000, Iain Paton wrote:
> these settings override the inappropriate ones in the dtsi with the
> manufacturers provided settings from their 3.4.x fex file for this board

Inappropriate how?

> 
> Signed-off-by: Iain Paton <ipaton0@gmail.com>
> ---
>  arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> index 704df28..f74f81e 100644
> --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> @@ -83,6 +83,25 @@
>  	status = "okay";
>  };
>  
> +&cpu0 {
> +	cpu-supply = <&vdd_cpu>;
> +	clocks = <&cpu>;
> +	clock-latency = <244144>; /* 8 32k periods */

This is already defined in the DTSI

> +	operating-points = <
> +		/* kHz    uV */
> +		1008000 1450000
> +		912000  1425000
> +		864000  1350000
> +		720000  1250000
> +		528000  1150000
> +		312000  1100000
> +		144000  1050000
> +		>;

I'd rather have a better common operating points set and change that
to accomodate all boards, rather than duplicating that information
everywhere.

> +	#cooling-cells = <2>;

This is also defined in the DTSI.

> +	cooling-min-level = <0>;
> +	cooling-max-level = <6>;
> +};
> +
>  &ehci0 {
>  	status = "okay";
>  };
> -- 
> 2.1.3
> 

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150330/a0160020/attachment.sig>

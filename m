From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 06 May 2015 15:14:22 +0200
Subject: [PATCH v2 2/3] ARM: dove: Add clock-names to CuBox Si5351 clk
 generator
In-Reply-To: <1430773456-15203-3-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1430773456-15203-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1430773456-15203-3-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <554A13AE.6000904@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On 04/05/2015 23:04, Sebastian Hesselbarth wrote:
> Si5351 clock generator on CuBox uses XTAL as clock reference, name the
> clock phandle accordingly.

as soon as the binding will be accepted (in patch 1), I will apply it
on mvebu/fixes.

Thanks,

Gregory


> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Jean-Francois Moine <moinejf@free.fr>
> Cc: Michael Welling <mwelling@ieee.org>
> Cc: Russell King <rmk+linux@arm.linux.org.uk>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: linux-clk at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/boot/dts/dove-cubox.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/dove-cubox.dts b/arch/arm/boot/dts/dove-cubox.dts
> index aae7efc09b0b..e6fa251e17b9 100644
> --- a/arch/arm/boot/dts/dove-cubox.dts
> +++ b/arch/arm/boot/dts/dove-cubox.dts
> @@ -87,6 +87,7 @@
>  
>  		/* connect xtal input to 25MHz reference */
>  		clocks = <&ref25>;
> +		clock-names = "xtal";
>  
>  		/* connect xtal input as source of pll0 and pll1 */
>  		silabs,pll-source = <0 0>, <1 0>;
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

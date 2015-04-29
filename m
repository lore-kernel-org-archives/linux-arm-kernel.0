From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Wed, 29 Apr 2015 21:12:28 +0200
Subject: [PATCH v2] ARM: vexpress: Add unified-cache Device Tree property
In-Reply-To: <1426671298-2012-1-git-send-email-r.schwebel@pengutronix.de>
References: <5509437E.6060806@arm.com>
 <1426671298-2012-1-git-send-email-r.schwebel@pengutronix.de>
Message-ID: <20150429191228.GO15254@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Liviu,

On Wed, Mar 18, 2015 at 10:34:58AM +0100, Robert Schwebel wrote:
> Without this property, we get this boot warning:
> 
> "L2C: device tree omits to specify unified cache"
> 
> Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm/boot/dts/vexpress-v2p-ca9.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> Changes since v1:
>  * fix typo in patch description
> 
> diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
> index 23662b5..a411274 100644
> --- a/arch/arm/boot/dts/vexpress-v2p-ca9.dts
> +++ b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
> @@ -170,6 +170,7 @@
>  		compatible = "arm,pl310-cache";
>  		reg = <0x1e00a000 0x1000>;
>  		interrupts = <0 43 4>;
> +		cache-unified;
>  		cache-level = <2>;
>  		arm,data-latency = <1 1 1>;
>  		arm,tag-latency = <1 1 1>;
> -- 
> 2.1.4

Gentle ping, this patch didn't make it into 4.1-rc1.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

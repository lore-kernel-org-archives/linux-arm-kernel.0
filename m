From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 30 Aug 2017 16:40:54 +0200
Subject: [PATCH] ARM: dts: sun7i: Enable power supplies on
 A20-OLinuxIno-Micro
In-Reply-To: <20170829170810.1302-1-harald@ccbib.org>
References: <20170829170810.1302-1-harald@ccbib.org>
Message-ID: <20170830144054.36m6wfilwdztcfij@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 29, 2017 at 07:08:10PM +0200, Harald Geyer wrote:
> The axp209.dtsi defines nodes for ac, usb and battery supplies for a
> while now. This patch enables these nodes for the A20-Olinuxino-Micro,
> which has connectors for all three of them.
> 
> The patch was run-tested against linux-next-20170825.
> 
> Signed-off-by: Harald Geyer <harald@ccbib.org>
> ---
> Note: I guess the same change is good for the olinuxino lime boards too.
> However I don't have such boards to test, so I don't formally submit a
> patch for them.
> 
>  arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> index 0b7403e..64c993a 100644
> --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> @@ -256,6 +256,18 @@
>  
>  #include "axp209.dtsi"
>  
> +&ac_power_supply {
> +	status = "okay";
> +};
> +
> +&battery_power_supply {
> +	status = "okay";
> +};
> +
> +&usb_power_supply {
> +	status = "okay";
> +};
> +

We usually try to sort the nodes per alphabetical order (even though
it's a bit difficult for the battery and AC-IN power supplies).

I've moved the usb_power_supply node a bit below, where it belongs,
and it will be part of 4.15.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170830/c01f4c47/attachment.sig>

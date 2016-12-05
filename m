From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 5 Dec 2016 09:09:32 +0100
Subject: [PATCH 1/2] ARM: dts: sun8i: Specify memblock for Nano Pi M1
In-Reply-To: <20161205020032.26586-1-woogyom.kim@gmail.com>
References: <20161205020032.26586-1-woogyom.kim@gmail.com>
Message-ID: <20161205080932.xaqyl2httgxgso67@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2016 at 11:00:31AM +0900, Milo Kim wrote:
> The board has DDR3 512MB. This patch helps scanning the memory and
> adding memblock through the DT.
> 
> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts
> index ec63d10..be3668f 100644
> --- a/arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts
> @@ -45,6 +45,11 @@
>  / {
>  	model = "FriendlyArm NanoPi M1";
>  	compatible = "friendlyarm,nanopi-m1", "allwinner,sun8i-h3";
> +
> +	memory at 40000000 {
> +		device_type = "memory";
> +		reg = <0x40000000 0x20000000>;
> +	};

U-boot will fill that up, so there's no need to put it there.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161205/a219cc4b/attachment.sig>

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 14 Dec 2017 10:54:30 +0100
Subject: [PATCH 2/2] arm: dts: sun8i: a83t: Add an unit address to the
 memory node
In-Reply-To: <20171213193715.31039-2-clabbe.montjoie@gmail.com>
References: <20171213193715.31039-1-clabbe.montjoie@gmail.com>
 <20171213193715.31039-2-clabbe.montjoie@gmail.com>
Message-ID: <20171214095430.uw5zaf6h3u5hgkrv@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 13, 2017 at 08:37:15PM +0100, Corentin Labbe wrote:
> This will fix the following warning:
> Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-a83t.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> index 715719f9ea2e..bddde0141f24 100644
> --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> @@ -160,7 +160,7 @@
>  		};
>  	};
>  
> -	memory {
> +	memory at 40000000 {
>  		reg = <0x40000000 0x80000000>;
>  		device_type = "memory";
>  	};

Can't we just get rid of the memory node entirely? U-Boot will add it
for us anyway.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171214/c81f0f97/attachment.sig>

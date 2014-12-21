From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 21 Dec 2014 13:32:11 +0100
Subject: [PATCH] ARM: dts: use all remaining MTD space foor rootfs of
 Iomega ix2-200
In-Reply-To: <1418586819-29680-1-git-send-email-richard.kunze@web.de>
References: <20141210203740.GD23599@lunn.ch>
 <1418586819-29680-1-git-send-email-richard.kunze@web.de>
Message-ID: <20141221123211.GA29218@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 14, 2014 at 08:53:39PM +0100, Richard Kunze wrote:
> The original MTD partition layout for the Iomega ix2-200 leaves most of the 
> available space unused. This patch changes the layout to use all remaining
> MTD space after the partitions for u-boot/u-boot-env and the kernel uimage
> as a "rootfs" partition.
> 
> Signed-off-by: Richard Kunze <richard.kunze@web.de>

Hi Richard

Applied to mvebu/dt.

	Andrew

> ---
>  arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts b/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
> index 7aeddcd..8474bff 100644
> --- a/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
> +++ b/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
> @@ -196,8 +196,8 @@
>  	};
>  
>  	partition at 400000 {
> -		label = "uInitrd";
> -		reg = <0x540000 0x1000000>;
> +		label = "rootfs";
> +		reg = <0x400000 0x1C00000>;
>  	};
>  };
>  
> -- 
> 1.9.1
> 

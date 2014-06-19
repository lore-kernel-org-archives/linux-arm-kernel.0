From: voice.shen@atmel.com (Bo Shen)
Date: Thu, 19 Jun 2014 15:12:09 +0800
Subject: [PATCH v2 7/7] ARM: at91/dt: enable the LCD panel on sama5d3xek
 boards
In-Reply-To: <1402329860-27520-8-git-send-email-boris.brezillon@free-electrons.com>
References: <1402329860-27520-1-git-send-email-boris.brezillon@free-electrons.com>
 <1402329860-27520-8-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <53A28D49.2040400@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On 06/10/2014 12:04 AM, Boris BREZILLON wrote:
> diff --git a/arch/arm/boot/dts/sama5d33ek.dts b/arch/arm/boot/dts/sama5d33ek.dts
> index cbd6a3f..f2ab41d 100644
> --- a/arch/arm/boot/dts/sama5d33ek.dts
> +++ b/arch/arm/boot/dts/sama5d33ek.dts
> @@ -36,9 +36,33 @@
>   			macb0: ethernet at f0028000 {
>   				status = "okay";
>   			};
> +
> +			hlcdc: hlcdc at f0030000 {
> +				status = "okay";
> +
> +				hlcdc-display-controller {
> +					atmel,panel = <&panel 3 0>;

One question here, in the driver code, it will configuration the frame 
buffer mode depends on this parameter.
So, my question is if the framebuffer bits per pixel is different with 
output bits per pixel, how to setting it?

For example, frame buffer use 16 bits/pixel, while output 24 bits/pixel.

> +				};
> +			};
>   		};
>   	};
>

Best Regards,
Bo Shen

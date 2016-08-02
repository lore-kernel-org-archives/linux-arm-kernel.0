From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 2 Aug 2016 11:19:00 -0600
Subject: [PATCH V2 RFC 6/6] ARM: dts: bcm2835: Add Raspberry Pi Zero
In-Reply-To: <1469559213-16160-7-git-send-email-stefan.wahren@i2se.com>
References: <1469559213-16160-1-git-send-email-stefan.wahren@i2se.com>
 <1469559213-16160-7-git-send-email-stefan.wahren@i2se.com>
Message-ID: <597f3289-91c3-7c19-8992-d6b386d50c02@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/26/2016 12:53 PM, Stefan Wahren wrote:
> The Raspberry Pi Zero is a minified version of model A+. It's
> notable there is no PWR LED and the ACT LED is inverted.

Patches 3-6,
Acked-by: Stephen Warren <swarren@nvidia.com>

> diff --git a/arch/arm/boot/dts/bcm2835-rpi-zero.dts b/arch/arm/boot/dts/bcm2835-rpi-zero.dts

The following comment format is a bit strange, but I'm not sure there's 
anything objectively better...

> +&usb {
> +	dr_mode = "host";
> +	h-rx-fifo-size = <774>;
> +	h-np-tx-fifo-size = <256>;
> +	h-tx-fifo-size = <512>;
> +/*
> + * Settings for otg
> + *
> +	dr_mode = "otg";
> +	h-rx-fifo-size = <774>;
> +	h-np-tx-fifo-size = <32>;
> +	h-tx-fifo-size = <0>;
> +	g-np-tx-fifo-size = <16>;
> +	g-rx-fifo-size = <256>;
> +	g-tx-fifo-size = <256 128 128 64 64 64 32>;
> + *
> + * Settings for peripheral
> + *
> +	dr_mode = "peripheral";
> +	h-rx-fifo-size = <774>;
> +	h-np-tx-fifo-size = <0>;
> +	h-tx-fifo-size = <0>;
> +	g-np-tx-fifo-size = <16>;
> +	g-rx-fifo-size = <256>;
> +	g-tx-fifo-size = <256 128 128 64 64 64 32>;
> + */
> +};

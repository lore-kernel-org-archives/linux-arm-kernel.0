From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 7 Mar 2016 23:00:32 -0700
Subject: [PATCH 3/3] ARM: bcm2835: Add VC4 to the device tree.
In-Reply-To: <1457123528-13482-4-git-send-email-eric@anholt.net>
References: <1457123528-13482-1-git-send-email-eric@anholt.net>
 <1457123528-13482-4-git-send-email-eric@anholt.net>
Message-ID: <56DE6A80.1060707@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2016 01:32 PM, Eric Anholt wrote:
> VC4 is the GPU (display and 3D) present on the 283x.

> diff --git a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts

> +&hdmi {
> +	hpd-gpios = <&gpio 46 GPIO_ACTIVE_LOW>;
> +};

Isn't that the same everywhere? If so, adding it to bcm2835-rpi.dtsi 
seems like a better idea; it'd avoid duplicating it everywhere.

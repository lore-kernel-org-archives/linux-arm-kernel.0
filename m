From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 23 Apr 2015 22:36:05 -0600
Subject: [PATCH 4/9] ARM: Update the device trees for 2836.
In-Reply-To: <1429639796-2169-5-git-send-email-eric@anholt.net>
References: <1429639796-2169-1-git-send-email-eric@anholt.net>
 <1429639796-2169-5-git-send-email-eric@anholt.net>
Message-ID: <5539C835.1000109@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2015 12:09 PM, Eric Anholt wrote:
> The bus address for peripherals comes from the platform.h diff between
> 2708 and 2709, and the CPU's DT definition is based on the 2709 DT.

I would suggest squashing this with the previous commit. I was puzzled
why patch 3 added bcm2836-rpi.dtsi, yet in that patch,
bcm2836-rpi-2-b.dts included bcm2835-rpi.dtsi instead.

git should still show that patch as a copy+edit assuming the files are
similar enough.

> diff --git a/arch/arm/boot/dts/bcm2836.dtsi b/arch/arm/boot/dts/bcm2836.dtsi

> +	__overrides__ {
> +		arm_freq = <&v7_cpu0>, "clock-frequency:0";
> +	};
>  };

We don't have any DT override/overlay/... support in the bcm2835 files
yet. Does it make sense not to only add it to bcm2836 files when we add
the equivalent everywhere?

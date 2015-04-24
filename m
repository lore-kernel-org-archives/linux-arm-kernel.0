From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 23 Apr 2015 22:28:37 -0600
Subject: [PATCH 2/9] ARM: BCM2835: Split peripheral definitions off to
 a common include.
In-Reply-To: <1429639796-2169-3-git-send-email-eric@anholt.net>
References: <1429639796-2169-1-git-send-email-eric@anholt.net>
 <1429639796-2169-3-git-send-email-eric@anholt.net>
Message-ID: <5539C675.7020306@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2015 12:09 PM, Eric Anholt wrote:
> The 2836 dts will inherit all of this, because it shares the same
> peripherals as 2835.

> diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi

>  #include <dt-bindings/pinctrl/bcm2835.h>
>  #include "skeleton.dtsi"
> +#include "bcm283x-common.dtsi"

skeleton is included there.

> diff --git a/arch/arm/boot/dts/bcm283x-common.dtsi b/arch/arm/boot/dts/bcm283x-common.dtsi

> +/include/ "skeleton.dtsi"

So there's no need to include it here.

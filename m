From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 14 Aug 2015 22:54:00 -0600
Subject: [PATCH 7/7] ARM: bcm2835: Add VC4 to the device tree.
In-Reply-To: <1439427380-2436-8-git-send-email-eric@anholt.net>
References: <1439427380-2436-1-git-send-email-eric@anholt.net>
 <1439427380-2436-8-git-send-email-eric@anholt.net>
Message-ID: <55CEC5E8.6090203@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/2015 06:56 PM, Eric Anholt wrote:
> Signed-off-by: Eric Anholt <eric@anholt.net>

Patch description?


> diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi

>  		arm-pmu {
>  			compatible = "arm,arm1176-pmu";
>  		};
> +
> +		hdmi: brcm,vc4-hdmi at 7e902000 {

It'd be nice to keep all the DT nodes with a reg property together, and
sorted in reg order.

As before, I think any DT node for a HW block that may-or-may-not-be
used based on board connectivity/features should be disabled in the SoC
.dtsi file, and enabled in the board's DT file if the feature is useful
for that board.

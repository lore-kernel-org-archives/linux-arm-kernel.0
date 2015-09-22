From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 21 Sep 2015 19:19:47 -0700
Subject: [PATCH 3/3] ARM: bcm2835: Add the auxiliary clocks to the device
 tree.
In-Reply-To: <1441923750-19404-4-git-send-email-eric@anholt.net>
References: <1441923750-19404-1-git-send-email-eric@anholt.net>
 <1441923750-19404-4-git-send-email-eric@anholt.net>
Message-ID: <5600BAC3.70506@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/2015 03:22 PM, Eric Anholt wrote:
> These will be used for enabling UART1, SPI1, and SPI2.

> diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi

> +		aux_clocks: aux-clocks at 0x7e215004 {
> +			compatible = "brcm,bcm2835-aux-clock";
> +			#clock-cells = <1>;
> +			reg = <0x7e215004 0x4>;

Actually, I take back the ack on this patch. This HW module has two
registers. The reg property should include both of those registers so
that if SW needs to start using the other register at some time in the
future, the entire set of registers is already represented in DT.

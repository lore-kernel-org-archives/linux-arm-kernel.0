From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 14 Aug 2015 22:13:31 -0600
Subject: [PATCH v5 3/3] ARM: bcm2835: Add DT for the firmware clocks
 driver.
In-Reply-To: <1439507142-2965-4-git-send-email-eric@anholt.net>
References: <1439507142-2965-1-git-send-email-eric@anholt.net>
 <1439507142-2965-4-git-send-email-eric@anholt.net>
Message-ID: <55CEBC6B.9070001@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/13/2015 05:05 PM, Eric Anholt wrote:
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Acked-by: Lee Jones <lee@kernel.org>

A patch description might be nice, although admittedly the subject seems
clear enough.

> diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi

> +		firmware_clocks: firmware-clocks {
> +			compatible = "raspberrypi,bcm2835-firmware-clocks";
> +			#clock-cells = <1>;
> +			raspberrypi,firmware = <&firmware>;
> +		};

No need to resend for this, but just a background note: DT node names
usually contain a device type not a device identity, so "clocks" not
"firmware-clocks" would be typical.

This patch,
Acked-by: Stephen Warren <swarren@wwwdotorg.org>

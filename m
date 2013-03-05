From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 05 Mar 2013 11:20:32 -0700
Subject: [PATCH] ARM: bcm281xx: Add L2 cache enable code
In-Reply-To: <1362451632-18806-1-git-send-email-csd@broadcom.com>
References: <1362451632-18806-1-git-send-email-csd@broadcom.com>
Message-ID: <51363770.5060201@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2013 07:47 PM, Christian Daudt wrote:
> - Adds a module to provide calls into secure monitor mode
> - Uses this module to make secure monitor calls to enable L2 cache.

> diff --git a/Documentation/devicetree/bindings/misc/smc.txt b/Documentation/devicetree/bindings/misc/smc.txt

> +Example:
> +	smc at 0x3404c000 {
> +		compatible = "bcm,kona-smc";

Both here in this example, and ...

> diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi

> +	smc at 0x3404c000 {
> +		compatible = "bcm,kona-smc";

Here in the actual .dts file, you should include the specific ID of the
SoC too, so that if there are Soc-specific bugs, the compatible property
that's required to determine this is present from the start. In other words,

compatible = "bcm,bcm11351-smc", "bcm,kona-smc";

(which SoC ID you use in the example is arbitrary, but it may as well
match the .dts file you're editing in the patch).

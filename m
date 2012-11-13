From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 12 Nov 2012 21:45:30 -0700
Subject: [PATCH v2] Add support for generic BCM SoC chipsets
In-Reply-To: <1352645834-10173-1-git-send-email-csd@broadcom.com>
References: <1352645834-10173-1-git-send-email-csd@broadcom.com>
Message-ID: <50A1D06A.2010000@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/2012 07:57 AM, Christian Daudt wrote:
> In order to start upstreaming Broadcom SoC support, create
> a starting hierarchy, arch and dts files.
> The first support SoC family that is planned is the
> BCM281XX (BCM28145/28150/28155/28160) family of dual A9 mobile SoC cores
> This code is just the skeleton code for get the machine upstreamed. It
> has been made MULTIPLATFORM compatible.
> Next steps

> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile

> +dtb-$(CONFIG_ARCH_BCM) += capri-brt.dtb

I think that needs to be renamed too.

> diff --git a/arch/arm/boot/dts/bcm281xx.dtsi b/arch/arm/boot/dts/bcm281xx.dtsi

> +/ {
> +	model = "BCM281xx SoC";
> +	compatible = "bcm,bcm281xx";

I think this should list the specific SoC rather than (or perhaps in
addition to) a wildcard.

Out of curiosity though, what kind of differences exist between the
various SoCs this wildcard is intended to cover;
bcm28145/28150/28155/28160? Are they simply package/pinout differences,
or something more involved?

> +	uart at 3e000000 {
> +		compatible = "snps,dw-apb-uart";

As I mentioned in my earlier reply, I think this should indicate the
specific instantiation of the IP too; something like
bcm,bcm28160-dw-apb-uart.

> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig

> +	help
> +	  This enables support for system based on Broadcom SoCs.
> +          It currently supports BCM28145/28150/28155/28160 chips.

The indentation looks a little odd there.

> diff --git a/arch/arm/mach-bcm/board_bcm.c b/arch/arm/mach-bcm/board_bcm.c

> +static const char * const capri_dt_compat[] = { "bcm,capri", NULL, };

I think that needs to be updated too.

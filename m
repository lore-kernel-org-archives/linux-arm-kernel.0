From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 13 Oct 2014 11:18:43 +0100
Subject: [PATCH v4 03/10] ARM: dts: add DT for Alphascale ASM9260 SoC
In-Reply-To: <1413141561-8916-4-git-send-email-linux@rempel-privat.de>
References: <1413141561-8916-1-git-send-email-linux@rempel-privat.de>
 <1413141561-8916-4-git-send-email-linux@rempel-privat.de>
Message-ID: <20141013101843.GC14739@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 12, 2014 at 08:19:14PM +0100, Oleksij Rempel wrote:
> for now it is wary basic SoC description with most important IPs needed
> to make this device work
> 
> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
> ---
>  arch/arm/boot/dts/Makefile                      |   2 +
>  arch/arm/boot/dts/alphascale-asm9260-devkit.dts |  21 ++++
>  arch/arm/boot/dts/alphascale-asm9260.dtsi       | 134 ++++++++++++++++++++++++
>  include/dt-bindings/clock/alphascale,asm9260.h  |  97 +++++++++++++++++
>  4 files changed, 254 insertions(+)
>  create mode 100644 arch/arm/boot/dts/alphascale-asm9260-devkit.dts
>  create mode 100644 arch/arm/boot/dts/alphascale-asm9260.dtsi
>  create mode 100644 include/dt-bindings/clock/alphascale,asm9260.h

This last file should go with the clock controller driver/binding, which
should come before this patch.

[...]

> +	soc {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "simple-bus";
> +                ranges;

There seems to be odd whitespace before the ranges property.

Thanks,
Mark.

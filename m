From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 28 Aug 2012 13:23:44 -0400
Subject: [RFC PATCH] ARM: initial DTS support for km_kirkwood
In-Reply-To: <1346154976-16916-1-git-send-email-valentin.longchamp@keymile.com>
References: <1346154976-16916-1-git-send-email-valentin.longchamp@keymile.com>
Message-ID: <20120828172344.GE19437@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2012 at 01:56:16PM +0200, Valentin Longchamp wrote:
> This is a first attempt to support the km_kirkwood reference design with
> a device tree. This km_kirkwood design is present in many Keymile
> products. It is based on the Marvell Bobcat SOC which integrates a
> Kirkwood CPU next to a big L2 Ethernet Switch. The Kirkwood in the SOC
> is very similar to the "normal" one, but there are a few differences.
> 
> This initial support is minimal: the kernel can boot with network
> (ge0), serial port and NAND functional.
> 
> Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
> Cc: Holger Brunck <holger.brunck@keymile.com>
> ---
>  arch/arm/boot/dts/kirkwood-km_kirkwood.dts |   29 +++++++++++
>  arch/arm/mach-kirkwood/Kconfig             |    7 +++
>  arch/arm/mach-kirkwood/Makefile            |    1 +
>  arch/arm/mach-kirkwood/Makefile.boot       |    1 +
>  arch/arm/mach-kirkwood/board-dt.c          |    4 ++
>  arch/arm/mach-kirkwood/board-km_kirkwood.c |   75 ++++++++++++++++++++++++++++
>  arch/arm/mach-kirkwood/common.h            |    6 ++
>  7 files changed, 123 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/kirkwood-km_kirkwood.dts
>  create mode 100644 arch/arm/mach-kirkwood/board-km_kirkwood.c
> 
> diff --git a/arch/arm/boot/dts/kirkwood-km_kirkwood.dts b/arch/arm/boot/dts/kirkwood-km_kirkwood.dts
> new file mode 100644
> index 0000000..60118d5
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-km_kirkwood.dts
> @@ -0,0 +1,29 @@
> +/dts-v1/;
> +
> +/include/ "kirkwood.dtsi"
> +
> +/ {
> +	model = "Keymile Kirkwood Reference Design";
> +	compatible = "keymile,km_kirkwood", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x08000000>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200n8 earlyprintk";
> +	};
> +
> +	ocp at f1000000 {
> +		serial at 12000 {
> +			clock-frequency = <200000000>;
> +			status = "ok";
> +		};
> +
> +		nand at 3000000 {
> +			status = "ok";
> +			chip-delay = <25>;
> +		};

Is there a partition layout for this board?

thx,

Jason.

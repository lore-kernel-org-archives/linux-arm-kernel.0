From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 26 Oct 2016 11:33:55 +0100
Subject: [PATCH 3/6] arm64: dts: ls1043a: update MSI and PCIe node
In-Reply-To: <1477398945-22774-3-git-send-email-Minghuan.Lian@nxp.com>
References: <1477398945-22774-1-git-send-email-Minghuan.Lian@nxp.com>
 <1477398945-22774-3-git-send-email-Minghuan.Lian@nxp.com>
Message-ID: <20161026103339.GD19965@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 25, 2016 at 08:35:42PM +0800, Minghuan Lian wrote:
> 3. The rev1.1 of LS1043a moves PCIe INTB/C/D interrupts to MSI controller.

[...]

> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> index 41e5dc1..5295bb9 100644

> -			interrupt-map = <0000 0 0 1 &gic 0 110 0x4>,
> -					<0000 0 0 2 &gic 0 111 0x4>,
> -					<0000 0 0 3 &gic 0 112 0x4>,
> -					<0000 0 0 4 &gic 0 113 0x4>;
> +			interrupt-map = <0000 0 0 1 &gic 0 110 0x4>;

[...]

> -			interrupt-map = <0000 0 0 1 &gic 0 120  0x4>,
> -					<0000 0 0 2 &gic 0 121 0x4>,
> -					<0000 0 0 3 &gic 0 122 0x4>,
> -					<0000 0 0 4 &gic 0 123 0x4>;
> +			interrupt-map = <0000 0 0 1 &gic 0 120  0x4>;
>  		};

[...]

> -			interrupt-map = <0000 0 0 1 &gic 0 154 0x4>,
> -					<0000 0 0 2 &gic 0 155 0x4>,
> -					<0000 0 0 3 &gic 0 156 0x4>,
> -					<0000 0 0 4 &gic 0 157 0x4>;
> +			interrupt-map = <0000 0 0 1 &gic 0 154 0x4>;

Per the description above, this breaks revisions prior to 1.1.

Please, split the rev 1.1 changes into a new DTS. Share the common parts
in a common dtsi.

Thanks,
Mark.

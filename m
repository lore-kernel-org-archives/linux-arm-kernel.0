From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 13 Dec 2016 15:26:55 +0530
Subject: [PATCH 1/2] ARM: dts: dra7-evm: Remove pinmux configurations for
 erratum i869
In-Reply-To: <b80e3cbc8a377abdb40ab11de78ce0b3fb67596f.1480411308.git.nsekhar@ti.com>
References: <cover.1480411308.git.nsekhar@ti.com>
 <b80e3cbc8a377abdb40ab11de78ce0b3fb67596f.1480411308.git.nsekhar@ti.com>
Message-ID: <13b4ce8b-4a3c-d066-e897-28eb4d511d76@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 November 2016 02:54 PM, Sekhar Nori wrote:

> A side-effect of this patch is that NAND support is removed. NAND
> pins clash with VOUT3 on DRA7-EVM. U-Boot selects VOUT3 over NAND
> as per TI EVM application needs.

I claimed this ..

>  &gpmc {
>  	status = "okay";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&nand_flash_x16>;
>  	ranges = <0 0 0x08000000 0x01000000>;	/* minimum GPMC partition = 16MB */
>  	nand at 0,0 {
>  		compatible = "ti,omap2-nand";

.. but forgot to keep the gpmc node disabled. I will fix this and send a
v2. dra72-evm-common.dtsi needs a similar patch. Will include that in v2
as well.

Thanks,
Sekhar

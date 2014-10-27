From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 27 Oct 2014 20:07:22 +0100
Subject: [PATCH V2] arm64: amd-seattle: Adding device tree for AMD Seattle
 platform
In-Reply-To: <1414436065-7717-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1414436065-7717-1-git-send-email-suravee.suthikulpanit@amd.com>
Message-ID: <2202046.Qx9l5PJfzL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 27 October 2014 13:54:25 suravee.suthikulpanit at amd.com wrote:
> +       sata0: sata at 00300000 {
> +               compatible = "snps,spear-ahci";
> +               reg = <0 0x300000 0 0x800>;
> +               interrupts = <0 355 4>;
> +               clocks = <&sataclk_333mhz>;
> +               clock-names = "apb_pclk";
> +               dma-coherent;
> +       };

Please use "snps,dwc-ahci" as the compatible string for a designware
ahci controller, not "snps,spear-ahci", which refers to the implementation
of that in the ST microelectronics SPEAr consumer SoC.

It would be good to also add a string that is specific for your SoC if
we ever need to identify it directly.

	Arnd

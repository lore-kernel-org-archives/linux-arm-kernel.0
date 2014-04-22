From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 22 Apr 2014 18:28:02 +0200
Subject: [PATCH 3/6] ARM: berlin: add the AHCI node for the BG2Q
In-Reply-To: <1398181105-19714-4-git-send-email-antoine.tenart@free-electrons.com>
References: <1398181105-19714-1-git-send-email-antoine.tenart@free-electrons.com>
 <1398181105-19714-4-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20140422182802.447c2912@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Antoine T?nart,

On Tue, 22 Apr 2014 17:38:22 +0200, Antoine T?nart wrote:
> The BG2Q has an AHCI SATA controller. Add the corresponding node
> in its device tree.

I believe the commit log should explain why an apparently unrelated
generic-regs@ node gets added in this commit.

Thanks!

Thomas

> diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
> index 07452a7483fa..8e58aae73365 100644
> --- a/arch/arm/boot/dts/berlin2q.dtsi
> +++ b/arch/arm/boot/dts/berlin2q.dtsi
> @@ -183,6 +183,18 @@
>  			};
>  		};
>  
> +		ahci: sata at e90000 {
> +			compatible = "marvell,berlin-ahci";
> +			reg = <0xe90000 0x10000>;
> +			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disable";
> +		};
> +
> +		generic-regs at ea0110 {
> +			compatible = "marvell,berlin-generic-regs", "syscon";
> +			reg = <0xea0110 0x10>;
> +		};
> +
>  		apb at fc0000 {
>  			compatible = "simple-bus";
>  			#address-cells = <1>;



-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

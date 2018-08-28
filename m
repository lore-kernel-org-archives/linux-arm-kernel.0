From: tony@atomide.com (Tony Lindgren)
Date: Tue, 28 Aug 2018 09:25:56 -0700
Subject: [PATCH] arm64: dts: ti: k3-am65: Change #address-cells and
 #size-cells of interconnect to 2
In-Reply-To: <20180828102642.26482-1-kishon@ti.com>
References: <20180828102642.26482-1-kishon@ti.com>
Message-ID: <20180828162556.GQ7523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [180828 10:31]:
> AM65 has two PCIe controllers and each PCIe controller has '2' address
> spaces one within the 4GB address space of the SoC and the other above
> the 4GB address space of the SoC in addition to the register space. The
> size of the address space above the 4GB SoC address space is 4GB. These
> address ranges will be used by CPU/DMA to access the PCIe address space.
> In order to represent the address space above the 4GB SoC address space
> and to represent the size of this address space as 4GB, change
> address-cells and size-cells of interconnect to 2.
...
>  		cbass_mcu: interconnect at 28380000 {
>  			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;

Yup great, the interconnect instances that don't need above 4GB
address space should stay this way.

Acked-by: Tony Lindgren <tony@atomide.com>

From: tony@atomide.com (Tony Lindgren)
Date: Tue, 4 Sep 2018 08:14:26 -0700
Subject: [PATCH v2] arm64: dts: ti: k3-am65: Change #address-cells and
 #size-cells of interconnect to 2
In-Reply-To: <20180903095235.13853-1-kishon@ti.com>
References: <20180903095235.13853-1-kishon@ti.com>
Message-ID: <20180904151426.GA5662@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [180903 09:56]:
> AM65 has two PCIe controllers and each PCIe controller has '2' address
> spaces one within the 4GB address space of the SoC and the other above
> the 4GB address space of the SoC (cbass_main) in addition to the
> register space. The size of the address space above the 4GB SoC address
> space is 4GB. These address ranges will be used by CPU/DMA to access
> the PCIe address space. In order to represent the address space above
> the 4GB SoC address space and to represent the size of this address
> space as 4GB, change address-cells and size-cells of interconnect to 2.
> 
> Since OSPI has similar need in MCU Domain Memory Map, change
> address-cells and size-cells of cbass_mcu interconnect also to 2.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> Changes from v1:
> Changed address-cells and size-cells of cbass_mcu to "2" since OSPI has
> a region of size 4GB above the 4GB space.


Acked-by: Tony Lindgren <tony@atomide.com>

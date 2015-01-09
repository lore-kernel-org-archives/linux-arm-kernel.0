From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 09 Jan 2015 01:05:11 +0100
Subject: [PATCH v3 2/4] of: move of_dma_configure() to device,
 c to help re-use
In-Reply-To: <54AF165F.7070909@ti.com>
References: <1420656594-8908-1-git-send-email-m-karicheri2@ti.com>
 <2083932.v1GzgAfexK@wuerfel> <54AF165F.7070909@ti.com>
Message-ID: <2405706.Bhe0GramZJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 January 2015 18:44:31 Murali Karicheri wrote:
> The grep of dma-ranges for arch/arm shows the size used is mask + 1 as
> 
> ./boot/dts/keystone.dtsi:               dma-ranges = <0x80000000 0x8 0x00000000 
> 0x80000000>;
> ./boot/dts/keystone.dtsi:                       dma-ranges;
> ./boot/dts/keystone.dtsi:                       dma-ranges;
> ./boot/dts/r8a7790.dtsi:                dma-ranges = <0x42000000 0 0x40000000 0 
> 0x40000000 0 0x80000000
> ./boot/dts/integratorap.dts:    dma-ranges = <0x80000000 0x0 0x80000000>;
> ./boot/dts/r8a7791.dtsi:                dma-ranges = <0x42000000 0 0x40000000 0 
> 0x40000000 0 0x80000000
> ./boot/dts/.k2hk-evm.dtb.dts.tmp:  dma-ranges = <0x80000000 0x8 
> 0x00000000 0x80000000>;
> ./boot/dts/.k2hk-evm.dtb.dts.tmp:   dma-ranges;
> ./boot/dts/.k2l-evm.dtb.dts.tmp:  dma-ranges = <0x80000000 0x8 
> 0x00000000 0x80000000>;
> ./boot/dts/.k2l-evm.dtb.dts.tmp:   dma-ranges;
> ./boot/dts/.k2e-evm.dtb.dts.tmp:  dma-ranges = <0x80000000 0x8 
> 0x00000000 0x80000000>;
> ./boot/dts/.k2e-evm.dtb.dts.tmp:   dma-ranges;
> ./boot/dts/.k2e-evm.dtb.dts.tmp:   dma-ranges;
> ./boot/dts/k2e.dtsi:                    dma-ranges;
> ./boot/dts/k2e.dtsi:                    dma-ranges;
> 
> So for ARM 32 the below case doesn't seem to apply.
> 

Ah, I guess that is because an empty dma-ranges property serves the same
purpose.

	Arnd

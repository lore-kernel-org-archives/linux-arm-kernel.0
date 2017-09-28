From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 28 Sep 2017 15:56:08 +0200
Subject: [EXT] [PATCH 1/2] arm64: dts: marvell: fix interrupt-map
 property for Armada CP110 master PCIe controller
In-Reply-To: <bfd1e045ba7d4e82a3d9f00c913a1d14@IL-EXCH02.marvell.com>
References: <20170928124550.11492-1-thomas.petazzoni@free-electrons.com>
 <20170928124550.11492-2-thomas.petazzoni@free-electrons.com>
 <2164f35d99974e1480790dac98be4a5d@IL-EXCH02.marvell.com>
 <20170928145647.35f21186@windsurf.lan>
 <bfd1e045ba7d4e82a3d9f00c913a1d14@IL-EXCH02.marvell.com>
Message-ID: <20170928155608.092d3132@windsurf.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, 28 Sep 2017 13:18:40 +0000, Yehuda Yitschak wrote:

> That zero you removed is the "parent unit address" according to the "interrupt-map" documentation 
> 
> 	parent unit address  - The unit address in the domain of the interrupt parent. The number of 32-bit
> 			            cells required to specify this address is described by the #address-cells property of the node
> 			           pointed to by the interrupt-parent field.
> 
> Now,  the gic has #address-cells =  <0x1>
> And the icu has  #address-cells = <0x0>
> 
> So when switching to ICU, the parent unit address was no longer needed and should have been removed 

Indeed, you are completely right. I'll adjust the patch accordingly and
resend. Thanks for spotting this!

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

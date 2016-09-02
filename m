From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 2 Sep 2016 15:48:54 +0530
Subject: [PATCH 1/2] ARM: dts: am57xx-beagle-x15: Remove pinmux
 configurations
In-Reply-To: <20160902090600.27262-2-nm@ti.com>
References: <20160902090600.27262-1-nm@ti.com>
 <20160902090600.27262-2-nm@ti.com>
Message-ID: <9bdf5693-ba02-8ce5-04b0-08875ccf7603@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 September 2016 02:35 PM, Nishanth Menon wrote:
> pinmuxing for DRA7x/AM57x family of processors need to be done in IO
> isolation as part of initial bootloader executed from SRAM. This is
> done as part of iodelay configuration sequence and is required due to
> the limitations introduced by erratum ID: i869[1] and elaborated in
> the Technical Reference Manual[2] 18.4.6.1.7 Isolation Requirements.
> 
> Only peripheral that is permitted for dynamic pin mux configuration is
> MMC. This is to accommodate the requirements for varied speeds (which

Actually its MMC and DCAN. DCAN because of i893 ("DCAN Initialization
Sequence"). But I can see you may have omitted reference to it since
DCAN is not really used on the x15.

Thanks,
Sekhar

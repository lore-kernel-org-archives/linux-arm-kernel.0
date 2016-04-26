From: tony@atomide.com (Tony Lindgren)
Date: Tue, 26 Apr 2016 10:03:01 -0700
Subject: [PATCH] ARM: dts: AM57xx/DRA7: Update SoC voltage rail limits to
 match data sheet
In-Reply-To: <1461140319-32026-1-git-send-email-nm@ti.com>
References: <1461140319-32026-1-git-send-email-nm@ti.com>
Message-ID: <20160426170300.GC5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [160420 01:20]:
> As per the data sheet starting from SPRUHQ0H (Nov 2015 - Latest[1]),
> VDD_CORE can vary from 0.85v to 1.15v for AVS class0. VDD GPU/DSP
> et.al. can range from 0.85v to 1.25V with AVS class0
> 
> Since dynamic voltage scaling is disabled for DRA7/AM57xx SoCs for
> all SoC rails other than MPU, the bootloader is responsible for
> setting up the AVS class0 voltage, however, with wrong voltage machine
> constraints in dtb, regulator framework will lower the voltage below
> the required voltage levels for certain samples in production flow.
> This can cause catastrophic failures which can be pretty hard to
> identify.
> 
> Update board files which don't match required specification.
> 
> [1] http://www.ti.com/product/AM5728/datasheet/specifications#SPRT637-7340

Applying into omap-for-v4.7/dt thanks. This does not apply to
v4.6-rc, so assuming this is not an urgent fix.

Regards,

Tony

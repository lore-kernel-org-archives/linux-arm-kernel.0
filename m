From: utx@penguin.cz (Stanislav Brabec)
Date: Fri, 12 Mar 2010 11:43:08 +0100
Subject: bit errors on spitz
In-Reply-To: <4B9A0A71.7010206@warmcat.com>
References: <20100305212708.GC21773@elf.ucw.cz>
	<f17812d71003072137u51be17a1ie3e50e30dea16f77@mail.gmail.com>
	<20100308072858.GA29939@atrey.karlin.mff.cuni.cz>
	<20100308082530.GA1982@atrey.karlin.mff.cuni.cz>
	<4B98EF5D.5000609@warmcat.com>
	<1268322155.3990.114.camel@hammer.suse.cz>
	<4B995EE1.1050609@warmcat.com> <1268384824.4963.35.camel@utx.utx.cz>
	<4B9A0A71.7010206@warmcat.com>
Message-ID: <1268390588.4963.66.camel@utx.utx.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andy Green wrote:

> In that case is the PXA CF driver PIO?  Then it can be the same load on 
> Vcore issue in disguise.

There is a proprietary ASIC chip (Sharp Scoop) that handles CF and HDD
access (and also several additional GPIOs):
http://www.penguin.cz/~utx/zaurus/datasheets/ASIC_S1L50752B26B200/412752.PDF

The ASIC runs in dual power mode. HVDD is powered from the 3.3V
dedicated to CF resp. HDD power supply (both may be turned off by the
kernel), LVDD is shared with CPU 3.3V (it is always on).

It seems that there are no other chips connected to the VCC_PLL,
VCC_SRAM and VCC_CORE.

VCC_DRAM is the same 3.3V ans CPU ans ASIC LVDD and also the same as
flash power and flash driver CPLD:
http://www.penguin.cz/~utx/zaurus/datasheets/memory/


________________________________________________________________________
Stanislav Brabec
http://www.penguin.cz/~utx/zaurus

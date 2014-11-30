From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Sun, 30 Nov 2014 21:53:31 +0100
Subject: [PATCH v3 0/3] SoCFPGA: L3 NIC driver
In-Reply-To: <14512010.yFXFS4V07x@wuerfel>
References: <1417292052-12974-1-git-send-email-s.trumtrar@pengutronix.de>
 <14512010.yFXFS4V07x@wuerfel>
Message-ID: <20141130205331.GR20688@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 30, 2014 at 12:51:58PM +0100, Arnd Bergmann wrote:
> > This series adds support for the SoCFPGA L3 NIC. As the memory range has
> > a lot of holes, where you can not read from, syscon can not be used for
> > this IP core. Instead add a new driver, that knows about all the allowed
> > ranges and guards the access via regmap.
> 
> What is an L3 NIC?

Fron the SoCFPGA manual:

"
The hard processor system (HPS) level 3 (L3) interconnect and level 4
(L4) peripheral buses are implemented with the ARM CoreLinkTM Network
Interconnect (NIC-301). The NIC-301 provides a foundation for a
high-performance HPS interconnect based on the ARM Advanced
Microcontroller Bus Architecture (AMBA) Advanced eXtensible Interface
(AXI), Advanced High-Performance Bus (AHBTM), and Advanced Peripheral
Bus (APBTM) protocols. The L3 interconnect implements a multilayer,
nonblocking architecture that supports multiple simultaneous
transactions between masters and slaves, including the Cortex-A9
microprocessor unit (MPU) subsystem. The interconnect provides five
independent L4 buses to access control and status registers (CSRs) of
peripherals, managers, and memory controllers Related Information
http://infocenter.arm.com/ Additional information is available in the
AMBA Network Interconnect (NIC-301) Technical Reference Manual, revision
r2p3, which you can download from the ARM info center website.
"

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

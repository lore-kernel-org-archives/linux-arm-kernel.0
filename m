From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 1 Dec 2014 10:08:58 +0000
Subject: [PATCH v3 0/3] SoCFPGA: L3 NIC driver
In-Reply-To: <1417292052-12974-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1417292052-12974-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <20141201100858.GA17070@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 29, 2014 at 08:14:09PM +0000, Steffen Trumtrar wrote:
> Hi!

Hi Steffen,

> This series adds support for the SoCFPGA L3 NIC. As the memory range has
> a lot of holes, where you can not read from, syscon can not be used for
> this IP core. Instead add a new driver, that knows about all the allowed
> ranges and guards the access via regmap.

I note that while this series plumbs in a set of accessors (via regmap),
there are no users as part of this series. What exactly do you intend to
use these for? What is going to (re)program the bus, and how?

I also note that you mention this L3/L4 bus hierarchy is composed of a
number of NIC-301s, rather than being a single custom IP block. If
that's the case, it would seem like there should be a binding for the
NIC-301, and the hierarchy should be described.

Thanks,
Mark.

> 
> Changes in v3:
> 
> 	- Split out the devicetree binding in its own patch
> 
> Regards,
> Steffen
> 
> Steffen Trumtrar (3):
>   Documentation: dt: add Altera L3 NIC bindings
>   ARM: socfpga: Add driver for the L3 interconnect
>   ARM: dts: socfpga: Add l3nic node
> 
>  .../bindings/soc/socfpga/altr,l3-nic.txt           |  15 ++
>  arch/arm/boot/dts/socfpga.dtsi                     |   5 +
>  drivers/soc/Kconfig                                |   1 +
>  drivers/soc/Makefile                               |   1 +
>  drivers/soc/socfpga/Kconfig                        |  10 +
>  drivers/soc/socfpga/Makefile                       |   1 +
>  drivers/soc/socfpga/l3nic.c                        | 221 +++++++++++++++++++++
>  include/soc/socfpga/gpv.h                          |  63 ++++++
>  include/soc/socfpga/l3regs.h                       | 192 ++++++++++++++++++
>  9 files changed, 509 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/socfpga/altr,l3-nic.txt
>  create mode 100644 drivers/soc/socfpga/Kconfig
>  create mode 100644 drivers/soc/socfpga/Makefile
>  create mode 100644 drivers/soc/socfpga/l3nic.c
>  create mode 100644 include/soc/socfpga/gpv.h
>  create mode 100644 include/soc/socfpga/l3regs.h
> 
> -- 
> 2.1.3
> 
> 

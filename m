From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 14 Jan 2015 17:21:52 +0100
Subject: [PATCH v5 00/11] memory: add Atmel EBI (External Bus Interface)
 driver
In-Reply-To: <20150111135615.3326d803@bbrezillon>
References: <1417639455-17410-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150111135615.3326d803@bbrezillon>
Message-ID: <20150114162152.GL3843@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On 11/01/2015 at 13:56:15 +0100, Boris Brezillon wrote :
> Hi Lee,
> 
> On Wed,  3 Dec 2014 21:44:04 +0100
> Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
> 
> > The EBI (External Bus Interface) is used to access external peripherals
> > (NOR, SRAM, NAND, and other specific devices like ethernet controllers).
> > Each device is assigned a CS line and an address range and can have its
> > own configuration (timings, access mode, bus width, ...).
> > This driver provides a generic DT binding to configure a device according
> > to its requirements.
> > For specific device controllers (like the NAND one) the SMC timings
> > should be configured by the controller driver through the matrix and
> > smc syscon regmaps.
> > 
> > The first 4 patches introduce 2 syscon devices needed to configure the
> > EBI bus, patch 5 and 6 adds support for the EBI bus, and the remaining
> > patches declares the EBI related nodes in sama5d3 dts[i] files.
> 
> Can you take the first 4 patches of this series (adding 2 syscon
> devices and their associated bindings doc) for 3.20 ?
> Alexandre has worked on multi platform support for Atmel SoCs and his
> work depends on these two syscon devices.
> 
> Let me know if you want me to send to send a new series containing only
> those 4 commits.
> 

Actually, because of other series depending on it and because you
already acked them, Nicolas wants to take those 4 patches through the
AT91 tree, unless you have any reason to take them through your tree.

Sorry for the noise.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

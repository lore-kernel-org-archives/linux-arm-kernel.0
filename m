From: agraf@suse.de (Alexander Graf)
Date: Sat, 5 Aug 2017 06:23:55 +0200
Subject: [PATCH 0/3] arm64 xilinx zynqmp firmware interface
In-Reply-To: <cover.1501854302.git.michal.simek@xilinx.com>
References: <cover.1501854302.git.michal.simek@xilinx.com>
Message-ID: <34C9E6FB-A8CA-462F-8B10-3E15F9EC87D4@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> Am 04.08.2017 um 15:45 schrieb Michal Simek <michal.simek@xilinx.com>:
> 
> Hi,
> 
> xilinx is using this interface for very long time and we can't merge our
> driver changes to Linux because of missing communication layer with
> firmware. This interface was developed before scpi and scmi was
> available. In connection to power management scpi and scmi are missing
> pieces which we already use. There is a separate discussion how to
> extend scmi to support all our use cases.
> This simply patch is not adding any power management features but only
> adding minimum functionality which are needed for drivers.

If you're thinking of changing the interface later down the road, wouldn't it make sense to probe EL3 for its existence? You could then expose this interface on today's EL3 and something scpi/scmi based on tomorrow's.

Alex

> 
> Thanks,
> Michal
> 
> 
> Michal Simek (1):
>  soc: xilinx: zynqmp: Add firmware interface
> 
> Soren Brinkmann (2):
>  dt: xilinx: zynqmp: Add bindings for PM firmware
>  arm64: zynqmp: dt: Add PM firmware node
> 
> .../bindings/soc/xilinx/xlnx,zynqmp-pm.txt         |  19 +
> arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   7 +
> drivers/soc/Kconfig                                |   1 +
> drivers/soc/Makefile                               |   1 +
> drivers/soc/xilinx/Kconfig                         |   6 +
> drivers/soc/xilinx/zynqmp/Makefile                 |   1 +
> drivers/soc/xilinx/zynqmp/firmware.c               | 419 +++++++++++++++++++++
> include/linux/soc/xilinx/zynqmp/firmware.h         | 246 ++++++++++++
> 8 files changed, 700 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/soc/xilinx/xlnx,zynqmp-pm.txt
> create mode 100644 drivers/soc/xilinx/Kconfig
> create mode 100644 drivers/soc/xilinx/zynqmp/Makefile
> create mode 100644 drivers/soc/xilinx/zynqmp/firmware.c
> create mode 100644 include/linux/soc/xilinx/zynqmp/firmware.h
> 
> -- 
> 1.9.1
> 

From: hean.loong.ong@intel.com (Hean-Loong, Ong)
Date: Fri, 11 Aug 2017 14:49:44 +0800
Subject: [PATCHv6 0/3] 
Message-ID: <1502434187-6407-1-git-send-email-hean.loong.ong@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ong Hean Loong <hean.loong.ong@intel.com>

The FPGA FrameBuffer Soft IP could be seen  as the GPU and 
the DRM driver patch here is allocating memory for 
information to be streamed from the ARM/Linux to the display port.
Basically the driver just wraps the information such as the pixels to 
be drawn by the FPGA FrameBuffer 2.

The piece of hardware in discussion is the SoC FPGA where Linux runs 
on the ARM chip and the FGPA is driven by its NIOS soft core with its 
own proprietary firmware.

For example the application from the ARM Linux would have to write  
information on the /dev/fb0 with the information stored in the SDRAM 
to be fetched by the FPGA framebuffer IP and displayed on the Display 
Port Monitor.

Ong Hean Loong (3):
  ARM:dt-bindings Intel FPGA Video and Image Processing Suite
  ARM:socfpga-defconfig Intel FPGA Video and Image Processing Suite
  ARM:drm ivip Intel FPGA Video and Image Processing Suite

 .../devicetree/bindings/display/altr,vip-fb2.txt   |  42 +++++
 arch/arm/configs/socfpga_defconfig                 |   6 +
 drivers/gpu/drm/Kconfig                            |   2 +
 drivers/gpu/drm/Makefile                           |   1 +
 drivers/gpu/drm/ivip/Kconfig                       |  14 ++
 drivers/gpu/drm/ivip/Makefile                      |   9 +
 drivers/gpu/drm/ivip/intel_vip_conn.c              |  96 ++++++++++
 drivers/gpu/drm/ivip/intel_vip_core.c              | 162 +++++++++++++++++
 drivers/gpu/drm/ivip/intel_vip_drv.h               |  52 ++++++
 drivers/gpu/drm/ivip/intel_vip_of.c                | 194 +++++++++++++++++++++
 10 files changed, 578 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/altr,vip-fb2.txt
 create mode 100644 drivers/gpu/drm/ivip/Kconfig
 create mode 100644 drivers/gpu/drm/ivip/Makefile
 create mode 100644 drivers/gpu/drm/ivip/intel_vip_conn.c
 create mode 100644 drivers/gpu/drm/ivip/intel_vip_core.c
 create mode 100644 drivers/gpu/drm/ivip/intel_vip_drv.h
 create mode 100644 drivers/gpu/drm/ivip/intel_vip_of.c

-- 
2.7.4

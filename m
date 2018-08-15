From: hean.loong.ong@intel.com (Ong, Hean Loong)
Date: Wed, 15 Aug 2018 01:42:45 +0000
Subject: [PATCH10 0/3] Intel FPGA Video and Image Processing Suite
In-Reply-To: <3720ba74-947a-1b5d-5f5b-1ef03d5941aa@kernel.org>
References: <1534237029-2648-1-git-send-email-hean.loong.ong@intel.com>
 <3720ba74-947a-1b5d-5f5b-1ef03d5941aa@kernel.org>
Message-ID: <1534297365.3035.0.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-08-14 at 10:48 -0500, Dinh Nguyen wrote:
> 
> On 08/14/2018 03:57 AM, Hean-Loong, Ong wrote:
> > 
> > From: Ong, Hean Loong <hean.loong.ong@intel.com>
> > 
> > The FPGA FrameBuffer Soft IP could be seen??as the GPU and the DRM
> > driver patch?
> > here is allocating memory for information to be streamed from the
> > ARM/Linux?
> > to the display port. Basically the driver just wraps the
> > information such as?
> > the pixels to be drawn by the FPGA FrameBuffer 2.
> > 
> > The piece of hardware in discussion is the SoC FPGA where Linux
> > runs on the?
> > ARM chip and the FGPA is driven by its NIOS soft core with its own
> > proprietary firmware.
> This driver doesn't have to ARM specific does it?
> 
> > 
> > 
> > For example the application from the ARM Linux would have to write
> > information?
> > on the /dev/fb0 with the information stored in the SDRAM to be
> > fetched by the?
> > FPGA framebuffer IP and displayed on the Display Port Monitor.
> > 
> > 
> > Ong Hean Loong (2):
> > ? ARM:socfpga-defconfig Intel FPGA Video and Image Processing Suite
> > ? ARM:drm ivip Intel FPGA Video and Image Processing Suite
> > 
> > Ong, Hean Loong (1):
> > ? ARM:dt-bindings:display Intel FPGA Video and Image Processing
> > Suite
> > 
> > ?.../devicetree/bindings/display/altr,vip-fb2.txt???|???63 +++++++
> > ?arch/arm/configs/socfpga_defconfig?????????????????|????5 +
> > ?drivers/gpu/drm/Kconfig????????????????????????????|????2 +
> > ?drivers/gpu/drm/Makefile???????????????????????????|????1 +
> > ?drivers/gpu/drm/ivip/Kconfig???????????????????????|???14 ++
> > ?drivers/gpu/drm/ivip/Makefile??????????????????????|????9 +
> > ?drivers/gpu/drm/ivip/intel_vip_conn.c??????????????|???95
> > ++++++++++
> > ?drivers/gpu/drm/ivip/intel_vip_core.c??????????????|??161
> > ++++++++++++++++
> > ?drivers/gpu/drm/ivip/intel_vip_drv.h???????????????|???52 ++++++
> > ?drivers/gpu/drm/ivip/intel_vip_of.c????????????????|??193
> > ++++++++++++++++++++
> > ?10 files changed, 595 insertions(+), 0 deletions(-)
> > ?create mode 100644
> > Documentation/devicetree/bindings/display/altr,vip-fb2.txt
> > ?create mode 100644 drivers/gpu/drm/ivip/Kconfig
> > ?create mode 100644 drivers/gpu/drm/ivip/Makefile
> > ?create mode 100644 drivers/gpu/drm/ivip/intel_vip_conn.c
> > ?create mode 100644 drivers/gpu/drm/ivip/intel_vip_core.c
> > ?create mode 100644 drivers/gpu/drm/ivip/intel_vip_drv.h
> > ?create mode 100644 drivers/gpu/drm/ivip/intel_vip_of.c
> > 
> Can you clarify your commit header? What is "PATCH10", is it version
> 10?
> If so, it should be "PATCHv10".
> 
> You're also missing a few other maintainers in your CC list, the "DRM
> DRIVERS AND MISC GPU PATCHES" people.
> 
Noted

> Dinh

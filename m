From: vsagar@xilinx.com (Vishal Sagar)
Date: Wed, 30 May 2018 06:22:02 +0000
Subject: [PATCH 2/2] media: v4l: xilinx: Add Xilinx MIPI CSI-2 Rx
 Subsystem driver
In-Reply-To: <5bf470c0-8737-273e-c138-58a05d7d9a30@infradead.org>
References: <1527620084-94864-1-git-send-email-vishal.sagar@xilinx.com>
 <1527620084-94864-3-git-send-email-vishal.sagar@xilinx.com>
 <5bf470c0-8737-273e-c138-58a05d7d9a30@infradead.org>
Message-ID: <CY4PR02MB2709A481A94CB673DC8C87EBA76C0@CY4PR02MB2709.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Randy,

Thanks for reviewing. 

> -----Original Message-----
> From: Randy Dunlap [mailto:rdunlap at infradead.org]
> Sent: Wednesday, May 30, 2018 1:29 AM
> To: Vishal Sagar <vishal.sagar@xilinx.com>; Hyun Kwon <hyunk@xilinx.com>;
> laurent.pinchart at ideasonboard.com; michal.simek at xilinx.com; linux-
> media at vger.kernel.org; devicetree at vger.kernel.org
> Cc: sakari.ailus at linux.intel.com; hans.verkuil at cisco.com;
> mchehab at kernel.org; robh+dt at kernel.org; mark.rutland at arm.com; Dinesh
> Kumar <dineshk@xilinx.com>; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org
> Subject: Re: [PATCH 2/2] media: v4l: xilinx: Add Xilinx MIPI CSI-2 Rx Subsystem
> driver
> 
> On 05/29/2018 11:54 AM, Vishal Sagar wrote:
> >
> > Signed-off-by: Vishal Sagar <vishal.sagar@xilinx.com>
> > ---
> >  drivers/media/platform/xilinx/Kconfig           |   12 +
> >  drivers/media/platform/xilinx/Makefile          |    1 +
> >  drivers/media/platform/xilinx/xilinx-csi2rxss.c | 1751
> +++++++++++++++++++++++
> >  include/uapi/linux/xilinx-csi2rxss.h            |   25 +
> >  include/uapi/linux/xilinx-v4l2-controls.h       |   14 +
> >  5 files changed, 1803 insertions(+)
> >  create mode 100644 drivers/media/platform/xilinx/xilinx-csi2rxss.c
> >  create mode 100644 include/uapi/linux/xilinx-csi2rxss.h
> >
> > diff --git a/drivers/media/platform/xilinx/Kconfig
> b/drivers/media/platform/xilinx/Kconfig
> > index a5d21b7..06d5944 100644
> > --- a/drivers/media/platform/xilinx/Kconfig
> > +++ b/drivers/media/platform/xilinx/Kconfig
> > @@ -8,6 +8,18 @@ config VIDEO_XILINX
> >
> >  if VIDEO_XILINX
> >
> > +config VIDEO_XILINX_CSI2RXSS
> > +       tristate "Xilinx CSI2 Rx Subsystem"
> > +       depends on VIDEO_XILINX
> > +       help
> > +         Driver for Xilinx MIPI CSI2 Rx Subsystem. This is a V4L sub-device
> > +         based driver that takes input from CSI2 Tx source and converts
> > +         it into an AXI4-Stream. It has a DPHY (whose register interface
> > +         can be enabled, an optional I2C controller and an optional Video
> 
> 	    can be enabled),
> 

Noted. I will update in next revision of patch.

> > +         Format Bridge which converts the AXI4-Stream data to Xilinx Video
> > +         Bus formats based on UG934. The driver is used to set the number
> > +         of active lanes and get short packet data.
> > +
> >  config VIDEO_XILINX_TPG
> >         tristate "Xilinx Video Test Pattern Generator"
> >         depends on VIDEO_XILINX
> 
> 
> 
> > This email and any attachments are intended for the sole use of the named
> recipient(s) and contain(s) confidential information that may be proprietary,
> privileged or copyrighted under applicable law. If you are not the intended
> recipient, do not read, copy, or forward this email message or any attachments.
> Delete this email message and any attachments immediately.
> 
> :(
> 

Sorry about that.
I will work with IT on getting this removed before sending v2 for the patches.

-- Vishal 

> --
> ~Randy

From: rdunlap@infradead.org (Randy Dunlap)
Date: Tue, 29 May 2018 12:59:15 -0700
Subject: [PATCH 2/2] media: v4l: xilinx: Add Xilinx MIPI CSI-2 Rx
 Subsystem driver
In-Reply-To: <1527620084-94864-3-git-send-email-vishal.sagar@xilinx.com>
References: <1527620084-94864-1-git-send-email-vishal.sagar@xilinx.com>
 <1527620084-94864-3-git-send-email-vishal.sagar@xilinx.com>
Message-ID: <5bf470c0-8737-273e-c138-58a05d7d9a30@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/29/2018 11:54 AM, Vishal Sagar wrote:
> 
> Signed-off-by: Vishal Sagar <vishal.sagar@xilinx.com>
> ---
>  drivers/media/platform/xilinx/Kconfig           |   12 +
>  drivers/media/platform/xilinx/Makefile          |    1 +
>  drivers/media/platform/xilinx/xilinx-csi2rxss.c | 1751 +++++++++++++++++++++++
>  include/uapi/linux/xilinx-csi2rxss.h            |   25 +
>  include/uapi/linux/xilinx-v4l2-controls.h       |   14 +
>  5 files changed, 1803 insertions(+)
>  create mode 100644 drivers/media/platform/xilinx/xilinx-csi2rxss.c
>  create mode 100644 include/uapi/linux/xilinx-csi2rxss.h
> 
> diff --git a/drivers/media/platform/xilinx/Kconfig b/drivers/media/platform/xilinx/Kconfig
> index a5d21b7..06d5944 100644
> --- a/drivers/media/platform/xilinx/Kconfig
> +++ b/drivers/media/platform/xilinx/Kconfig
> @@ -8,6 +8,18 @@ config VIDEO_XILINX
> 
>  if VIDEO_XILINX
> 
> +config VIDEO_XILINX_CSI2RXSS
> +       tristate "Xilinx CSI2 Rx Subsystem"
> +       depends on VIDEO_XILINX
> +       help
> +         Driver for Xilinx MIPI CSI2 Rx Subsystem. This is a V4L sub-device
> +         based driver that takes input from CSI2 Tx source and converts
> +         it into an AXI4-Stream. It has a DPHY (whose register interface
> +         can be enabled, an optional I2C controller and an optional Video

	    can be enabled),

> +         Format Bridge which converts the AXI4-Stream data to Xilinx Video
> +         Bus formats based on UG934. The driver is used to set the number
> +         of active lanes and get short packet data.
> +
>  config VIDEO_XILINX_TPG
>         tristate "Xilinx Video Test Pattern Generator"
>         depends on VIDEO_XILINX



> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

:(

-- 
~Randy

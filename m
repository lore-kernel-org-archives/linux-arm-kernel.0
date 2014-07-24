From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 24 Jul 2014 16:22:35 -0700
Subject: [PATCH v2 08/11] ARM: dts: zynq: Add VDMA to Parallella
In-Reply-To: <1406242820-20140-9-git-send-email-afaerber@suse.de>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
 <1406242820-20140-9-git-send-email-afaerber@suse.de>
Message-ID: <b4c4e060-2efb-4b82-be12-32c00897ec93@BY2FFO11FD023.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-07-25 at 01:00AM +0200, Andreas F?rber wrote:
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v2: New
>  
>  arch/arm/boot/dts/zynq-parallella.dts | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
> index e60a0a9..8beaacc 100644
> --- a/arch/arm/boot/dts/zynq-parallella.dts
> +++ b/arch/arm/boot/dts/zynq-parallella.dts
> @@ -32,6 +32,31 @@
>  		bootargs = "console=ttyPS0,115200 earlyprintk root=/dev/mmcblk0p2 rootfstype=ext4 rw rootwait";
>  		linux,stdout-path = "/amba/serial at e0001000";
>  	};
> +
> +	fpga {
Do you really want FPGA components in this DT?
If somebody tries booting with this DT without programming with a
corresponding bitstream, the whole system might hang.
Just something to consider.

	S?ren

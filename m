From: monstr@monstr.eu (Michal Simek)
Date: Thu, 27 Jun 2013 15:01:51 +0200
Subject: [PATCH linux-next] arm: zynq: fix compilation warning
In-Reply-To: <1372336962-6459-1-git-send-email-vincent.stehle@freescale.com>
References: <1372336962-6459-1-git-send-email-vincent.stehle@freescale.com>
Message-ID: <51CC37BF.8030309@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vincent,

Arnd asked in this post
http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg454947.html
to fold his small patch to that larger one.

Not sure why it is not there.
Arnd, Robin?

Thanks
Michal


On 06/27/2013 02:42 PM, Vincent Stehl? wrote:
> Fix the following compilation warning:
> 
>   arch/arm/mach-zynq/common.c:110:2: warning: initialization from incompatible pointer type [enabled by default]
>   arch/arm/mach-zynq/common.c:110:2: warning: (near initialization for ?__mach_desc_XILINX_EP107.restart?) [enabled by default]
> 
> Signed-off-by: Vincent Stehl? <vincent.stehle@freescale.com>
> Cc: Robin Holt <holt@sgi.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: trivial at kernel.org
> ---
> 
> 
> Hi,
> 
> This warning was seen on linux-next tag next-20130627, with config ARM
> multi_v7_defconfig.
> 
> Best regards,
> 
> V.
> 
> 
>  arch/arm/mach-zynq/common.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
> index 4130e65..8ea5f11 100644
> --- a/arch/arm/mach-zynq/common.c
> +++ b/arch/arm/mach-zynq/common.c
> @@ -91,7 +91,7 @@ static void __init zynq_map_io(void)
>  	zynq_scu_map_io();
>  }
>  
> -static void zynq_system_reset(char mode, const char *cmd)
> +static void zynq_system_reset(enum reboot_mode mode, const char *cmd)
>  {
>  	zynq_slcr_system_reset();
>  }
> 


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130627/782ecca8/attachment.sig>

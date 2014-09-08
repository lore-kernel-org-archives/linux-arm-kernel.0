From: monstr@monstr.eu (Michal Simek)
Date: Mon, 08 Sep 2014 07:20:09 +0200
Subject: [PATCH] drivers/usb/host/ehci-xilinx-of.c: Include
 "linux/of_irq.h" to avoid compiling error
In-Reply-To: <540738C7.5000106@gmail.com>
References: <540738C7.5000106@gmail.com>
Message-ID: <540D3C89.6080702@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03/2014 05:50 PM, Chen Gang wrote:
> Need include it for irq_of_parse_and_map(), the related error with
> allmodconfig under microblaze:
> 
>   drivers/usb/host/ehci-xilinx-of.c: In function ?ehci_hcd_xilinx_of_probe?:
>   drivers/usb/host/ehci-xilinx-of.c:156:2: error: implicit declaration of function ?irq_of_parse_and_map? [-Werror=implicit-function-declaration]
>     irq = irq_of_parse_and_map(dn, 0);
>     ^
> 
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
> ---
>  drivers/usb/host/ehci-xilinx-of.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/host/ehci-xilinx-of.c b/drivers/usb/host/ehci-xilinx-of.c
> index fe57710..a232836 100644
> --- a/drivers/usb/host/ehci-xilinx-of.c
> +++ b/drivers/usb/host/ehci-xilinx-of.c
> @@ -31,6 +31,7 @@
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/of_address.h>
> +#include <linux/of_irq.h>
>  
>  /**
>   * ehci_xilinx_port_handed_over - hand the port out if failed to enable it
> 

Acked-by: Michal Simek <monstr@monstr.eu>

Thanks,
Michal

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
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140908/51d60e4e/attachment.sig>

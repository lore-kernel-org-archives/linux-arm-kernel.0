From: monstr@monstr.eu (Michal Simek)
Date: Mon, 27 Jul 2015 10:21:35 +0200
Subject: [PATCH] clk: zynq: remove redundant $(CONFIG_ARCH_ZYNQ) in
 Makefile
In-Reply-To: <1437982602-26886-1-git-send-email-yamada.masahiro@socionext.com>
References: <1437982602-26886-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <55B5EA0F.8000404@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/27/2015 09:36 AM, Masahiro Yamada wrote:
> Kbuild descends into drivers/clk/zynq/ only when CONFIG_ARCH_ZYNQ
> is enabled.  (see drivers/clk/Makefile)
> 
> $(CONFIG_ARCH_ZYNQ) in drivers/clk/zynq/Makefile always evaluates
> to 'y'.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  drivers/clk/zynq/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/zynq/Makefile b/drivers/clk/zynq/Makefile
> index 156d923..0afc2e7 100644
> --- a/drivers/clk/zynq/Makefile
> +++ b/drivers/clk/zynq/Makefile
> @@ -1,3 +1,3 @@
>  # Zynq clock specific Makefile
>  
> -obj-$(CONFIG_ARCH_ZYNQ)	+= clkc.o pll.o
> +obj-y	+= clkc.o pll.o
> 

Applied to zynq/soc branch and will go to mainline via arm-soc.
Let me know if someone else wants to take it via different tree.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150727/73cb0d26/attachment.sig>

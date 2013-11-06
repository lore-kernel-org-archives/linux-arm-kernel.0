From: monstr@monstr.eu (Michal Simek)
Date: Wed, 06 Nov 2013 08:46:37 +0100
Subject: [PATCH 6/6] arm: zynq: headsmp: Move .glbl out of actual code
In-Reply-To: <1383235819-2552-7-git-send-email-soren.brinkmann@xilinx.com>
References: <1383235819-2552-1-git-send-email-soren.brinkmann@xilinx.com>
 <1383235819-2552-7-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <5279F3DD.9040605@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/2013 05:10 PM, Soren Brinkmann wrote:
> Move the .glbl lines exporting symbols to the top of the file and out of
> the actual code, in order to make the code more readable.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  arch/arm/mach-zynq/headsmp.S | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-zynq/headsmp.S b/arch/arm/mach-zynq/headsmp.S
> index 57a32869f0aa..12d1b40c7d78 100644
> --- a/arch/arm/mach-zynq/headsmp.S
> +++ b/arch/arm/mach-zynq/headsmp.S
> @@ -9,14 +9,15 @@
>  #include <linux/linkage.h>
>  #include <linux/init.h>
>  
> +.globl zynq_secondary_trampoline_jump
> +.globl zynq_secondary_trampoline_end
> +
>  ENTRY(zynq_secondary_trampoline)
>  	ldr	r0, [pc]
>  	bx	r0
> -.globl zynq_secondary_trampoline_jump
>  zynq_secondary_trampoline_jump:
>  	/* Space for jumping address */
>  	.word	/* cpu 1 */
> -.globl zynq_secondary_trampoline_end
>  zynq_secondary_trampoline_end:
>  ENDPROC(zynq_secondary_trampoline)
>  

I don't want this one.
I have applied 1-5 to zynq/cleanup branch.

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
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131106/b15b0ad0/attachment.sig>

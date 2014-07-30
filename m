From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 30 Jul 2014 08:40:52 -0700
Subject: [PATCH v2 1/2] ARM: smp_scu: use macro for SCU enable bit
In-Reply-To: <1406275790-18617-2-git-send-email-shawn.guo@freescale.com>
References: <1406275790-18617-1-git-send-email-shawn.guo@freescale.com>
 <1406275790-18617-2-git-send-email-shawn.guo@freescale.com>
Message-ID: <f3845882-dc51-432c-a774-97c389769fe6@BN1AFFO11FD034.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Fri, 2014-07-25 at 04:09PM +0800, Shawn Guo wrote:
> Use macro instead of magic number for SCU enable bit.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  arch/arm/kernel/smp_scu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
> index 1aafa0d785eb..c947508f84e6 100644
> --- a/arch/arm/kernel/smp_scu.c
> +++ b/arch/arm/kernel/smp_scu.c
> @@ -17,6 +17,7 @@
>  #include <asm/cputype.h>
>  
>  #define SCU_CTRL		0x00
> +#define SCU_ENABLE		(1 << 0)
I'd prefer using 'BIT(0)' here (and accordingly in the second patch).

For both patches:
Acked-by: Soren Brinkmann <soren.brinkmann@xilinx.com>

	S?ren

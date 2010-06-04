From: amit.kucheria@canonical.com (Amit Kucheria)
Date: Fri, 4 Jun 2010 18:13:07 +0300
Subject: [V3 3/7] mx51/iomux: fix some pad names and make some cleanups
In-Reply-To: <1275660568-7738-4-git-send-email-jason77.wang@gmail.com>
References: <1275660568-7738-1-git-send-email-jason77.wang@gmail.com>
	<1275660568-7738-2-git-send-email-jason77.wang@gmail.com>
	<1275660568-7738-3-git-send-email-jason77.wang@gmail.com>
	<1275660568-7738-4-git-send-email-jason77.wang@gmail.com>
Message-ID: <20100604151307.GD2982@matterhorn.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 Jun 04, Jason Wang wrote:
> Fix some pad names according to the naming convention and make some
> cleanups for vertical lineup.
> 
> Signed-off-by: Jason Wang <jason77.wang@gmail.com>
> ---
>  arch/arm/plat-mxc/include/mach/iomux-mx51.h |  507 ++++++++++++--------------
>  1 files changed, 234 insertions(+), 273 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx51.h b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
> index ab0f95d..df9ecdf 100644
> --- a/arch/arm/plat-mxc/include/mach/iomux-mx51.h
> +++ b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
> @@ -57,278 +57,239 @@ typedef enum iomux_config {
>  
>  /*						PAD      MUX   ALT INPSE PATH PADCTRL */
>  
> -#define MX51_PAD_GPIO_2_0__EIM_D16	IOMUX_PAD(0x3f0, 0x05c, 1, 0x0,   0, NO_PAD_CTRL)
> -#define MX51_PAD_GPIO_2_1__EIM_D17	IOMUX_PAD(0x3f4, 0x060, 1, 0x0,   0, NO_PAD_CTRL)
<snip> 

Did you try compiling this? It fails to compile both babbage and 3ds boards.

This breaks the babbage board because a pad name was changed here. (An
underscore between GPIO and 1)

arch/arm/mach-mx5/board-mx51_babbage.c:81: error:
'MX51_PAD_GPIO_1_7__GPIO1_7' undeclared here (not in a function)
arch/arm/mach-mx5/board-mx51_babbage.c: In function 'initialize_otg_port':

For 3ds, the errors are:
arch/arm/mach-mx5/board-mx51_3ds.c:44: error: 'MX51_PAD_UART3_RXD__UART3_RXD'
undeclared here (not in a function)
arch/arm/mach-mx5/board-mx51_3ds.c:45: error: 'MX51_PAD_UART3_TXD__UART3_TXD'
undeclared here (not in a function)
arch/arm/mach-mx5/board-mx51_3ds.c:50: error: 'MX51_PAD_GPIO_1_6__GPIO1_6'
undeclared here (not in a function)

Perhaps you should wait till Sascha pulls in either of our patches to fixup
the padnames first.

Cheers,
Amit
-- 
----------------------------------------------------------------------
Amit Kucheria, Kernel Engineer || amit.kucheria at canonical.com
----------------------------------------------------------------------

From: jamie@jamieiles.com (Jamie Iles)
Date: Sat, 8 Oct 2011 16:33:24 +0100
Subject: [PATCH 2/3] ARM: imx: add missing include of linux/ftrace.h
In-Reply-To: <1928841.IC5oQhqc6l@wuerfel>
References: <20111004092015.GM31404@pengutronix.de>
	<20111008101322.GH31404@pengutronix.de>
	<109850802.HMOqKGRdrl@wuerfel> <1928841.IC5oQhqc6l@wuerfel>
Message-ID: <20111008153324.GA18424@gallagher>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Sascha,

On Sat, Oct 08, 2011 at 05:16:26PM +0200, Arnd Bergmann wrote:
> Using the __exception_irq_entry symbol requires including
> this header file:
> 
> arch/arm/plat-mxc/avic.c:154:39: error: expected '=', ',', ';', 'asm'
> 		or '__attribute__' before 'avic_handle_irq'
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/plat-mxc/avic.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/avic.c b/arch/arm/plat-mxc/avic.c
> index 8875fb4..9bab263 100644
> --- a/arch/arm/plat-mxc/avic.c
> +++ b/arch/arm/plat-mxc/avic.c
> @@ -20,6 +20,7 @@
>  #include <linux/module.h>
>  #include <linux/irq.h>
>  #include <linux/io.h>
> +#include <linux/ftrace.h>

Russell has applied a patch to move __exception_irq_entry into 
asm/exception.h (with the include of ftrace.h) into his for-next branch.  
So I think avic.c should be using this (as it's not explicitly using 
ftrace).

Jamie

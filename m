From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 30 Mar 2012 13:59:06 +0200
Subject: [PATCH] ARM: at91: add support for Telit GE863-PRO3 Evaluation Kit
In-Reply-To: <1333097816-8641-1-git-send-email-fabio.porcedda@gmail.com>
References: <1333097816-8641-1-git-send-email-fabio.porcedda@gmail.com>
Message-ID: <20120330115906.GM7757@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:56 Fri 30 Mar     , Fabio Porcedda wrote:
> Based on board-sam9260ek.c.
> 
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> ---
>  arch/arm/mach-at91/Kconfig            |    6 +
>  arch/arm/mach-at91/Makefile           |    1 +
>  arch/arm/mach-at91/board-ge863-pro3.c |  338 +++++++++++++++++++++++++++++++++
>  3 files changed, 345 insertions(+)
>  create mode 100644 arch/arm/mach-at91/board-ge863-pro3.c
> 
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index 45db05d..4197a2a 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -272,6 +272,12 @@ config MACH_FLEXIBITY
>  	  Select this if you are using Flexibity Connect board
>  	  <http://www.flexibity.com>
>  
> +config MACH_GE863_PRO3_EVK
> +       bool "Telit GE863-PRO3 Evaluation Kit"
> +       help
> +         Select this if you are using Telit GE863-PRO3 Evaluation Kit
> +	 <http://www.telit.com>
> +
>  endif
tks for the patch but now we have close the non dt board for this soc

and for 3.5 nearly all the devices of this soc will converted to DT

so you need to switch to DT too

As today I've not finished the pinctrl support you need to do all the pin mux
in the bootlader. For 3.5 it will not be the case anymore

Best Rebards,
J.

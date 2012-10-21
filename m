From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 21 Oct 2012 20:30:05 +0200
Subject: [PATCH 1/5] net/cadence: get rid of HAVE_NET_MACB
In-Reply-To: <1350829392-3812-2-git-send-email-manabian@gmail.com>
References: <1350829392-3812-1-git-send-email-manabian@gmail.com>
 <1350829392-3812-2-git-send-email-manabian@gmail.com>
Message-ID: <20121021183005.GA18964@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:23 Sun 21 Oct     , Joachim Eastwood wrote:
> macb is a platform driver and there is nothing that prevents
> this driver from being built on non-ARM/AVR32 platforms.
if you want to drop the HAVE_NET_MACB you need to drop it everywher in one
patch

Best Regards,
J.
> 
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> ---
>  drivers/net/ethernet/cadence/Kconfig | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/Kconfig b/drivers/net/ethernet/cadence/Kconfig
> index 57f78abe..5d1ea30 100644
> --- a/drivers/net/ethernet/cadence/Kconfig
> +++ b/drivers/net/ethernet/cadence/Kconfig
> @@ -2,13 +2,9 @@
>  # Atmel device configuration
>  #
>  
> -config HAVE_NET_MACB
> -	bool
> -
>  config NET_CADENCE
>  	bool "Cadence devices"
>  	default y
> -	depends on HAVE_NET_MACB || (ARM && ARCH_AT91RM9200)
>  	---help---
>  	  If you have a network (Ethernet) card belonging to this class, say Y.
>  	  Make sure you know the name of your card. Read the Ethernet-HOWTO,
> @@ -34,7 +30,6 @@ config ARM_AT91_ETHER
>  
>  config MACB
>  	tristate "Cadence MACB/GEM support"
> -	depends on HAVE_NET_MACB
>  	select PHYLIB
>  	---help---
>  	  The Cadence MACB ethernet interface is found on many Atmel AT32 and
> -- 
> 1.7.12.4
> 

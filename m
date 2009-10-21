From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 21 Oct 2009 17:26:53 +0200
Subject: [PATCH] at91: at91sam9g20ek modify dual slot evaluation kit
In-Reply-To: <1256049173-17373-1-git-send-email-nicolas.ferre@atmel.com>
References: <1256049173-17373-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20091021152653.GF19714@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +	  that embeds only one SD/MMC slot.
> +
> +config MACH_AT91SAM9G20EK_2MMC
> +	bool "Atmel AT91SAM9G20-EK Evaluation Kit with 2 SD/MMC Slots"
> +	depends on ARCH_AT91SAM9G20
> +	help
> +	  Select this if you are using an Atmel AT91SAM9G20-EK Evaluation Kit
> +	  with 2 SD/MMC Slots. This is the case for AT91SAM9G20-EK rev. C and
> +	  onwards.
>  
>  config MACH_CPU9G20
>  	bool "Eukrea CPU9G20 board"
> @@ -392,7 +394,7 @@ config MTD_AT91_DATAFLASH_CARD
>  
>  config MTD_NAND_ATMEL_BUSWIDTH_16
>  	bool "Enable 16-bit data bus interface to NAND flash"
> -	depends on (MACH_AT91SAM9260EK || MACH_AT91SAM9261EK || MACH_AT91SAM9G10EK || MACH_AT91SAM9263EK || MACH_AT91SAM9G20EK || MACH_AT91SAM9G45EKES || MACH_AT91CAP9ADK)
> +	depends on (MACH_AT91SAM9260EK || MACH_AT91SAM9261EK || MACH_AT91SAM9G10EK || MACH_AT91SAM9263EK || MACH_AT91SAM9G20EK || MACH_AT91SAM9G20EK_2MMC || MACH_AT91SAM9G45EKES || MACH_AT91CAP9ADK)
it's time to replace this by select it at machine config state

> @@ -254,7 +257,11 @@ static void __init ek_board_init(void)
>  	/* Ethernet */
>  	at91_add_device_eth(&ek_macb_data);
>  	/* MMC */
> +#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
>  	at91_add_device_mci(0, &ek_mmc_data);
> +#else
> +	at91_add_device_mmc(0, &ek_mmc_data);
> +#endif
do we really need to do this choice at board level?

Best Regards,
J.

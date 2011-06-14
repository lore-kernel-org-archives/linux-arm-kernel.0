From: tony@atomide.com (Tony Lindgren)
Date: Tue, 14 Jun 2011 05:34:00 -0700
Subject: [PATCH] omap3evm: Add Mistral WL12XX config support
In-Reply-To: <1308053788-25937-1-git-send-email-shahar@wizery.com>
References: <y>
 <1308053788-25937-1-git-send-email-shahar@wizery.com>
Message-ID: <20110614123359.GB23145@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shahar Lev <shahar@wizery.com> [110614 05:12]:
>  
> +config OMAP3EVM_MISTRAL_WL12XX
> +	bool "Enable Mistral WL12XX daughter board support"
> +	depends on MACH_OMAP3EVM
> +	help
> +	  Support for the Mistral WL12XX daughter board.
> +	  This extension board which supports both WLAN and Bluetooth.
> +	  Specifically, for WL1271, more info can be found at
> +	  http://mistralsolutions.com/component/jumi/Download_Common_Code.html?docid=298
> +
> +config OMAP3EVM_MISTRAL_WL12XX_REFCLOCK
> +	int "Ref clock value"
> +	range 0 5
> +	depends on OMAP3EVM_MISTRAL_WL12XX
> +	default 2
> +	help
> +	  Set ref clock value for the Mistral WL12XX daughter board.
> +	  Select 0 for 19.2 MHz.
> +	  Select 1 for 26 MHz.
> +	  Select 2 for 38.4 MHz.
> +	  Select 3 for 52 MHz.
> +	  Select 4 for 38.4 MHz, XTAL.
> +	  Select 5 for 26 MHz, XTAL.
> +

This your should try to remove as it won't work nicely for supporting
various boards with the same kernel as we already do with
omap2plus_defconfig.

Can you somehow detect the daughter board dynamically and then
set the flags?

Tony

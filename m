From: tony@atomide.com (Tony Lindgren)
Date: Wed, 4 May 2011 02:55:46 -0700
Subject: [PATCH v2 07/12] OMAP: Serial: Allow UART parameters to be
	configured from board file
In-Reply-To: <1304080796-625-8-git-send-email-govindraj.raja@ti.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
	<1304080796-625-8-git-send-email-govindraj.raja@ti.com>
Message-ID: <20110504095546.GY2092@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Govindraj.R <govindraj.raja@ti.com> [110429 05:39]:
> @@ -250,7 +251,7 @@ static void __init omap_2430sdp_init(void)
>  	omap2430_i2c_init();
>  
>  	platform_add_devices(sdp2430_devices, ARRAY_SIZE(sdp2430_devices));
> -	omap_serial_init();
> +	omap_serial_init(NULL);
>  	omap2_hsmmc_init(mmc);
>  	omap2_usbfs_init(&sdp2430_usb_config);
...
  
>  static inline void board_serial_init(void)
>  {
> -	omap_serial_init();
> +	omap_serial_init(NULL);
>  }

This change seems like "crazy churn" and probably not needed
if it's always null. Boards using platform_data can use
omap_serial_init_port instead, right?  

Tony

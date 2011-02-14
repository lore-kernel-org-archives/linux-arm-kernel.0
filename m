From: khilman@ti.com (Kevin Hilman)
Date: Mon, 14 Feb 2011 15:27:35 -0800
Subject: [PATCH RESEND v6 2/4] TI816X: Update common OMAP machine specific
	sources
In-Reply-To: <1297695819-27027-1-git-send-email-hemantp@ti.com> (Hemant
	Pedanekar's message of "Mon, 14 Feb 2011 20:33:39 +0530")
References: <1297695819-27027-1-git-send-email-hemantp@ti.com>
Message-ID: <87tyg6xkm0.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hemant Pedanekar <hemantp@ti.com> writes:

[...]

> @@ -402,7 +422,7 @@ void __init omap2_init_common_devices(struct omap_sdrc_params *sdrc_cs0,
>  
>  	omap_hwmod_late_init();
>  
> -	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
> +	if (omap3_has_sdrc()) {
>  		omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
>  		_omap2_init_reprogram_sdrc();
>  	}

At first glance, this one doesn't look quite right.  Will 
omap3_has_sdrc()  be true on 24xx?   Please confirm.

Kevin

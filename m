From: tony@atomide.com (Tony Lindgren)
Date: Fri, 4 May 2012 15:51:54 -0700
Subject: [PATCH 07/13] ARM: OMAP5: l3: Add l3 error handler support for
 omap5.
In-Reply-To: <1336029982-31898-8-git-send-email-r.sricharan@ti.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
 <1336029982-31898-8-git-send-email-r.sricharan@ti.com>
Message-ID: <20120504225153.GZ5613@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* R Sricharan <r.sricharan@ti.com> [120503 00:30]:
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -85,7 +85,7 @@ static int __init omap4_l3_init(void)
>  	 * To avoid code running on other OMAPs in
>  	 * multi-omap builds
>  	 */
> -	if (!(cpu_is_omap44xx()))
> +	if ((!(cpu_is_omap44xx())) && (!cpu_is_omap54xx()))
>  		return -ENODEV;
>  
>  	for (i = 0; i < L3_MODULES; i++) {

Isn't there some unnecessary parens here?

Tony

From: khilman@ti.com (Kevin Hilman)
Date: Mon, 26 Sep 2011 11:45:58 -0700
Subject: [PATCH-V3 2/4] arm:omap:am33xx: Update common OMAP machine
	specific sources
In-Reply-To: <1316529142-27564-3-git-send-email-hvaibhav@ti.com>
	(hvaibhav@ti.com's message of "Tue, 20 Sep 2011 20:02:20 +0530")
References: <hvaibhav@ti.com>
	<1316529142-27564-3-git-send-email-hvaibhav@ti.com>
Message-ID: <87fwjjcfbt.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<hvaibhav@ti.com> writes:

> From: Afzal Mohammed <afzal@ti.com>
>
> This patch updates the common machine specific source files for
> support for AM33XX/AM335x with cpu type, macros for identification of
> AM33XX/AM335X device.
>
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>

[...]

> @@ -3576,7 +3579,8 @@ int __init omap3xxx_clk_init(void)
>  	 * Lock DPLL5 -- here only until other device init code can
>  	 * handle this
>  	 */
> -	if (!cpu_is_ti816x() && (omap_rev() >= OMAP3430_REV_ES2_0))
> +	if (!cpu_is_ti816x() && !cpu_is_am33xx() &&
> +			(omap_rev() >= OMAP3430_REV_ES2_0))
>  		omap3_clk_lock_dpll5();

This is getting ugly.  

Instead of continuing to expand this if-list, I think it's time for a
new feature-flag for whether or not an SoC has DPLL5 instead.

Kevin

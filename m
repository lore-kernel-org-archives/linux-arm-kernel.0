From: khilman@ti.com (Kevin Hilman)
Date: Mon, 12 Sep 2011 14:12:55 -0700
Subject: [PATCH 16/25] OMAP4: PM: Program CPU1 to hit OFF when off-lined
In-Reply-To: <1315144466-9395-17-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Sun, 4 Sep 2011 19:24:17 +0530")
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-17-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <87mxe9ea7c.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> Program non-boot CPUs to hit lowest supported power state
> when it is off-lined using cpu hotplug framework.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>

[...]

> @@ -39,15 +43,15 @@ void platform_cpu_die(unsigned int cpu)
>  	 * we're ready for shutdown now, so do it
>  	 */
>  	if (omap_modify_auxcoreboot0(0x0, 0x200) != 0x0)
> -		printk(KERN_CRIT "Secure clear status failed\n");
> +		pr_err("Secure clear status failed\n");

nit: pr_crit() exists if you want to keep the same level.  Or did you
lower the level on purpose?

Kevin

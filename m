From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 11 Feb 2014 12:20:38 -0800
Subject: [PATCH v2 07/11] watchdog: xilinx: Use of_property_read_u32
In-Reply-To: <7aa6e41032ebad0ffb2e1df20beb4f00e38d29e2.1392101734.git.michal.simek@xilinx.com>
References: <f298edd222c57b0ce1ebad3ae50c3f715406c631.1392101734.git.michal.simek@xilinx.com>
 <7aa6e41032ebad0ffb2e1df20beb4f00e38d29e2.1392101734.git.michal.simek@xilinx.com>
Message-ID: <20140211202038.GC11798@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 07:55:50AM +0100, Michal Simek wrote:
> Use of_property_read_u32 functions to clean probe function.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
[ ... ]

> +
> +	if (enable_once)
>  		watchdog_set_nowayout(xilinx_wdt_wdd, true);
> -	}

	watchdog_set_nowayout(xilinx_wdt_wdd, enable_once);

would probably do as well (the function checks the flag as well).

Nitpick, so

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

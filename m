From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Apr 2012 11:40:01 +0000
Subject: [PATCH 5/8] MXS: Add USB PHY driver
In-Reply-To: <1334657751-27678-6-git-send-email-marex@denx.de>
References: <1334657751-27678-1-git-send-email-marex@denx.de>
 <1334657751-27678-6-git-send-email-marex@denx.de>
Message-ID: <201204191140.02112.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 April 2012, Marek Vasut wrote:
> + * PHY must be registered via subsys_initcall to get it running before EHCI
> + * controller driver.
> + */
> +subsys_initcall(mxs_phy_init);
> +module_exit(mxs_phy_exit);

I think this can be a regular module_init() now, if you change the main
driver to call an exported function from here that checks if the phy
has been probed, so you can return -EPROBE_DEFER from the main
probe function to be called again later.

	Arnd

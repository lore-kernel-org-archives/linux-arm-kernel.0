From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 21 Jan 2013 17:23:08 +0000
Subject: [PATCH 10/15] mfd/vexpress: export vexpress_config_func_{put,get}
In-Reply-To: <1358788568-11137-11-git-send-email-arnd@arndb.de>
References: <1358788568-11137-1-git-send-email-arnd@arndb.de>
 <1358788568-11137-11-git-send-email-arnd@arndb.de>
Message-ID: <1358788988.6590.50.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-01-21 at 17:16 +0000, Arnd Bergmann wrote:
> The newly introduced vexpress mfd driver in linux-3.8-rc
> provides access to configuration functions, but the
> interfaces are not exported to modules, which breaks
> when the vexpress regulator driver tries to use them.
> 
> Without this patch, building allmodconfig results in:
> 
> ERROR: "__vexpress_config_func_get" [drivers/regulator/vexpress.ko] undefined!
> ERROR: "vexpress_config_func_put" [drivers/regulator/vexpress.ko] undefined!
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>

You are the third person noticing that. My bad :-(

In fact some other ones, like the *_bridge_register could do with
exporting as well... I'll get all the patches merged in my fixes branch
and send a pull request this week.

Thanks!

Pawe?

From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 12 Jan 2017 13:47:09 +0200
Subject: [PATCH 16/62] watchdog: digicolor_wdt: Convert to use device
 managed functions and other improvements
In-Reply-To: <1484091325-9199-17-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484091325-9199-17-git-send-email-linux@roeck-us.net>
Message-ID: <20170112114708.3d4chjtu3fibb7px@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter,

On Tue, Jan 10, 2017 at 03:34:33PM -0800, Guenter Roeck wrote:
> Use device managed functions to simplify error handling, reduce
> source code size, improve readability, and reduce the likelyhood of bugs.
> Other improvements as listed below.
> 
> The conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts used
> to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
> 
> - Replace 'goto l; ... l: return e;' with 'return e;'
> - Replace 'val = e; return val;' with 'return e;'
> - Drop assignments to otherwise unused variables
> - Replace 'if (e) { return expr; }' with 'if (e) return expr;'
> - Drop remove function
> - Replace of_iomap() with platform_get_resource() followed by
>   devm_ioremap_resource()
> - Drop platform_set_drvdata()
> - Replace &pdev->dev with dev if 'struct device *dev' is a declared
>   variable
> - Use devm_watchdog_register_driver() to register watchdog device
> - Replace shutdown function with call to watchdog_stop_on_reboot()
> 
> Cc: Baruch Siach <baruch@tkos.co.il>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Baruch Siach <baruch@tkos.co.il>
Tested-by: Baruch Siach <baruch@tkos.co.il>

Thanks,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

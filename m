From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 29 Nov 2013 15:18:53 +0200
Subject: [PATCH v4 0/5] Update Davinci watchdog driver
In-Reply-To: <1385556508-3935-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1385556508-3935-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <5298943D.8010608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

On 11/27/2013 02:48 PM, Ivan Khoronzhuk wrote:
> These patches are intended to update Davinci watchdog to use WDT core
> and reuse driver for keystone arch, because Keystone uses the similar
> IP like Davinci.
> 
> See Documentation:
> Davinci DM646x - http://www.ti.com/lit/ug/spruer5b/spruer5b.pdf
> Keystone - http://www.ti.com/lit/ug/sprugv5a/sprugv5a.pdf
> 
> Also:
>   - improved to support GET_TIMELEFT option.
>   - added "clocks" and "timeout-sec" properties to DT.

Do you have any additional comments to this series?

By the way patch "[PATCH] watchdog: davinci: rename platform driver to davinci-wdt"
https://lkml.org/lkml/2013/11/27/201 can be applied as before as after this series
without conflicts.

> 
> Based on
> git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git
> keystone/master
> 
> v3..v4:
> - watchdog: davinci: change driver to use WDT core
> 	reverted rename of platform driver to "davinci-wdt"
> 	as it causes a regression on Davinci platforms.
> 
[...]
> 
> Ivan Khoronzhuk (5):
>    watchdog: davinci: change driver to use WDT core
>    watchdog: davinci: use davinci_wdt_device structure to hold device
>      data
>    watchdog: davinci: add GET_TIMELEFT option support
>    watchdog: davinci: add "timeout-sec" property
>    watchdog: davinci: reuse driver for keystone arch
> 
>   .../devicetree/bindings/watchdog/davinci-wdt.txt   |   16 +-
>   drivers/watchdog/Kconfig                           |    6 +-
>   drivers/watchdog/davinci_wdt.c                     |  221 +++++++++-----------
>   3 files changed, 114 insertions(+), 129 deletions(-)
> 


Regards,
-grygorii

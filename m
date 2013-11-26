From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Tue, 26 Nov 2013 21:40:50 +0200
Subject: [PATCH v3 0/6] Update Davinci watchdog driver
In-Reply-To: <1385388285-10553-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1385388285-10553-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <5294F942.8070401@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

On 11/25/2013 04:04 PM, Ivan Khoronzhuk wrote:
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
> 
> Based on
> git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git
> keystone/master
> 

Could you confirm that regression detected in v2 of series is gone?

Also would it be acceptable if this series will go via WDT tree?
- The first patch patch in series contains changes in both
 Davinci platform & wdt driver.

> v2..v3:
> - watchdog: davinci: change driver to use WDT core
> 	removed "ti,keystone-wdt" compatible from driver
> 	renamed wdt device names for mach-davinci from
> 		"watchdog" to "davinci-wdt"
> 
> - watchdog: davinci: reuse driver for keystone arch
> 	moved "clocks" property under "Optional properties"
> 	improved decsription of "clocks" property
> 
> - arm: dts: keystone: add watchdog entry
> 	replaced "ti,keystone-wdt" compatible on
> 		 "ti,keystone-wdt","ti,davinci-wdt"
> 
> Ivan Khoronzhuk (6):
>    watchdog: davinci: change driver to use WDT core
>    watchdog: davinci: use davinci_wdt_device structure to hold device
>      data
>    watchdog: davinci: add GET_TIMELEFT option support
>    watchdog: davinci: add "timeout-sec" property
>    watchdog: davinci: reuse driver for keystone arch
>    arm: dts: keystone: add watchdog entry
> 
>   .../devicetree/bindings/watchdog/davinci-wdt.txt   |   16 +-
>   arch/arm/boot/dts/keystone.dtsi                    |    6 +
>   arch/arm/mach-davinci/da8xx-dt.c                   |    2 +-
>   arch/arm/mach-davinci/devices-da8xx.c              |    4 +-
>   arch/arm/mach-davinci/devices.c                    |    2 +-
>   drivers/watchdog/Kconfig                           |    6 +-
>   drivers/watchdog/davinci_wdt.c                     |  225 +++++++++-----------
>   7 files changed, 126 insertions(+), 135 deletions(-)
> 

Thanks,
- grygorii

From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 13 Jan 2017 17:54:51 +0100
Subject: [PATCH 1/3] rtc: stm32: remove __exit annotation on remove
 callback
In-Reply-To: <20170113153311.2611510-1-arnd@arndb.de>
References: <20170113153311.2611510-1-arnd@arndb.de>
Message-ID: <20170113165451.3wsyynukd3su2tcf@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/01/2017 at 16:32:51 +0100, Arnd Bergmann wrote :
> The remove function can be called at runtime for a manual 'unbind'
> operation and must not be left out from a built-in driver, as kbuild
> complains:
> 
> `stm32_rtc_remove' referenced in section `.data.stm32_rtc_driver' of drivers/rtc/rtc-stm32.o: defined in discarded section `.exit.text' of drivers/rtc/rtc-stm32.o
> 
> This removes the extraneous annotation.
> 
> Fixes: 4e64350f42e2 ("rtc: add STM32 RTC driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/rtc/rtc-stm32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

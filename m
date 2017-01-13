From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 13 Jan 2017 17:55:01 +0100
Subject: [PATCH 2/3] rtc: stm32: fix building without CONFIG_OF
In-Reply-To: <20170113153311.2611510-2-arnd@arndb.de>
References: <20170113153311.2611510-1-arnd@arndb.de>
 <20170113153311.2611510-2-arnd@arndb.de>
Message-ID: <20170113165501.s7qlkrhcpusfnm2s@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/01/2017 at 16:32:52 +0100, Arnd Bergmann wrote :
> The new driver has a stray #ifdef in it that causes a build error:
> 
> drivers/rtc/rtc-stm32.c:718:21: error: 'stm32_rtc_of_match' undeclared here (not in a function); did you mean 'stm32_rtc_pm_ops'?
> 
> As the #ifdef serves no purpose here, let's just remove it.
> 
> Fixes: 4e64350f42e2 ("rtc: add STM32 RTC driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/rtc/rtc-stm32.c | 2 --
>  1 file changed, 2 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

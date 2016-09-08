From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Sep 2016 22:22:14 +0200
Subject: [RFC 1/7] Make Hi3620 explicit, remove wildcards
In-Reply-To: <df45ed73-0f7a-89d0-7cc5-5b6549f2b0f9@gmail.com>
References: <20160908172346.27506-1-netz.kernel@gmail.com>
 <4234280.g2uciTKcvR@wuerfel> <df45ed73-0f7a-89d0-7cc5-5b6549f2b0f9@gmail.com>
Message-ID: <6260903.qUKuQuTBEX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 8, 2016 3:12:26 PM CEST Marty Plummer wrote:
> So, in this case it should be one single patch? Geeze this is hella
> complicated to just get a name changed 

Yes and yes. Sometimes it's easier to leave an slightly misleading
name than to change it. ;-)

If there is any relation between Hi3620 and Hi3520, we could also
decide to use the "HI3xxx" name for both after all, and just
change the Kconfig files like


config ARCH_HI3xxx
        bool "Hisilicon Hi36xx family"
        depends on ARCH_MULTI_V5 || ARCH_MULTI_V6 || ARCH_MULTI_V7
        select CACHE_L2X0 if CPU_V7
        select HAVE_ARM_SCU if SMP

...
        config DEBUG_HI3520_UART
                bool "Hisilicon HI3520 Debug UART"
                depends on ARCH_HI3xxx
                select DEBUG_UART_PL01X
                help
                  Say Y here if you want kernel low-level debugging support

        config DEBUG_HI3620_UART
                bool "Hisilicon HI3620 Debug UART"
                depends on ARCH_HI3xxx
                select DEBUG_UART_PL01X
                help
                  Say Y here if you want kernel low-level debugging support

	Arnd

From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Tue, 17 Nov 2015 15:48:32 +0200
Subject: [PATCH] stm: select CONFIG_SRCU
In-Reply-To: <12747713.N26XusNZpW@wuerfel>
References: <12747713.N26XusNZpW@wuerfel>
Message-ID: <877flgg2j3.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> The newly added STM code uses SRCU, but does not ensure that
> this code is part of the kernel:
>
> drivers/built-in.o: In function `stm_source_link_show':
> include/linux/srcu.h:221: undefined reference to `__srcu_read_lock'
> include/linux/srcu.h:238: undefined reference to `__srcu_read_unlock'
> drivers/built-in.o: In function `stm_source_link_drop':
> include/linux/srcu.h:221: undefined reference to `__srcu_read_lock'
> include/linux/srcu.h:238: undefined reference to `__srcu_read_unlock'
>
> This adds a Kconfig 'select' statement like all the other SRCU using
> drivers have.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 7bd1d4093c2f ("stm class: Introduce an abstraction for System Trace Module devices")

Thanks!

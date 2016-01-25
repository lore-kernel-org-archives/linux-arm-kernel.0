From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Mon, 25 Jan 2016 18:17:58 +0200
Subject: [PATCH] stm: add proper dependencies on the subsystem
In-Reply-To: <1453737579-1960217-1-git-send-email-arnd@arndb.de>
References: <1453737579-1960217-1-git-send-email-arnd@arndb.de>
Message-ID: <871t95hbux.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> As several people have pointed out, the Kconfig dependencies for
> stm are confusing, because you can enable the individual features
> even when the subsystem itself is disabled.
>
> It turns out that randconfig tests even show the a build-time
> bug because of this:
>
> drivers/hwtracing/stm/built-in.o: In function `dummy_stm_init':
> drivers/hwtracing/stm/dummy_stm.c:53: undefined reference to `stm_register_device'
> drivers/hwtracing/stm/built-in.o: In function `dummy_stm_exit':
> drivers/hwtracing/stm/dummy_stm.c:58: undefined reference to `stm_unregister_device'
> drivers/hwtracing/stm/built-in.o:(.debug_addr+0x14): undefined reference to `stm_register_device'
> drivers/hwtracing/stm/built-in.o:(.debug_addr+0x1c): undefined reference to `stm_unregister_device'
>
> This adds the missing 'depends on STM' lines.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 2c41538191e1 ("stm class: dummy_stm: Add dummy driver for testing stm class")

http://marc.info/?l=linux-kernel&m=144680658616967

Unfortunately I wasn't able to get any fixes in 4.4 or anywhere else so
far.

Thanks,
--
Alex

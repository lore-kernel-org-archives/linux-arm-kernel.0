From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Jul 2011 14:45:00 +0200
Subject: [PATCH V3 3/4] ARM: mpcore_wdt: Fix WDIOC_SETOPTIONS handling
In-Reply-To: <1310041396-2461-3-git-send-email-vkuzmichev@mvista.com>
References: <1310041339-2348-1-git-send-email-vkuzmichev@mvista.com>
	<1310041396-2461-3-git-send-email-vkuzmichev@mvista.com>
Message-ID: <201107071445.00560.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 July 2011, Vitaly Kuzmichev wrote:
> 
> According to the include/linux/watchdog.h WDIOC_SETOPTIONS is
> classified as 'read from device' ioctl call:
>   #define WDIOC_SETOPTIONS        _IOR(WATCHDOG_IOCTL_BASE, 4, int)
> 
> However, the driver 'mpcore_wdt' performs 'copy_from_user' only if
> _IOC_WRITE is set, thus the local variable 'uarg' which is used in
> WDIOC_SETOPTIONS handling remains uninitialized.
> 
> The proper way to fix this is to bind WDIOC_SETOPTIONS to _IOW,
> but this will break compatibility.
> So adding additional condition for performing 'copy_from_user'.
> 
> Signed-off-by: Vitaly Kuzmichev <vkuzmichev@mvista.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

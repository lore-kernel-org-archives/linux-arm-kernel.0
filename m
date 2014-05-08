From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 8 May 2014 09:42:47 -0700
Subject: [PATCH] watchdog: iop_wdt only builds for mach-iop13xx
In-Reply-To: <1399560990-1402858-8-git-send-email-arnd@arndb.de>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-8-git-send-email-arnd@arndb.de>
Message-ID: <20140508164247.GB22224@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 08, 2014 at 04:56:19PM +0200, Arnd Bergmann wrote:
> All three iop variants we support in Linux (iop32x, iop33x and
> iop13xx) seem to have support for the watchdog hardware, but this
> driver fails to build for the first two of these because it
> uses the IOP13XX_WDTCR_IB_RESET macro that is only defined for
> iop13xx.
> 
> This clarifies the dependency in Kconfig to avoid randconfig
> build errors. It is unlikely that anyone will ever miss support
> for this driver on the ancient iop3xx platforms, so we don't
> need to bother trying to fix it properly.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: linux-watchdog at vger.kernel.org

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

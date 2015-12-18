From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Dec 2015 14:16:06 +0100
Subject: [PATCH v2] serial: 8250: of: Fix the driver and actually compile
 the 8250_of
In-Reply-To: <1450443649-31654-1-git-send-email-peter.ujfalusi@ti.com>
References: <1450443649-31654-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <3295738.CvTDrXdGbt@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 December 2015 15:00:49 Peter Ujfalusi wrote:
> The 8250_of never compiled since in the Kconfig we have SERIAL_OF_PLATFORM
> but in the makefile we expect to have SERIAL_8250_OF...
> 
> When the 8250_of.c is actually compiled we will have two errors:
> missing linux/nwpserial.h and 8250/8250.h.
> Fix those as well at the same time when enable the compilation of the
> driver.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Fixes: afd7f88f1577 ("serial: 8250: move of_serial code to 8250 directory")
> CC: Arnd Bergmann <arnd@arndb.de>
> 

Thanks for fixing this, and sorry for the mess.

Acked-by: Arnd Bergmann <arnd@arndb.de>

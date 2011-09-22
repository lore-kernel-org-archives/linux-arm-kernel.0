From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 22 Sep 2011 14:53:52 +0100
Subject: Samsung GPIO changes break boot on Cragganmore
Message-ID: <20110922135351.GC5173@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Something in the recent GPIO changes have broken the boot for me on
Cragganmore (S3C6410 based) systems.  The boot dies before any console
output is produced so it's hard to isolate exactly what went wrong but
backing out:

   5ec7414 ARM: SAMSUNG: Remove useless Samsung GPIO related CONFIGs
   7c15788 ARM: SAMSUNG: Update the name of regarding Samsung GPIO
   bedcda6 gpio/samsung: gpio-samsung.c to support Samsung GPIOs

fixes the system boot for me.  The diff is rather substantial so it's
hard to check by eyeball unfortunately.

Thanks,
Mark

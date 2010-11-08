From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 08 Nov 2010 16:15:55 +0900
Subject: Build error with s3c2410_defconfig
Message-ID: <001001cb7f14$cace6af0$606b40d0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vasily,

Now, happens following build error due to commit
14477095abc661a9f195ca4733bb739c54794b32 'ARM: h1940: Use gpiolib for latch
access' with s3c2410_defconfig.

drivers/leds/leds-h1940.c: In function 'h1940_greenled_set':
drivers/leds/leds-h1940.c:33: error: implicit declaration of function
'h1940_latch_control'

The h1940_greenled_set(), h1940_redled_set(), and h1940_blueled_set() in
drivers/leds/leds-h1940.c call h1940_latch_control()...

Need to fix it up.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 8 Nov 2010 10:59:02 +0200
Subject: Build error with s3c2410_defconfig
In-Reply-To: <001001cb7f14$cace6af0$606b40d0$%kim@samsung.com>
References: <001001cb7f14$cace6af0$606b40d0$%kim@samsung.com>
Message-ID: <201011081059.03095.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 November 2010 09:15:55 Kukjin Kim wrote:
> Hi Vasily,
> 
> Now, happens following build error due to commit
> 14477095abc661a9f195ca4733bb739c54794b32 'ARM: h1940: Use gpiolib for latch
> access' with s3c2410_defconfig.
> 
> drivers/leds/leds-h1940.c: In function 'h1940_greenled_set':
> drivers/leds/leds-h1940.c:33: error: implicit declaration of function
> 'h1940_latch_control'
> 
> The h1940_greenled_set(), h1940_redled_set(), and h1940_blueled_set() in
> drivers/leds/leds-h1940.c call h1940_latch_control()...
> 
> Need to fix it up.
> 
> Thanks.

Hi, I'm aware of a problem, will fix and send patch tonight (however, 
h1940_leds driver should be marked as deprecated)

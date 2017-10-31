From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Tue, 31 Oct 2017 12:19:48 +0200
Subject: [PATCH v4 7/7] i2c: remove legacy integer scl/sda gpio for
 recovery
In-Reply-To: <1509435239-64848-8-git-send-email-preid@electromag.com.au>
References: <1509435239-64848-1-git-send-email-preid@electromag.com.au>
 <1509435239-64848-8-git-send-email-preid@electromag.com.au>
Message-ID: <1509445188.10233.110.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-10-31 at 15:33 +0800, Phil Reid wrote:
> Remove all reference to code related to using integer based ids for
> scl/sda gpio for bus recovery. All in tree drivers are now using the
> gpio descriptors to specific the required gpios.

> - * @scl_gpio: gpio number of the SCL line. Only required for GPIO
> recovery.
> - * @sda_gpio: gpio number of the SDA line. Only required for GPIO
> recovery.
> + * @scl_gpiod: gpiod of the SCL line. Only required for GPIO
> recovery.
> + * @sda_gpiod: gpiod of the SDA line. Only required for GPIO
> recovery.

Ah, missed comment here.

0day kbuild bot now warns if we add field w/o kernel doc description.

I would suggest to add the descriptions in the same patch which brings
new fields and here just remove old ones.

>  	/* gpio recovery */
> -	int scl_gpio;
> -	int sda_gpio;

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

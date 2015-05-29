From: yvo@apm.com (Y Vo)
Date: Fri, 29 May 2015 16:42:00 +0700
Subject: [PATCH v0] gpio: xgene: add ACPI support for APM X-Gene GPIO
 standby driver
In-Reply-To: <20150529092501.GI1747@lahna.fi.intel.com>
References: <1432795588-17476-1-git-send-email-yvo@apm.com>
 <20150529092501.GI1747@lahna.fi.intel.com>
Message-ID: <CAL4ahLdjea-K10BUJYQjVJmy+AiiJQH6VJKdYKayr=7hHDTbcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 29, 2015 at 4:25 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Thu, May 28, 2015 at 01:46:28PM +0700, Y Vo wrote:
>> +#ifdef CONFIG_ACPI
>> +     if (priv->nirq > 0) {
>> +             /* Register interrupt handlers for gpio signaled acpi events */
>> +             acpi_gpiochip_request_interrupts(&priv->bgc.gc);
>> +     }
>> +#endif
>
> You don't need to check CONFIG_ACPI as acpi_gpiochip_request_interrupts()
> will be stubbed out if !CONFIG_ACPI.
I will remove this check.
>
> Should you call acpi_gpiochip_free_interrupts() somewhere to unregister
> the interrupts as well?
I will add this to xgene_gpio_sb_remove function.

>
> Even better if you can switch your driver to use GPIOLIB_IRQCHIP all
> this is done automatically for you.

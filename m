From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Mon, 20 Dec 2010 15:49:05 -0800
Subject: [PATCH v1] OMAP: GPIO: Correct IP version message during boot
In-Reply-To: <AANLkTimUrDAR1Wc4oJf74iYKhpxHKkGKLQOEuSNpcBXo@mail.gmail.com>
	(Charulatha Varadarajan's message of "Fri, 17 Dec 2010 09:15:03
	-0500")
References: <1292508586-21651-1-git-send-email-charu@ti.com>
	<8739pxhdcz.fsf@deeprootsystems.com>
	<AANLkTimUrDAR1Wc4oJf74iYKhpxHKkGKLQOEuSNpcBXo@mail.gmail.com>
Message-ID: <87zks02efi.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Varadarajan, Charulatha" <charu@ti.com> writes:

> Kevin,
>
> On Thu, Dec 16, 2010 at 11:49, Kevin Hilman <khilman@deeprootsystems.com> wrote:
>> "Varadarajan, Charulatha" <charu@ti.com> writes:
>>
>>> With the commit 9a748053f5f58a77cd71864f1d7b804175b0e47d whose subject is
>>> "OMAP: GPIO: Make omap_gpio_show_rev bank specific" (see [1]),
>>> the IP version information for all the banks are shown during bootup,
>>> but it does not show the bank number.
>>>
>>> Use dev_info instead of printk in omap_gpio_show_rev() so that the
>>> bank id is displayed along with the IP version
>>>
>>> [1] http://www.spinics.net/lists/arm-kernel/msg105872.html
>>
>> A related question, the commit above also changed the GPIO revision
>> display from one-time to once per bank. ?Do we need to know the GPIO HW
>> revision for each bank, or can we assume it's the same for all banks?
>
> The IP version is the same for all the gpio banks in all OMAP2+ CPUs.
> But I am not sure about OMAP16xx.
>

OK, then I suggest we switch this back to just printing the GPIO
revision once.   Maybe after all banks are found, just print the
revision for bank 1.

Kevin

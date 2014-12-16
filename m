From: rjui@broadcom.com (Ray Jui)
Date: Mon, 15 Dec 2014 16:08:41 -0800
Subject: [PATCH v5 1/3] gpio: Cygnus: define Broadcom Cygnus GPIO binding
In-Reply-To: <2063145.N1Hk6vVF2S@wuerfel>
References: <1418342706-14755-2-git-send-email-rjui@broadcom.com>
 <1628217.66frkAqHMc@wuerfel> <548F5433.5090901@broadcom.com>
 <2063145.N1Hk6vVF2S@wuerfel>
Message-ID: <548F7809.1020303@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/15/2014 1:57 PM, Arnd Bergmann wrote:
> On Monday 15 December 2014 13:35:47 Ray Jui wrote:
>>
>> Like I said previously, dynamic GPIO allocation works fine in the
>> kernel, as long as all of our GPIO clients in the kernel use gpiod based
>> API, which is what we will enforce going forward. The only problem is
>> with some of our customers who use GPIO through sysfs and expect fixed
>> global GPIO numbers. Thinking about this more, it's probably not that
>> difficult to add a script for those customers to convert/map the GPIO
>> numbers based on readings parsed from sysfs, so I guess that's fine.
>>
>
> I think we discussed the user space interface a number of times
> in the past, but I forgot the outcome. Either there is already
> a way to name gpio lines uniquely in sysfs, or there should be
> one.
>
> Can you reach the gpio interfaces using /sys/devices/0001234.bus/1234566.gpiocontroller/...?
>
> 	Arnd
>
We use entries under /sys/class/gpio/ to control GPIOs. All base, label, 
and ngpio info specific to a GPIO controller can be found there.

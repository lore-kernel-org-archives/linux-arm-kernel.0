From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 15 Dec 2014 22:57:36 +0100
Subject: [PATCH v5 1/3] gpio: Cygnus: define Broadcom Cygnus GPIO binding
In-Reply-To: <548F5433.5090901@broadcom.com>
References: <1418342706-14755-2-git-send-email-rjui@broadcom.com>
 <1628217.66frkAqHMc@wuerfel> <548F5433.5090901@broadcom.com>
Message-ID: <2063145.N1Hk6vVF2S@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 December 2014 13:35:47 Ray Jui wrote:
> 
> Like I said previously, dynamic GPIO allocation works fine in the 
> kernel, as long as all of our GPIO clients in the kernel use gpiod based 
> API, which is what we will enforce going forward. The only problem is 
> with some of our customers who use GPIO through sysfs and expect fixed 
> global GPIO numbers. Thinking about this more, it's probably not that 
> difficult to add a script for those customers to convert/map the GPIO 
> numbers based on readings parsed from sysfs, so I guess that's fine.
> 

I think we discussed the user space interface a number of times
in the past, but I forgot the outcome. Either there is already
a way to name gpio lines uniquely in sysfs, or there should be
one.

Can you reach the gpio interfaces using /sys/devices/0001234.bus/1234566.gpiocontroller/...? 

	Arnd

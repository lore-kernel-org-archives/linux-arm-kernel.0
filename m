From: j-keerthy@ti.com (Keerthy)
Date: Wed, 19 Jul 2017 15:28:21 +0530
Subject: [PATCH 1/4] gpio: davinci: Use devm_gpiochip_add_data in place of
 gpiochip_add_data
In-Reply-To: <20170719093722.GW29638@localhost>
References: <1500375436-9435-1-git-send-email-j-keerthy@ti.com>
 <1500375436-9435-2-git-send-email-j-keerthy@ti.com>
 <20170719093722.GW29638@localhost>
Message-ID: <32f70ccc-e52e-af86-87ec-f7a243d518b0@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 19 July 2017 03:07 PM, Johan Hovold wrote:
> On Tue, Jul 18, 2017 at 04:27:13PM +0530, Keerthy wrote:
>> Use the devm version of gpiochip_add_data and pass on the
>> return value. Reset the static variables to 0 before returning.
> 
> You need to describe not just what you do, but also why you it. In this
> case, your fixing memory leaks and the gpio chip being left registered
> if this driver is unbound.

Sure i can add more description as mentioned above.

> 
> Johan
> 

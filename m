From: mikedunn@newsguy.com (Mike Dunn)
Date: Mon, 07 Jan 2013 08:40:01 -0800
Subject: [PATCH 3/4] ALSA: pxa27x: ac97 controller driver requests gpio
In-Reply-To: <50EAEBD8.40002@compulab.co.il>
References: <1357499640-13871-1-git-send-email-mikedunn@newsguy.com>
 <1357499640-13871-4-git-send-email-mikedunn@newsguy.com>
 <50EA9710.3060107@compulab.co.il> <50EAD73C.3050401@newsguy.com>
 <50EAEBD8.40002@compulab.co.il>
Message-ID: <50EAFA61.7000209@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/07/2013 07:38 AM, Igor Grinberg wrote:
> On 01/07/13 16:10, Mike Dunn wrote:


[..]


>>
>> Well, I won't make a fuss on this point, but with code that runs very
>> infrequently, I thought that the cost of a call to gpio_direction_output() was
>> worth the clarity and insurance.
> 
> This is not about how frequent the code runs, but the fact that the arch code
> relies on sound code (outside of arch) to request the GPIO for it.
> I would recommend to place the GPIO request call along with the
> direction/value calls - in the same subsystem.


OK.  This is in some shared pxa code called by the ac97 driver during
initialization, where I earlier placed the gpio_request() calls only.


> 
> Also, the patch ordering is not good:
> patch 2 drives the GPIO, and patch 3 requests it,
> whereas it should be the other way around, so I would recommend to
> combine both into one.


Agreed.

Thanks,
Mike

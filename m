From: tony@atomide.com (Tony Lindgren)
Date: Mon, 15 Feb 2016 08:01:15 -0800
Subject: GPIO regression in Linux next caused by syscon change
In-Reply-To: <CA+gwMccZeYimupmGsMX8YbNH9eEA6=Xi=rupciubBwzktfjvBA@mail.gmail.com>
References: <20160213002643.GQ19432@atomide.com>
 <20160213004935.GR19432@atomide.com>
 <CA+gwMccZeYimupmGsMX8YbNH9eEA6=Xi=rupciubBwzktfjvBA@mail.gmail.com>
Message-ID: <20160215160115.GU19432@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Philipp Zabel <philipp.zabel@gmail.com> [160214 11:24]:
> I've just replaced the of_iomap() call with an open coded version,
> calling of_address_to_resource() and ioremap() directly. That was
> needed so I can use the struct resource returned by
> of_address_to_resource() to set the syscon_config.max_register. I
> don't see where this could cause resource overlap. Does just setting
> syscon_config.max_register to zero again make the problem disappear?

Yes commenting out the syscon_config.max_register line in your patch
makes things work again.

So what does that tell us about the problem?

Regards,

Tony

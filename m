From: avictor.za@gmail.com (Andrew Victor)
Date: Thu, 28 Apr 2011 13:23:03 +0200
Subject: [PATCH 09/14] at91: switch pit timer to early platform devices
In-Reply-To: <1303756284-26529-9-git-send-email-plagnioj@jcrosoft.com>
References: <20110425180847.GA12904@game.jcrosoft.org>
	<1303756284-26529-9-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <BANLkTi=2_9Xcz45jyOnbxv6xwC2R5U__VA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

> this will allow to specify the resources per soc
>
> as the 5series use a different start address for the pit

I really don't see the fascination with early platform_devices for timer.
A sys_timer is initialized way earlier, and there are surely cleaner
ways to just pass a "base address" through to the driver.
The interrupt is always AT91_ID_SYS on all chips, so there is no point
making it configurable.


Regards,
  Andrew Victor

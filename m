From: guy.shapiro@mobi-wize.com (Guy Shapiro)
Date: Sun, 29 Jan 2017 14:04:00 +0200
Subject: syscon-poweroff: add a mask property
Message-ID: <71309f45-0f6c-a7af-eb01-59400f0c93a1@mobi-wize.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The syscon-poweroff driver powers off the machine by writing a value to
a register. Both the register and the value are configured via the
device tree.

I encountered a situation where I need to mask the written value - some
values of the register must remain unchanged during the power-down.
(This is required to turn on the i.mx6ul using the RTC. See [1] for more
details.)

Unfortunately, the property of the register value is currently named
mask, so we can't just add a "mask" property.

The solutions I could think of:
1) Add a new mask property and name it "mask_mask" or something like
that.
2) Create a new "syscon-masked-poweroff" driver that will have value and
mask properties.

What do you think?


[1] https://www.spinics.net/lists/arm-kernel/msg555580.html

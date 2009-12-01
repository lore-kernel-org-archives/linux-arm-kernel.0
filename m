From: derkling@gmail.com (Patrick Bellasi)
Date: Tue, 1 Dec 2009 13:45:27 +0100
Subject: [PATCH 1/3] AT91: update at91_eth_data for ETX2-3 on PA10-11
In-Reply-To: <1CD05B980C94AC408B37C82BBABAA3E6129304A4@mtsexchange.dc.multitech.prv>
References: <1CD05B980C94AC408B37C82BBABAA3E6129304A4@mtsexchange.dc.multitech.prv>
Message-ID: <aa8983610912010445k2b533770yc057afba1ec6c3ab@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2009 at 10:04 PM, Tim Barr <tbarr@multitech.com> wrote:
> I see a bigger problem here. It is more of an issue of how to properly
> handle signals that have more than one pin assignment option.
Yes, that's the point.
Moreover, according to my own (perhaps limited) knowledge, at least
the at91 machine dependent code provides a good glue code almost only
for boards which are quite similar to the reference design.
The problem is that instead each SoC allows for different signal routing.

> Is there any sort of kernel design spec for this?
It would be good to have a "standard" approach for this kind of support.
Unfortunately, I thinks that every arch- and even every machine-code
use its own approach.

> As it stands now, I have to
> modify the at91sam9260devices.c file every time I change kernels,
> because some of the MII pins assigned are not the ones I use in my
> design.
The solution I proposed in the previous message requires:
1. to use some ifdef in the SoC independent <hw_block>.h header files
to extend data structures with some SoC dependent data
2. to properly handle the SoC dependent data within each <soc>_devices.c

This is a "static approach" that should be quite efficient, both in
footprint and run-time overhead, and it should also produce a
reasonably readable code, both in <hw_block>.h and in the
<soc>_devices.c

> I think that any pin that has more than one assignment option
> should be set in the structures passed by the board file.
This is another possible solution, but at least will require a lot of
code change on many different platforms... and I don't know if its
worthwhile since only few boards designs really differ from the
Atmel's reference design boards.

Regards,
Patrick

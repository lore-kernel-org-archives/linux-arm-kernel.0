From: slapinid@gmail.com (Sergey Lapin)
Date: Mon, 10 May 2010 05:33:44 +0400
Subject: OTG implementation with external transceiver on PXA270
Message-ID: <AANLkTim7lTbhu97hy3tiSXVpkQKr5X6YpU8zSUiVarca@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, all!

I try to implement external OTG transceiver on PXA270.
I just need basic device mode at the moment.

A problem is that PXA itself handles interrupt of external chip via
UDC interrupt. But I need to read my chip-specific registers
from there while I want to maintain pxa270_udc in a generic way
without cluttering it with i2c calls, so I can implement it in the
following ways:

* make chip-specific data struct global (like it is in isp1301_omap.c
and make exported function in OTG driver, enable handling of OTG interrupts
in pxa27x_udc and call that function from there.
* add API function like otg_handle_interrupt, enable handling of OTG interrupts
in pxa27x_udc and call it from there. Which seems to be less messy.

Any other suggestions? If that work is really being done somewhere,
I'd like to help with testing.

Thanks a lot,
S.

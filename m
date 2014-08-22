From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 22 Aug 2014 15:43:45 +0800
Subject: [PATCH] ARM: dts: Gateworks GW5520 support (i.MX6)
In-Reply-To: <CAJ+vNU0qJrNtZMcPGWkGOPuHmyiV+3d-OM71PGDNRmnJZCS8SQ@mail.gmail.com>
References: <1407572602-14017-1-git-send-email-tharvey@gateworks.com>
 <20140818063510.GD2114@dragon>
 <CAJ+vNU0qJrNtZMcPGWkGOPuHmyiV+3d-OM71PGDNRmnJZCS8SQ@mail.gmail.com>
Message-ID: <20140822074341.GA2540@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 19, 2014 at 08:17:03AM -0700, Tim Harvey wrote:
> Do you know of any appropriate bindings for a USB hub reset signal?
> This does get configured and used properly in the bootloader but I
> thought the common belief was that GPIO's should get configured in the
> kernel as well (and of course I will use a value other than 0x8000000
> so that its pinmuxed and padconf'd).
> 
> The PCISKT_WDIS# is a gpio that routes to the miniPCIe socket(s) WDIS#
> signal. While no kernel driver uses it I think its valuable to
> document to users such that they can export it and use it for rfkill
> of wireless devices that may be placed in those sockets. I'm not aware
> of a proper binding for an rfkill pin either.
> 
> If no bindings exist, are you saying these should be dropped and thus
> functionality hidden from a user possibly trying to use them from
> userspace through gpio-sysfs or are you saying they should be moved
> into pinctrl groups for logical grouping?

Oh, I was wondering if these GPIOs can be put into USB and PCIe
pingroup.  But if you think it doesn't make sense to do so, I'm fine
with them being in hoggrp, after all it seems we do not have a proper
binding existing for them.

Shawn

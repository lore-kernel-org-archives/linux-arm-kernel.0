From: eric@anholt.net (Eric Anholt)
Date: Mon, 14 Aug 2017 11:22:41 -0700
Subject: [PATCH] arm64: bcm2837 dts: enable bcm2708 frambuffer driver for
 the raspberry pi-3
In-Reply-To: <534636301.409284.1502451058701@mail.yahoo.com>
References: <534636301.409284.1502451058701.ref@mail.yahoo.com>
 <534636301.409284.1502451058701@mail.yahoo.com>
Message-ID: <87378uf1qm.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VOTARY GITHUB <github.raspberrypi@votarytech.com> writes:

> From 3200cb6fd787390df1bccf1bb1f7a67ca04136fd Mon Sep 17 00:00:00 2001
> From: VT-Github-Raspberrypi <github.raspberrypi@votarytech.com>
> Date: Tue, 8 Aug 2017 16:57:15 +0530
> Subject: [PATCH] arm64: bcm2837 dts: enable bcm2708 frambuffer driver for the
> ?raspberry pi-3
>
> This fb drivers to make rendering full boot up logs on the screen.
>
> Fixed: https://github.com/raspberrypi/linux/issues/2156

I don't think we should be adding DT nodes for the old, downstream-only
fbdev driver to the upstream tree.  We have nodes already for the open
source driver that directly programs the hardware, which will disable
the firmware's closed-source modesetting interfaces used by bcm2708
fbdev.  For early boot display, the proper solution is simplefb, not a
custom fbdev driver.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170814/70c00878/attachment.sig>

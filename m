From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 22 Jan 2013 12:11:00 -0300
Subject: Mirabox tree
In-Reply-To: <20130120160347.03553c4e@skate>
References: <CAD7Jr4mveEe0rbDBuBsPmBpx3m4Bat5yipB=KQV9uaG8N+KuJQ@mail.gmail.com>
 <CAD7Jr4mAeXnYfgbs61_jcpT+iVSv1YXLb0h0VxD0SwUDbgfKAA@mail.gmail.com>
 <20130119092637.1f08f752@skate>
 <CAD7Jr4m489bfQQuSNP2s_7E2nfGUMk+Tj11hfQrU+egfjbFX8g@mail.gmail.com>
 <20130119132315.73f18ba3@skate>
 <CAD7Jr4=E9qqzfaLi2RMTrX5ODLH16gUHQ2sk6t9tOc7L2Z=Gew@mail.gmail.com>
 <20130120160347.03553c4e@skate>
Message-ID: <20130122151058.GA10331@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

> On Sat, 19 Jan 2013 19:21:12 +0100, Michael Lawson wrote:
> 
> > What I found was that the sd card reader is a pretty standard device,
> > root at mirabox-debian:~# lsusb
> > Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> > Bus 001 Device 003: ID 05e3:0723 Genesys Logic, Inc. GL827L SD/MMC/MS Flash
> > Card Reader
> > Bus 001 Device 004: ID 05e3:0723 Genesys Logic, Inc. GL827L SD/MMC/MS Flash
> > Card Reader
> > Bus 001 Device 002: ID 1a40:0101 TERMINUS TECHNOLOGY INC. USB-2.0 4-Port HUB
> > Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> > 

Indeed GL827L controller is USB storage class compliant
(datasheet is publicly avaiable).
This means there's no need for an ad-hoc driver.
All you need to do is pick CONFIG_USB_STORAGE=y.

[snip]
> 
> You need the Armada 370 datasheet, which for now, is only available
> under NDA to selected companies and developers, if I'm correct.
> However, as far as USB support on Armada 370 is concerned, the patch
> series for Ezequiel Garcia that I mentioned earlier is sufficient.
> Then, it is a matter of finding or writing a device driver for the
> Genesys Logic USB device.
> 

As Thomas says, using my posted USB patches is enough to make USB
host controller work. You need these series:

http://www.spinics.net/lists/arm-kernel/msg217028.html

Now, to access your SD card you only need to select CONFIG_USB_STORAGE.

If you need some more assistance, don't hesitate in asking.

Good luck,

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com

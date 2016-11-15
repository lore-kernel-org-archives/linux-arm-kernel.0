From: kraxel@redhat.com (Gerd Hoffmann)
Date: Tue, 15 Nov 2016 11:46:50 +0100
Subject: [PATCH] ARM64: dts: bcm2837-rpi-3-b: remove incorrect pwr LED
In-Reply-To: <871sydfueq.fsf@eliezer.anholt.net>
References: <20161111173821.21491-1-eric@anholt.net>
 <741880731.428971.a2c5fd60-1b30-481e-b728-fc62c8d1c81a.open-xchange@email.1und1.de>
 <871sydfueq.fsf@eliezer.anholt.net>
Message-ID: <1479206810.32639.31.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mo, 2016-11-14 at 16:39 -0800, Eric Anholt wrote:
> Stefan Wahren <stefan.wahren@i2se.com> writes:
> 
> > Hi Eric,
> >
> > [add Gerd to CC]
> >
> >> Eric Anholt <eric@anholt.net> hat am 11. November 2016 um 18:38 geschrieben:
> >> 
> >> 
> >> From: Andrea Merello <andrea.merello@gmail.com>
> >> 
> >> We are incorrectly defining the pwr LED, attaching it to a gpio line
> >> that is wired to the Wi-Fi SDIO module (which fails due to this).
> >
> > i agree with the intention of this patch, but is the upstream kernel really
> > affected? I can't see any compatible for the Wifi interface.
> 
> The wifi isn't in the DT yet because the driver isn't merged.  Some
> progress was made on that a while ago, but people asked for more
> cleanups so it's still living out of tree.

some low-hanging fruits (codestyle mostly) are done, but more work is
needed (fix messy timeout handling, make dma work).  Didn't happed yet
due to -ENOTIME.  My current state is here:

https://www.kraxel.org/cgit/linux/log/?h=bcm2837-wifi

In case anyone wants pick it up feel free to do so (but please tell me
so we avoid duplicating work).

cheers,
  Gerd

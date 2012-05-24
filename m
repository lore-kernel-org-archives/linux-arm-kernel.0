From: svenkatr@ti.com (S, Venkatraman)
Date: Thu, 24 May 2012 15:23:57 +0530
Subject: [PATCH] Fix OMAP4 boot regression
In-Reply-To: <20120524090449.GA24486@n2100.arm.linux.org.uk>
References: <20120524090449.GA24486@n2100.arm.linux.org.uk>
Message-ID: <CANfBPZ9NrBurtTnyutqcRUg8f+GsRS3v8WHHwfPj6-npD1LUbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2012 at 2:34 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Fix a boot regression in existing kernels causing:
>
> genirq: Threaded irq requested with handler=NULL and !ONESHOT for irq XXX
>
> caused by 1c6c6952 (genirq: Reject bogus threaded irq requests).
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> --
> ?drivers/mmc/host/omap_hsmmc.c | ? ?2 +-

Thanks Russell.
The omap_hsmmc part of the change was already posted [1] and queued up
in mmc-next.

Regards,
Venkat.

[1] http://www.spinics.net/lists/linux-omap/msg70496.html

> ?drivers/rtc/rtc-twl.c ? ? ? ? | ? ?2 +-
> ?2 files changed, 2 insertions(+), 2 deletions(-)
>

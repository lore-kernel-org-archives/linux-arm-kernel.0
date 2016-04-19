From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 20 Apr 2016 00:56:55 +0200
Subject: [PATCH] rtc: ds1307: Use irq when available for wakeup-source
 device
In-Reply-To: <1461083034-9227-1-git-send-email-nm@ti.com>
References: <1461083034-9227-1-git-send-email-nm@ti.com>
Message-ID: <20160419225655.GJ29844@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/04/2016 at 11:23:54 -0500, Nishanth Menon wrote :
> With commit 8bc2a40730ec ("rtc: ds1307: add support for the
> DT property 'wakeup-source'") we lost the ability for rtc irq
> functionality for devices that are actually hooked on a real IRQ
> line and have capability to wakeup as well. This is not an expected
> behavior. So, instead of just not requesting IRQ, skip the IRQ
> requirement only if interrupts are not defined for the device.
> 
> Fixes: 8bc2a40730ec ("rtc: ds1307: add support for the DT property 'wakeup-source'")
> Reported-by: Tony Lindgren <tony@atomide.com>
> Cc: Michael Lange <linuxstuff@milaw.biz>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
>  drivers/rtc/rtc-ds1307.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 21 Feb 2015 00:33:17 +0800
Subject: [PATCH 2/2] at91sam9_wdt: Allow watchdog to reset device at early
 boot
In-Reply-To: <20150220085151.3b599de8@bbrezillon>
References: <54B53160.6060309@roeck-us.net>
 <cover.1424262664.git.timo.kokkonen@offcode.fi>
 <cover.1424262664.git.timo.kokkonen@offcode.fi>
 <6c0a3a5bcd93d18437eeed04712b4aeff201a16f.1424262664.git.timo.kokkonen@offcode.fi>
 <00B1658F-2F3A-4B90-ADCA-275770832180@jcrosoft.com>
 <20150220085151.3b599de8@bbrezillon>
Message-ID: <E7DD67EB-CA34-48EA-838D-3EBBF74CAEBD@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Feb 20, 2015, at 3:51 PM, Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
> 
> Hi Jean-Christophe,
> 
> On Fri, 20 Feb 2015 15:48:22 +0800
> Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> wrote:
> 
>> 
>>> On Feb 18, 2015, at 8:57 PM, Timo Kokkonen <timo.kokkonen@offcode.fi> wrote:
>>> 
>>> By default the driver will start a kernel timer which keeps on kicking
>>> the watchdog HW until user space has opened the watchdog
>>> device. Usually this is desirable as the watchdog HW is running by
>>> default and the user space may not have any watchdog daemon running at
>>> all.
>>> 
>>> However, on production systems it may be mandatory that also early
>>> crashes and lockups will lead to a watchdog reset, even if they happen
>>> before the user space has opened the watchdog device.
>>> 
>>> To resolve the issue, add a new device tree property
>>> "early-timeout-sec" which will let the kernel timer to ping the
>>> watchdog HW only as long as the specified timeout permits. The default
>>> is still to use kernel timer, but more strict behavior can be enabled
>>> via the device tree property.
>>> 
>>> Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
>>> ---
>>> Documentation/devicetree/bindings/watchdog/watchdog.txt | 7 +++++++
>>> drivers/watchdog/at91sam9_wdt.c                         | 9 ++++++++-
>> 
>> This should not be handled by the driver but the kernel in a generic way
> 
> Could you detail a bit more what you have in mind ?

move this timeout on the linux thread that keep alive the watchdog not in the driver

Best Regards,
J.
> 
> Best Regards,
> 
> Boris
> 
> -- 
> Boris Brezillon, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 29 Jan 2016 11:13:41 +0100
Subject: [PATCH 2/7] usb: gadget: pxa25x_udc cleanup
In-Reply-To: <1453997843-3489728-2-git-send-email-arnd@arndb.de> (Arnd
 Bergmann's message of "Thu, 28 Jan 2016 17:17:03 +0100")
References: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
 <1453997843-3489728-1-git-send-email-arnd@arndb.de>
 <1453997843-3489728-2-git-send-email-arnd@arndb.de>
Message-ID: <87r3h07kx6.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> This removes the dependency on the mach/hardware.h header file
> from the pxa25x_udc driver after the register definitions were
> already unified in the previous patch.
>
> Following the model of pxa27x_udc (and basically all other drivers
> in the kernel), we define the register numbers as offsets from
> the register base address and use accessor functions to read/write
> them.
>
> For the moment, this still leaves the direct pointer dereference
> in place, instead of using readl/writel, so this patch should
> not be changing the behavior of the driver, other than using
> ioremap() on the platform resource to replace the hardcoded
> virtual address pointers.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

It's too bad coccinelle cannot make that work more automatic, isn't it ? :)

Cheers.

--
Robert

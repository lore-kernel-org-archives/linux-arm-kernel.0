From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 29 Jan 2016 11:17:01 +0100
Subject: [PATCH 3/7] usb: gadget: pxa25x_udc: use readl/writel for mmio
In-Reply-To: <1453997843-3489728-3-git-send-email-arnd@arndb.de> (Arnd
 Bergmann's message of "Thu, 28 Jan 2016 17:17:04 +0100")
References: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
 <1453997843-3489728-1-git-send-email-arnd@arndb.de>
 <1453997843-3489728-3-git-send-email-arnd@arndb.de>
Message-ID: <87mvro7krm.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> This converts the pxa25x udc driver to use readl/writel as normal
> driver should do, rather than dereferencing __iomem pointers
> themselves.
>
> Based on the earlier preparation work, we can now also pass
> the register start in the device pointer so we no longer need
> the global variable.
>
> The unclear part here is for IXP4xx, which supports both big-endian
> and little-endian configurations. So far, the driver has done
> no byteswap in either case. I suspect that is wrong and it would
> actually need to swap in one or the other case, but I don't know
> which. It's also possible that there is some magic setting in
> the chip that makes the endianess of the MMIO register match the
> CPU, and in that case, the code actually does the right thing
> for all configurations, both before and after this patch.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
For pxa25x_udc:
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert

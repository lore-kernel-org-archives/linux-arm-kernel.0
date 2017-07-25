From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 25 Jul 2017 19:28:42 +0200
Subject: [PATCH v2] ARM: sa1100/pxa: fix MTD_XIP build
In-Reply-To: <20170725152616.4143857-1-arnd@arndb.de> (Arnd Bergmann's message
 of "Tue, 25 Jul 2017 17:25:47 +0200")
References: <20170725152616.4143857-1-arnd@arndb.de>
Message-ID: <87shhkqvcl.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> In commit 3169663ac5902 "ARM: sa11x0/pxa: convert OS timer registers
> to IOMEM", the definition of the OSCR macro was changed to be an
> __iomem pointer, but the same register is also used by the XIP
> code. This patch does the corresponding change here as well.
>
> On PXA, the IRQ register definitions were removed even earlier, in
> commit 5d284e353eb1 ("ARM: pxa: avoid accessing interrupt registers
> directly"). This patch unfortunately brings some of that back. An
> earlier version of my patch moved the code into an external function,
> which could not work for CONFIG_XIP_KERNEL+CONFIG_MTD_XIP, so this
> restores something close to the original code.
>
> Link: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/241716.html
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>
> v2: add back outer () as Robert suggested
For mach-pxa :
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert

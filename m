From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 05 Mar 2016 09:45:21 +0100
Subject: [PATCH] mtd: only use __xipram annotation when XIP_KERNEL is set
In-Reply-To: <3582240.H8v1IXn8EB@wuerfel> (Arnd Bergmann's message of "Sat, 05
 Mar 2016 01:24:36 +0100")
References: <1453736525-1959191-2-git-send-email-arnd@arndb.de>
 <20160305000225.GB55664@google.com>
 <20160305001057.GC55664@google.com> <3582240.H8v1IXn8EB@wuerfel>
Message-ID: <8737s5wbxa.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> I guess we can bring back the macros for the case that MTD_XIP and XIP_KERNEL
> are both enabled.
>
> 	Arnd
I wouldn't have ICMR and ICIP exposed to drivers, Eric's original move looks
corect to me.

On the other hand, I'm wondering if xip_irqpending(), xip_currtime() and
xip_cpu_idle() should be declared as functions in mtd-xip.h, and be part of
something like arch/arm/mach-pxa/xip.c ...

Cheers.

-- 
Robert

From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 02 Jul 2014 00:42:06 +0200
Subject: [PATCH] ARM: convert all "mov.* pc,
 reg" to "bx reg" for ARMv6+ (part1)
In-Reply-To: <E1X20mL-00083I-Sv@rmk-PC.arm.linux.org.uk> (Russell King's
 message of "Tue, 01 Jul 2014 17:19:33 +0100")
References: <E1X20mL-00083I-Sv@rmk-PC.arm.linux.org.uk>
Message-ID: <87y4wcog5d.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King <rmk+kernel@arm.linux.org.uk> writes:

> ARMv6 and greater introduced a new instruction ("bx") which can be used
> to return from function calls.  Recent CPUs perform better when the
> "bx lr" instruction is used rather than the "mov pc, lr" instruction,
> and this sequence is strongly recommended to be used by the ARM
> architecture manual (section A.4.1.1).

For ARMv5 - XScale, and more specificaly the mioa701_bootresume.S path (suspend
to RAM) :
Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert

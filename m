From: mbizon@freebox.fr (Maxime Bizon)
Date: Thu, 12 Dec 2013 15:40:42 +0100
Subject: gcc miscompiles csum_tcpudp_magic() on ARMv5
In-Reply-To: <yw1xhaaejfso.fsf@unicorn.mansr.com>
References: <1386850444.22947.46.camel@sakura.staff.proxad.net>
 <20131212124015.GL4360@n2100.arm.linux.org.uk>
 <1386855390.22947.68.camel@sakura.staff.proxad.net>
 <yw1xppp2ji38.fsf@unicorn.mansr.com>
 <1386857410.22947.78.camel@sakura.staff.proxad.net>
 <20131212141926.GA31816@1wt.eu> <yw1xhaaejfso.fsf@unicorn.mansr.com>
Message-ID: <1386859242.22947.88.camel@sakura.staff.proxad.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Thu, 2013-12-12 at 14:37 +0000, M?ns Rullg?rd wrote:

> There is no such thing as a 16-bit register on ARM.  What this code does
> is ask the compiler to take the 16-bit value 'len' and put it in a register
> for use in the asm code.  All registers are 32-bit, so there is no ambiguity.

which strictly speaking the compiler did ;)

it took the 16 bits value and put it inside the lower 16 bits of the 32
bits register, it just didn't touch the higher ones

-- 
Maxime

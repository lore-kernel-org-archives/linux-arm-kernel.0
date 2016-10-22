From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 22 Oct 2016 22:23:54 +0200
Subject: [PATCH 2/3] ARM: convert to generated system call tables
In-Reply-To: <24632117.YsmPs86ri6@wuerfel> (Arnd Bergmann's message of "Fri,
 21 Oct 2016 22:35:53 +0200")
References: <E1bwa6s-0004ZY-4k@rmk-PC.armlinux.org.uk>
 <4337157.Eff9E2riVH@wuerfel>
 <20161021154856.GC1041@n2100.armlinux.org.uk>
 <24632117.YsmPs86ri6@wuerfel>
Message-ID: <87eg382kv9.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Friday, October 21, 2016 4:48:56 PM CEST Russell King - ARM Linux wrote:
>> What's the point of the x32 mode?
>
> On x86, the motivation is faster code for most use cases that
> don't need a lot of memory, as the 64-bit opcodes have 16 registers
> rather than 8 in 32-bit mode but 32-bit pointers have lower
> cache footprint than 64-bit pointers.

For completness, the second point of x32 AFAIU is the IP-relative addressing
which is not available in standard 32 bit mode, which improves PIC code. For
simple not algorithmic code (think Android HAL for example) with many shared
libraries, it's better in the Hardware Abstraction Layer Libraries, instead of
the push-to-stack and pop register.

Cheers.

--
Robert

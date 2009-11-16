From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 16 Nov 2009 19:56:52 +0100
Subject: [PATCH 2/3] msm: add minimal board file for HTC Dream device
In-Reply-To: <20091116165716.GD3568@n2100.arm.linux.org.uk> (Russell King's
	message of "Mon\, 16 Nov 2009 16\:57\:16 +0000")
References: <20091102104949.GA23456@elf.ucw.cz>
	<20091116163659.GB3568@n2100.arm.linux.org.uk>
	<a55d774e0911160843h22938604s8966a58ee71992a@mail.gmail.com>
	<20091116165716.GD3568@n2100.arm.linux.org.uk>
Message-ID: <87vdhagux7.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Mon, Nov 16, 2009 at 08:43:20AM -0800, Brian Swetland wrote:
>> What's the best way to handle a situation where there is no valid
>> debug uart?  Could the arch/platform require DEBUG_LL be unset via
>> Kconfig directives if it is configured in a way where there is no
>> valid debug uart?
>
> You're the first to have that issue.  Everyone else has a UART they
> can always direct stuff at.

Just for the record, there are machine files without a debug UART, especially in
the smartphone area.

In the PXA subworld I know, the UARTs are often used for :
 - a GSM chip (pxa ffuart)
 - a Bluetooth chip (pxa btuart)
 - a GPS chip (pxa stuart / hwuart)
 - an IR chip (pxa stuart / hwuart)

I didn't check through the mach-pxa/*.c, but mioa701.c accounts for one, and I
think magician and hx4700 would be part of it too. That also means kernel
debugging is _really_ painfull for these platforms.

Cheers.

--
Robert

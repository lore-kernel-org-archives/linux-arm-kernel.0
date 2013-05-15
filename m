From: neidhard.kim@lge.com (Jongsung Kim)
Date: Wed, 15 May 2013 10:00:07 +0900
Subject: [PATCH] ARM: PL011: add support for extended FIFO-size of
 PL011-r1p5
In-Reply-To: <5192A692.4010700@wwwdotorg.org>
References: <007301ce375e$bcf6d6b0$36e48410$@lge.com>
 <5191D200.3040604@wwwdotorg.org> <01fd01ce5072$d6b9fcd0$842df670$@lge.com>
 <5192A692.4010700@wwwdotorg.org>
Message-ID: <022d01ce5107$8bc668e0$a3533aa0$@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> :
> Looking at BCM2835-ARM-Peripherals.pdf (i.e. the public documentation for
> the BCM2835 chip), I see:
>
> =====
> The UART provides:
> * Separate 16x8 transmit and 16x12 receive FIFO memory.
> ...
> For the in-depth UART overview, please, refer to the ARM PrimeCell UART
> (PL011) Revision: r1p5 Technical Reference Manual.
> =====
>
> That seems to imply that not all r1p5 PL011s actually have a depth-32
FIFO.
> Perhaps this is a configurable property of the IP block, not something
that
> all r1p5 have?

All r1p5 have 32-byte FIFO depth and it's not configurable. From the PL011
TRM:

r1p4-r1p5	Contains the following differences in functionality:
		* The receive and transmit FIFOs are increased to a depth of
32.
		* The Revision field in the UARTPeriphID2 Register on page
3-24
		  bits [7:4] now reads back as 0x3.

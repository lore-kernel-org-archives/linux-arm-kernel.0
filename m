From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 20 Oct 2013 16:44:57 -0700
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution,
 or is there something	better?
In-Reply-To: <20131020231134.GR25034@n2100.arm.linux.org.uk>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131020231134.GR25034@n2100.arm.linux.org.uk>
Message-ID: <52646AF9.3050309@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/2013 04:11 PM, Russell King - ARM Linux wrote:
> On Sun, Oct 20, 2013 at 10:26:54PM +0100, Stephen Warren wrote:
>> The only thing we've really moved out of the kernel is the exact IDs of
>> which GPIOS, interrupts, I2C/SPI ports the devices are connected to; the
>> simple stuff not the hard stuff. The code hasn't really been simplified
>> by DT - if anything, it's more complicated since we now have to parse
>> those values from DT rather than putting them into simple data-structures.
>
> Here's my random thoughts this evening on DT, orientated mostly on a
> problem area I've been paying attention to recently.
>
> In some ways, DT has made things much harder.  I don't know whether

On the other side, DT has made some things much simpler.

Problem case: Chip A's interrupt pin is connected to gpio pin of chip B.
Chip B's interrupt pin is connected to a gpio pin on chip C. Chip C's
interrupt pin is connected to the interrupt controller. Chips B and C
are multi-function FPGAs. Exact gpio pins used vary from board to board.

With DT, this relationship is easy to describe, and none of the chip drivers
really needs to know what is connected to what. Without DT, it would be
much more complex.

Guenter

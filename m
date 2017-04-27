From: jiada_wang@mentor.com (Jiada Wang)
Date: Wed, 26 Apr 2017 23:43:18 -0700
Subject: [PATCH RFC 0/5] *** SPI Slave mode support ***
In-Reply-To: <20170425103113.lxpwoq6sbxvg3ihl@sirena.org.uk>
References: <1492085644-4195-1-git-send-email-jiada_wang@mentor.com>
 <20170413125929.dygodgj6c35ydh5p@sirena.org.uk>
 <CAMuHMdUm=90ddNWM5KWqT+W0hqZ-QO6vPHj5OisbYquDYq1ZmA@mail.gmail.com>
 <58F06092.9080409@mentor.com>
 <CAMuHMdXa_O6RsqUciiNWQ0Zp6dniS47AUmPN9UWAWitP0csx=Q@mail.gmail.com>
 <20170425103113.lxpwoq6sbxvg3ihl@sirena.org.uk>
Message-ID: <59019306.2050309@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Geert and Mark

On 04/25/2017 03:31 AM, Mark Brown wrote:
> On Mon, Apr 24, 2017 at 12:55:21PM +0200, Geert Uytterhoeven wrote:
>> On Fri, Apr 14, 2017 at 7:39 AM, Jiada Wang<jiada_wang@mentor.com>  wrote:
>>> Our use case is to use spidev as an interface to communicate with external
>>> SPI master devices.
>>> meanwhile the SPI bus controller can also act as master device to send data
>>> to other
>>> SPI slave devices on the board.
>> That sounds a bit hackish to me. SPI was never meant to be a multi-master bus.
>> While it can be done, you will need external synchronization (signals) to
>> avoid conflicts between the SPI masters.
>>> I found in your implementation, SPI bus controller is limited to either work
>>> in master mode or
>>> slave mode, is there any reasoning to not configure SPI mode based on SPI
>>> devices use case?
>> If you really need both master and slave support, you can use 2 subnodes
>> in DT, the first representing the master, the second the slave.
>> Mark, what's your opinion about this?
> That sounds like a mess...   we *could* put the slave flag on the device
> rather than the controller I guess but there's also going to need to be
> something representing whatever avoids collisions on the bus somewhere.
The reason I gave the example use case is want to point out that
with Geert's patch set, a SPI device (with only one controller) can no 
longer
act as master and slave at the same time. because IMO as a SPI core 
function,
it needs to cover all the use cases, and to be as generic as possible.

BUT if you think the use case don't need to be supported from SPI core,
then I don't have objection either, I will only submit imx SPI slave 
support patch,
after your SPI slave support patch set been applied


Thanks,
Jiada

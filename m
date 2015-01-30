From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 30 Jan 2015 14:07:55 +0100
Subject: [PATCH] ARM: dts: mvebu: add ethernet to the cm-a510 board
In-Reply-To: <1507191.iMZ4oC8rrr@stargate>
References: <E1YH5bU-0005mG-3L@bombadil.infradead.org>
 <20150130124144.501cf81d@armhf> <54CB732F.7010409@gmail.com>
 <1507191.iMZ4oC8rrr@stargate>
Message-ID: <54CB822B.8080809@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Re-adding the most obvious People to Cc]

On 30.01.2015 13:44, David Goodenough wrote:
> On Friday 30 January 2015 13:03:59 Sebastian Hesselbarth wrote:
>> On 30.01.2015 12:41, Jean-Francois Moine wrote:
>>> On Fri, 30 Jan 2015 12:00:16 +0100
>>> Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:
>> That what dtsi's are made for with one exception: the dtsi cannot "run"
>> on its own but needs at least one baseboard.dts that includes it. We
>> could create a "bare"-baseboard that represents what is (easily)
>> accessible on the SoM itself. Given the fact that even UART0 needs a
>> baseboard that grabs it from the SoM connector, I see no value in that.
>>
>>> In any case, any real cm-a510 board should work with the
>>> generic/full .dts even if some hardware modules are lacking. No?
>>
>> Nope. The cm-a510 is just an add-on for a baseboard, it does not make
>> a working board. Just think of it as a feature-improved SoC.

> This sounds like capes on the BeagleBoard.  Are these extension boards
> self-identifying?  If so then the approach used with the capes might work
> here too.

David,

IMHO capes are a different thing. The BB can run just fine without any
cape installed, the cm-a510 cannot run without a baseboard. Also, once
you have your SoM installed it cannot change over runtime, there is no
need for any dynamic overlays and such.

You can build some 5 or 10 different configurations given the SoM and
a specific baseboard but not hundreds of possible combinations.
Besides, Gabriel is the first in almost 2 years that actually has an
cm-a510 - so, I doubt we'll have to mainline dozens of baseboards
using the cm-a510 in the near future.

Regarding the self-identification, it would be great if the actual SoM
configuration would be stored in the (always available) SPI flash, but
from my experience with the boards I have seen so far, I have a bad
feeling about it ;) A quick look at the sb-a510 (the compulab baseboard
for cm-a510) suggests that there is more configuration available but
by jumpers that (hopefully) can be read out by GPIOs at least.

The best similar board available in mainline I can remember is the
SolidRun Hummingboard, i.e. one baseboard that can be equipped with
3-4 different SoMs.

Sebastian

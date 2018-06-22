From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 22 Jun 2018 15:36:16 +0200
Subject: [PATCH 0/5] RFC: Mezzanine handling for 96boards
In-Reply-To: <CAK8P3a3f6=APcwKERWA4owv7j_gFEqo1tmFtUtVeP82do-QhDg@mail.gmail.com>
References: <20180618074556.6944-1-linus.walleij@linaro.org>
 <CAK8P3a2KqoX-squhGc8TBuJ==8xxELsuy-H+c1+C7Fu7Z4OjDA@mail.gmail.com>
 <CAKv+Gu-gAkfRsEUOc=iyxi6Twvg9cbvWNqNHRS2HzUDZg8xUhg@mail.gmail.com>
 <CAK8P3a3f6=APcwKERWA4owv7j_gFEqo1tmFtUtVeP82do-QhDg@mail.gmail.com>
Message-ID: <01cf8334-c4c3-6c84-395b-1f93fd9fe022@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.6.2018 16:15, Arnd Bergmann wrote:
> On Mon, Jun 18, 2018 at 3:22 PM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> On 18 June 2018 at 14:21, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Mon, Jun 18, 2018 at 9:45 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>> Also, given that we can (and do) already describe topologies involving
>> mezzanines by ignoring the connector altogether (which is not entirely
>> unreasonable given the fact that we [as Linaro/96boards] dropped the
>> ball on this one and did not mandate discoverability for mezzanines).
>> So ideally, DTs can be expressed such that older kernels can still use
>> those peripherals.
> 
> Not sure. Modeling the connector as a device with its own driver does
> seem like a significant advantage, which to me weighs more than backward
> compatibility with old kernels. We can clearly always describe the devices
> behind the connector individually and ignore the connector on old kernels
> and we should still allow running DT files that work with the old kernels
> on new kernels, but I don't see running new DT files on old kernels as
> essential in this case. Many platforms don't actually care about that case
> at all today (but some do of course).

Linus choose Ultra96 board which is showing that "standard" 96boards
connector doesn't need to be standard in all cases.
If you look at board schematics that you will see that loaded
bitstream/configuration is making these connector compatible with
96boards spec.
Almost the whole HS connector is connected to programmable logic and low
speed connector is pretty much flexible too.

Also resource/power saving case should be considered.
I will take uart mezzanine as an example which requires only 6 uart pins
and one gpio. In Ultra96 that means that doesn't make sense to waste
your fpga resources for something what you don't need.
(Truth is that for low speed it is just about wires but with High speed
connector MIPI is in PL part which consume a logic).
And both connectors should also be handled together because some
mezzanine cards require both of them.

Thanks,
Michal

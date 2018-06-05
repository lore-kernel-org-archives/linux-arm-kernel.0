From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 5 Jun 2018 10:23:22 +0200
Subject: [PATCH v3 8/8] ARM: dts: rcar-gen2: Remove unused VIN properties
In-Reply-To: <20180605081222.GL10472@w540>
References: <1527606359-19261-1-git-send-email-jacopo+renesas@jmondi.org>
 <1527606359-19261-9-git-send-email-jacopo+renesas@jmondi.org>
 <20180604122325.GH19674@bigcity.dyn.berto.se>
 <20180605074938.mljwmgpjlplvkp2v@verge.net.au>
 <20180605081222.GL10472@w540>
Message-ID: <CAMuHMdXVF_OZCXJ449TJdm3f7ECMabgpRoWEBSmxJ=7f0zA_7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacopo,

On Tue, Jun 5, 2018 at 10:12 AM, jacopo mondi <jacopo@jmondi.org> wrote:
> On Tue, Jun 05, 2018 at 09:49:38AM +0200, Simon Horman wrote:
>> On Mon, Jun 04, 2018 at 02:23:25PM +0200, Niklas S?derlund wrote:
>> > On 2018-05-29 17:05:59 +0200, Jacopo Mondi wrote:
>> > > The 'bus-width' and 'pclk-sample' properties are not parsed by the VIN
>> > > driver and only confuse users. Remove them in all Gen2 SoC that use
>> > > them.
>> > >
>> > > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>> >
>> > The more I think about this the more I lean towards that this patch
>> > should be dropped. The properties accurately describes the hardware and
>> > I think there is value in that. That the driver currently don't parse or
>> > make use of them don't in my view reduce there value. Maybe you should
>> > break out this patch to a separate series?
>>
>> I also think there is value in describing the hardware not the state of the
>> driver at this time.  Is there any missmatch between these properties and
>> the bindings?
>
> Niklas and I discussed a bit offline on this yesterday. My main
> concern, and sorry for being pedant on this, is that changing those
> properties value does not change the interface behaviour, and this
> could cause troubles when integrating image sensor not known to be
> working on the VIN interface.
>
> This said, the documentation of those (and all other) properties is in the
> generic "video-interfaces.txt" file and it is my understanding, but I think
> Laurent and Rob agree on this as well from their replies to my previous series,
> that each driver should list which properties it actually supports, as

s/driver/device-specific binding/

> some aspects are very implementation specific, like default values and
> what happens if the property is not specified [1]. Nonetheless, all

In se defaults are not (Linux) implementation-specific, but fixed in the
DT bindings.

> properties describing hardware features and documented in the generic
> file should be accepted in DTS, as those aims to be OS-independent and
> even independent from the single driver implementation.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

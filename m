From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Mon, 12 Jun 2017 17:26:27 +0200
Subject: [PATCH 46/58] clocksource/drivers: Add a new driver for the Atmel
 ARM TC blocks
In-Reply-To: <4c2a5425-acb4-c639-7f54-1dd933c44d03@linaro.org>
References: <20170530215139.9983-47-alexandre.belloni@free-electrons.com>
 <20170606152104.GC2345@mai> <20170606180559.pkrr7ux2qqnmsd6y@piout.net>
 <20170607141735.GH2345@mai> <20170607152750.tksmyf5p3oajbsac@piout.net>
 <20170607210848.GJ2345@mai> <20170607231715.ns2vcxza2eexnzjs@piout.net>
 <20170608074236.62924f01@bbrezillon> <20170608074446.GM2345@mai>
 <20170608101334.4e60aa4c@bbrezillon> <20170608084026.GB2244@mai>
 <eada48f9-55b5-859d-d37e-4c9e938bc29d@microchip.com>
 <4c2a5425-acb4-c639-7f54-1dd933c44d03@linaro.org>
Message-ID: <cd8c34e1-de72-c5e4-ec80-67628b037aa4@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 12/06/2017 ? 15:25, Daniel Lezcano a ?crit :
> On 12/06/2017 14:54, Nicolas Ferre wrote:
> 
> [ ... ]
> 
>>> I like the 'chosen' approach with the nodes you are proposing below. Thanks for
>>> the constructive suggestion. The binding description matches perfectly what we
>>> are trying to achieve.
>>>
>>> Rob? what do you think?
>>
>> I'm following this work from a distance but as we've just celebrated the
>> 1st anniversary for this patch series (11 June 2016), I propose that we
>> now make up our mind quickly. Everybody seem to be on the same page and
>> willing to make this rework move forward.
>>
>> In Microchip/Atmel we would like to actually use this TCB rework both
>> internally and in our mainline work to avoid having to rely on our own
>> out-of-tree implementation.
>>
>> The newly-added samv7 cortex-M can't boot without this series and a use
>> of our current cortex-A SoCs with TrustZone in Secure World (SWd) is not
>> possible with current mainline code only. On these two examples, the
>> current timer on which we rely, the PIT, is not present.
>>
>> So you probably understand that more than one year without real progress
>> begins to be a little bit frustrating for the AT91 users...
> 
> Nicolas,
> 
> who are you exactly blaming?
> 
> Are you surprised a 58 patches series, with a gazillion of Cc'ed people
> posted awhile ago, is ignored?

Daniel,

Well, I'm talking about the only patch about DT bindings here, not the
other (large number) of soc/board dts changes.
Note that Alexandre tried to extract this discussion from the other
patches without coming to a conclusion either ("[PATCH v3] ARM: at91:
Document new TCB bindings", for instance).

I had the feeling that this email thread was about to be fading out on a
DT binding discussion, as it had done a couple of times during the last
months... Both you and me produced "ping" messages to make this
discussion progress with no real success so far... This is why I was a
little worried.

Regards,
-- 
Nicolas Ferre

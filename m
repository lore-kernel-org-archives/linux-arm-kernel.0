From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 20 Jan 2011 13:55:25 -0500
Subject: [PATCH] pxa3xx: fix PXA GPIO IRQ handling
In-Reply-To: <AANLkTi=2Tx7M4=wF7GkQZLFe5=JLGv2G7roavKroWZ78@mail.gmail.com>
References: <1295338561.2003.3.camel@sven>
	<1295338738-4129-1-git-send-email-s.neumann@raumfeld.com>
	<4D357DC0.2030006@metafoo.de>
	<AANLkTi=gGDZHukdSuupg22Gb9te+Vk_rsu6-vREeQRVE@mail.gmail.com>
	<1295387347.20633.3.camel@bender>
	<AANLkTi=2Tx7M4=wF7GkQZLFe5=JLGv2G7roavKroWZ78@mail.gmail.com>
Message-ID: <AANLkTinOgeshyM6RFJQSFXYQecsvucoMCrr_SduS+QCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 20, 2011 at 1:48 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Tue, Jan 18, 2011 at 4:49 PM, Sven Neumann <s.neumann@raumfeld.com> wrote:
>> On Tue, 2011-01-18 at 08:15 -0800, Eric Miao wrote:
>>> On Tue, Jan 18, 2011 at 3:47 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>>> > On 01/18/2011 09:18 AM, Sven Neumann wrote:
>>> >> From: Lars-Peter Clausen <lars@metafoo.de>
>>> >>
>>> >> Set the "set_wake" field of the irq_chip struct before calling
>>> >> set_irq_chip() for all of the IRQs, so that the compat handler
>>> >> actually gets installed.
>>>
>>> Not really sure if this is necessary. Lennert has done the transition to
>>> irq_data to those _set_wake() functions as well, so it should be OK
>>> that compat handler doesn't get installed.
>>>
>>> Now I'm not against moving this above, just wondering if there were
>>> any consequences/errors coming out?
>>
>> Well, our PXA300 device doesn't power up again when it should resume
>> from suspend. Fine with me if this has been fixed upstream,
>
> Yeah, that's true. Mind re-post with your SOB?

And Cc linux-stable.

>
>> but I would
>> still like to get this patch into 2.6.37. I'll try to test upstream as
>> soon as Linus releases 2.6.38-rc1...

That's will be great help.

>>
>>
>> Sven
>>
>>
>>
>

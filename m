From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 09 May 2012 14:19:13 -0600
Subject: [PATCH] pinctrl: Add generic pinctrl-simple driver that supports
 omap2+ padconf
In-Reply-To: <20120504220809.GW5613@atomide.com>
References: <20120502172401.GG3739@atomide.com>
 <20120503065131.GA3738@game.jcrosoft.org> <20120503152708.GC5140@atomide.com>
 <4FA30805.5050804@wwwdotorg.org> <20120504044305.GD7788@game.jcrosoft.org>
 <20120504150342.GI5140@atomide.com> <20120504153251.GE7788@game.jcrosoft.org>
 <20120504163420.GA5613@atomide.com> <4FA42631.6060304@wwwdotorg.org>
 <20120504220809.GW5613@atomide.com>
Message-ID: <4FAAD141.3090306@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04/2012 04:08 PM, Tony Lindgren wrote:
> * Stephen Warren <swarren@wwwdotorg.org> [120504 11:59]:
>> On 05/04/2012 10:34 AM, Tony Lindgren wrote:
>>> * Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> [120504 08:58]:
>>>> On 08:03 Fri 04 May     , Tony Lindgren wrote:
>>>>>>
>>>>>> so I was thinking to do like on gpio
>>>>>>
>>>>>> uart {
>>>>>> 	pin = < &pioA 12 {pararms} >
>>>>>>
>>>>>> }
>>>>>
>>>>> Hmm I assume the "12" above the gpio number?
>>>> no pin number in the bank because it could not be gpio
>>>
>>> Yes OK, but pin number 12 in the gpio bank, not in the mux register.
>>> Got it.
>>
>> I'd prefer to avoid any references to GPIOs here; not all muxable pins
>> are GPIOs and not all GPIOs are muxable pins. Lets keep the two concepts
>> independent.
> 
> And it seems that &pioA 12 is not always enough information for the pinctrl
> driver to request a GPIO. So it's best to specify it separately.

Why would a pinctrl driver "request a GPIO"?

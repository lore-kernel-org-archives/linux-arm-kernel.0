From: ludovic.desroches@atmel.com (ludovic.desroches)
Date: Thu, 20 Dec 2012 17:13:52 +0100
Subject: [PATCH 1/3] ARM: AT91: IIO: add low and high res support for adc
In-Reply-To: <50D3340F.3090209@free-electrons.com>
References: <20121219183236.GP23971@game.jcrosoft.org>
 <1355942232-26251-1-git-send-email-plagnioj@jcrosoft.com>
 <50D2EBA1.4050305@free-electrons.com> <50D2EDE6.3090706@atmel.com>
 <50D3340F.3090209@free-electrons.com>
Message-ID: <50D33940.4000607@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20/2012 04:51 PM, Maxime Ripard wrote:
> Hi Ludovic,
>
> Le 20/12/2012 11:52, ludovic.desroches a ?crit :
>>> I'm wondering, why are you using such a complex dt parsing code, and
>>> bindings, when you only requires a boolean to switch between 8 and 10
>>> bits mode (which seem to be the only thing you support)?
>>
>> We will have a 10 and 12 bits mode on future ADCs and I would like to
>> have something which could manage more than two resolutions if it
>> happens one day.
>
> I see your point. I'm not fond at all of the existing bindings for the
> driver (putting things like registers offset in the dt is a non-sense to
> me, but hey...), so I'd like to still keep it as simple and non-bloated
> as possible, but it's true that in the current situation, we probably
> have no other choice.
>

I have the same feeling than you about ADC bindings, I think that there 
are too many parameters exhibited. Moreover, most of them are chip relative.

I have not found other ways to deal with it properly. I would like to 
have them hidden into the driver (depending on the compatible string) 
but it will be a mess if we split parameters into dt and driver.

So the idea was to have a binding which could allow us to manage several 
cases about resolution modes in the future.

Ludovic

> Maxime
>

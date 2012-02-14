From: robherring2@gmail.com (Rob Herring)
Date: Mon, 13 Feb 2012 19:26:02 -0600
Subject: [PATCH 1/1] gpio: drop CONFIG_OF_GPIO in the definition of the
 struct gpio_chip
In-Reply-To: <4F392537.8070505@atmel.com>
References: <1329125002-21134-1-git-send-email-plagnioj@jcrosoft.com>
 <4F391781.2020203@gmail.com> <20120213141229.GD3378@game.jcrosoft.org>
 <4F391F1E.4020808@gmail.com> <4F392537.8070505@atmel.com>
Message-ID: <4F39B82A.3040404@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/2012 08:59 AM, Nicolas Ferre wrote:
> On 02/13/2012 03:33 PM, Rob Herring :
>> On 02/13/2012 08:12 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>> On 08:00 Mon 13 Feb     , Rob Herring wrote:
>>>> On 02/13/2012 03:23 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>>>> this will allow to avoid the ifdef CONFIG_OF_GPIO in gpio drivers
>>>>>
>>>>
>>>> So would always enabling CONFIG_OF on at91 and then only 1 sub-arch is
>>>> paying the price for additional space. Then we would only have ifdefs in
>>>> the truly cross-platform gpio drivers.
>>> we talk about 12bytes and here it's force to put a ifdef in the gpio drivers
>>> in platform_device we don't do so. So why should be do it here??
>>
>> But you are affecting everyone. I'm not saying we shouldn't do this. I'm
>> just highlighting the reason this is a problem and gpio is just one
>> instance. I think sub-arches should either always select OF or not.
>> Trying to do both is just going to be a pain to maintain.
> 
> (nothing related to the particular case discussed here, but...)
> 
> Rob,
> 
> It may be a pain to maintain (and I can tell it is), but we do not have
> the choice: the AT91 family is simply too widely spread in terms of
> number of SoC and release date of those SoC. We must maintain all of
> them working while we are doing the effort to switch most of the
> material to DT. As this work takes time I fear that the transition
> period will last for a long time.
> 
> Older SoCs will surely never be converted to device-tree as both the
> lack of workforce, customer habits and amount of boards existing and
> working correctly in mainline will go against this.

I'm not saying convert all the boards to DT, just unconditionally enable
the config option. The only impact with that is kernel size, but I
haven't quantified how much of an increase that is though. Is it a big
deal if the boards are only minimally being maintained compared to the
maintenance?

Rob

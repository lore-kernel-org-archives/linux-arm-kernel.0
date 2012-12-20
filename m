From: stigge@antcom.de (Roland Stigge)
Date: Thu, 20 Dec 2012 10:12:01 +0100
Subject: [PATCH 6/6 v11] gpio: Add block gpio to several gpio drivers
In-Reply-To: <50D2C731.1080009@grandegger.com>
References: <1355952138-20459-1-git-send-email-stigge@antcom.de>
 <1355952138-20459-7-git-send-email-stigge@antcom.de>
 <20121220070805.GQ23971@game.jcrosoft.org> <50D2C731.1080009@grandegger.com>
Message-ID: <50D2D661.9090707@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20/2012 09:07 AM, Wolfgang Grandegger wrote:
> On 12/20/2012 08:08 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> On 22:22 Wed 19 Dec     , Roland Stigge wrote:
>>> This patch adds block GPIO support to several gpio drivers.
>>>
>>> This implements block GPIO only for some selected drivers since block GPIO is
>>> an optional feature which may not be suitable for every GPIO hardware. (With
>>> automatic fallback to the single GPIO functions if not available in a driver.)
>>>
>>> Signed-off-by: Roland Stigge <stigge@antcom.de>
>>>
>>> ---
>>>  arch/arm/mach-at91/gpio.c         |   33 +++++++++++++++
>> as said on the previous version the mach-at91 is deprecated for this platform
>> and boards
>>
>> you MUST updatethe drivers/pinctrl/pinctrl-at91
>>
>> nack on at91 untill this is done
> 
> I suggest to drop the hunk for the AT91 for the moment and wait until
> the block gpio interface is accepted. Then we can add the block gpio
> enhancement to the GPIO drivers in arch/... not only for the AT91...
> also because they have to go through different sub-systems maintainers.

OK, thank you two! Will remove the at91 patch from the current series.
Block GPIO support for at91 can be added later.

I just noticed that the patch set needs another patch not yet in
mainline, but in linux-next, linux-gpio and gpio/next.

I'm providing a branch to easily pull from for testing, building on v3.7:

git://git.antcom.de/linux-2.6.git blockgpio

Feedback welcome - thanks!

Roland

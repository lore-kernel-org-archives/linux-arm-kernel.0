From: wg@grandegger.com (Wolfgang Grandegger)
Date: Thu, 20 Dec 2012 09:07:13 +0100
Subject: [PATCH 6/6 v11] gpio: Add block gpio to several gpio drivers
In-Reply-To: <20121220070805.GQ23971@game.jcrosoft.org>
References: <1355952138-20459-1-git-send-email-stigge@antcom.de>
 <1355952138-20459-7-git-send-email-stigge@antcom.de>
 <20121220070805.GQ23971@game.jcrosoft.org>
Message-ID: <50D2C731.1080009@grandegger.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20/2012 08:08 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 22:22 Wed 19 Dec     , Roland Stigge wrote:
>> This patch adds block GPIO support to several gpio drivers.
>>
>> This implements block GPIO only for some selected drivers since block GPIO is
>> an optional feature which may not be suitable for every GPIO hardware. (With
>> automatic fallback to the single GPIO functions if not available in a driver.)
>>
>> Signed-off-by: Roland Stigge <stigge@antcom.de>
>>
>> ---
>>  arch/arm/mach-at91/gpio.c         |   33 +++++++++++++++
> as said on the previous version the mach-at91 is deprecated for this platform
> and boards
> 
> you MUST updatethe drivers/pinctrl/pinctrl-at91
> 
> nack on at91 untill this is done

I suggest to drop the hunk for the AT91 for the moment and wait until
the block gpio interface is accepted. Then we can add the block gpio
enhancement to the GPIO drivers in arch/... not only for the AT91...
also because they have to go through different sub-systems maintainers.

Wolfgang.

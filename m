From: ludovic.desroches@atmel.com (ludovic.desroches)
Date: Thu, 24 Jan 2013 10:09:22 +0100
Subject: [PATCH] i2c: at91: add of_device_id entry for at91rm9200
In-Reply-To: <CAGhQ9VxRrPOOQKragU=zSW-FPYdsmUEqY7k_fNHZVEM18zXvCg@mail.gmail.com>
References: <1354743732-11581-1-git-send-email-manabian@gmail.com>
 <20121218060232.GL23971@game.jcrosoft.org>
 <20130124072714.GH8364@nekote.pengutronix.de> <5100E9A4.9020804@atmel.com>
 <CAGhQ9VxRrPOOQKragU=zSW-FPYdsmUEqY7k_fNHZVEM18zXvCg@mail.gmail.com>
Message-ID: <5100FA42.7050905@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/24/2013 09:43 AM, Joachim Eastwood wrote:
> On 24 January 2013 08:58, ludovic.desroches <ludovic.desroches@atmel.com> wrote:
>> Hi,
>>
>>
>> On 01/24/2013 08:27 AM, Wolfram Sang wrote:
>>>
>>> On Tue, Dec 18, 2012 at 07:02:32AM +0100, Jean-Christophe PLAGNIOL-VILLARD
>>> wrote:
>>>>
>>>> On 22:42 Wed 05 Dec     , Joachim Eastwood wrote:
>>>>>
>>>>> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>>>>> ---
>>>>> Hi,
>>>>>
>>>>> AT91RM9200 is gaining DT support now so let's add an id to the i2c
>>>>> driver.
>>>>>
>>>>> Tested on custom RM9200 board. Since the driver doesn't support pinctrl
>>>>> muxing yet I had to add pinctrl hogs for the i2c pins in my dts for it
>>>>> to work.
>>>>
>>>>
>>>> IIRC the i2c IP have quite a lots of issue on rm9200 and until sam9g45
>>>>
>>>> it not recommended to use it instead use i2c-gpio
>>>
>>>
>>> Ludovic, you know the driver best. Does it make sense to add this?
>>
>>
>> I didn't add this when I did the rework because there was no DT tree support
>> for RM9200. The configuration for RM9200 IP is already in the driver and
>> used for non DT platform so I think it makes sense to add this.
>>
>> But as Jean-Christophe said, it's recommended to use the i2c-gpio driver
>> since we know the first versions of the IP have several issues. However if
>> it fits user usage, it is not forbidden to use it.
>
> I assumed the new driver handles the HW quirks better than the old atmel-twi
> driver(?). So the RM9200 i2c HW is at least usable with this driver.
>

No it doesn't handle HW quirks (clock stretching, stop command, etc.) 
better for old IP versions than the old atmel-twi. Since we have no 
workarounds for these quirks, it was recommended to use i2c-gpio.

> I didn't encounter any problems during my short testing using a couple of
> different i2c devices. As far as I can remember the old driver didn't even
> handle the devices I tested with the new driver.

I also did some tests on RM9200 with basic i2c devices and everything go 
well so yes it is usable that's why I think this patch can be applied.

Regards

Ludovic

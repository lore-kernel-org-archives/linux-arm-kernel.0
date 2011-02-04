From: grinberg@compulab.co.il (Igor Grinberg)
Date: Fri, 04 Feb 2011 16:47:09 +0200
Subject: [PATCH v3 2/2] Input: ads7846: use gpio_request_one to configure
	pendown_gpio
In-Reply-To: <20110204141618.GE2070@m-desktop>
References: <1296746506-12221-1-git-send-email-sourav.poddar@ti.com>
	<20110203165405.GB12802@core.coreip.homeip.net>
	<20110203171953.GA13997@core.coreip.homeip.net>
	<20110204133250.GB2070@m-desktop>
	<20110204140847.GA3178@pengutronix.de>
	<20110204141618.GE2070@m-desktop>
Message-ID: <4D4C116D.4080408@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/04/11 16:16, G, Manjunath Kondaiah wrote:

> On Fri, Feb 04, 2011 at 03:08:47PM +0100, Wolfram Sang wrote:
>> On Fri, Feb 04, 2011 at 07:02:50PM +0530, G, Manjunath Kondaiah wrote:
>>> On Thu, Feb 03, 2011 at 09:19:53AM -0800, Dmitry Torokhov wrote:
>>>> On Thu, Feb 03, 2011 at 08:54:05AM -0800, Dmitry Torokhov wrote:
>>>>> On Thu, Feb 03, 2011 at 08:51:46PM +0530, Sourav Poddar wrote:
>>>>>> The ads7846 driver requests a gpio but does not currently
>>>>>> configure it explicitly as an input. Use gpio_request_one
>>>>>> to request and configure it at one shot.
>>>>>>
>>>>>> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
>>>>>> Cc: Dmitry Torokhov <dtor@mail.ru>
>>>>> Will apply this one, the other one is a bit messy IMO, will have to
>>>>> think about it.
>>>>>
>>>> Something like below should do I think.
>>> Patch looks good but it applies only on top of previous patch:
>>> https://patchwork.kernel.org/patch/529941/
>>>
>>> Why to have two patches for this fix?
>> http://www.spinics.net/lists/linux-omap/msg45167.html
> My point here is: 
> 1. The first patch only replaces gpio_request with gpio_request_one
> 2. Rest of the things are handled in 2nd patch posted by dmitry
>
> What is harm in merging both the patches? I don't think it affects
> readability.

Because the changes introduced by the patches are from different nature.
As stated in the link above, one is a functional change (gpio setup change)
and second is fixing the imbalance in request - free calls.
The impact is not readability, but bad bisect-ability.


-- 
Regards,
Igor.

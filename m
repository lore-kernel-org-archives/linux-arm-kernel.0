From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 9 Aug 2011 10:51:18 +0800
Subject: [PATCH] GPIOLIB: add generic gpio_set_pull API
In-Reply-To: <4E40912C.5040801@codeaurora.org>
References: <1312780773-23142-1-git-send-email-Baohua.Song@csr.com>
	<20110808081552.GI32513@linux-sh.org>
	<CACxGe6ssT4=kxApaKhv+=7nDcEFVW+oyByFQ_hzcfyZ4gw2C3g@mail.gmail.com>
	<CAH9JG2V-66Wn7nwJz6tOkESoQAUJzAg-47YeMY0vzwu6T9O=Rg@mail.gmail.com>
	<4E40912C.5040801@codeaurora.org>
Message-ID: <CAGsJ_4xq2kpVu2BXPkeeWaZYYN=r73_2V2eOnT5FA8dv43at5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/8/9 Rohit Vaswani <rvaswani@codeaurora.org>:
> On 8/8/2011 3:57 PM, Kyungmin Park wrote:
>>
>> On Tue, Aug 9, 2011 at 3:24 AM, Grant Likely<grant.likely@secretlab.ca>
>> ?wrote:
>>>
>>> On Mon, Aug 8, 2011 at 2:15 AM, Paul Mundt<lethal@linux-sh.org> ?wrote:
>>>>
>>>> On Sun, Aug 07, 2011 at 10:19:33PM -0700, Barry Song wrote:
>>>>>
>>>>> Now there are many different implementations for GPIO pull
>>>>> configuration, for
>>>>> example:
>>>>> s3c_gpio_setpull()
>>>>> tegra_pinmux_set_pullupdown()
>>>>> chipcHw_setPinPullup()
>>>>> gpio_pullup()
>>>>> s3c2410_gpio_pullup()
>>>>>
>>>>> This patch adds a new generic gpio_set_pull API so that all SoCs can
>>>>> have unified
>>>>> codes.
>>>>>
>>>>> Signed-off-by: Barry Song<Baohua.Song@csr.com>
>>>>
>>>> For arch/arm/mach-shmobile we also have gpio_pull_up() for board-g4evm.c
>>>> and gpio_pull_down() for board-mackerel.c. Both of these would benefit
>>>> from this sort of an API addition.
>>>
>>> I think I'm okay with this API change. ?Linus, what say you? ?How does
>>> this interact with your plans for pinctrl?
>>
>> If gpiolib accept the pullup control. gpiolib is better place to
>> control gpio config.
>> then remains are the gpio driver strength, and power down mode
>> control. powerdown pull-up/down, powerdown in/out at samsung gpios.
>
> If we add this API - the remaining gpio controls like drive strength and
> function select could also be added, which eats into the pinmux domain.
> Linus W. had a patch earlier which added an API for a gpio config to be
> specified through gpiolib. " gpio: add a custom configuration mechanism to
> gpiolib" which is sort of an extensible model of this API.

gpio_config() from Linus W. is an interface with multiple functions or
a function for multiple purpose. Its actions seem to be ambiguous,
then mean diffiicult to use or diffirent subsystems still result in
many differences after using it.

pullup/down/none is something very common and much frequently used to
all SoCs, i guess it can have individual, simple and direct API.

I don't oppose gpiolib cover more GPIO configurations, for example OC,
OD and powerdown. but we might keep APIs as simple and clear as
possible.

>
> Thanks,
> Rohit

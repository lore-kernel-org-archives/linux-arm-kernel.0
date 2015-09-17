From: songjun.wu@atmel.com (Wu, Songjun)
Date: Thu, 17 Sep 2015 11:07:20 +0800
Subject: [PATCH 2/2] ASoC: atmel-classd: DT binding for Class D audio
 amplifier driver
In-Reply-To: <20150916194234.GR12027@sirena.org.uk>
References: <1441086101-15303-1-git-send-email-songjun.wu@atmel.com>
 <1441086101-15303-3-git-send-email-songjun.wu@atmel.com>
 <20150903114316.GV12027@sirena.org.uk> <55EC0AFE.3080809@atmel.com>
 <20150907162548.GW5313@sirena.org.uk> <55EEAC0D.7010003@atmel.com>
 <20150908122340.GC9751@sirena.org.uk> <55F78C79.30102@atmel.com>
 <20150916194234.GR12027@sirena.org.uk>
Message-ID: <55FA2E68.5010104@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 9/17/2015 03:42, Mark Brown wrote:
> On Tue, Sep 15, 2015 at 11:11:53AM +0800, Wu, Songjun wrote:
>
>> I try to use one entry, but there is a problem.
>> It's about 'driver_data' in struct device.
>> In function snd_soc_register_card, the parameter 'card' will be set to
>> 'driver_data' by the code 'dev_set_drvdata(card->dev, card)'.
>> Then some resources(eg. regmap, clock) also need be recorded by
>> 'driver_data'. One entry could only has one 'driver_data'. I think the best
>> way is to create two entries, like the current dts.
>> What's your opinion?
>
> Look at the recently applied sunxi driver for an example of how to do
> this - it's a similar piece of hardware (entirely in the SoC and so on).
>
Thank you, It really helps me. I will make a second version soon.

From: songjun.wu@atmel.com (Wu, Songjun)
Date: Tue, 15 Sep 2015 11:11:53 +0800
Subject: [PATCH 2/2] ASoC: atmel-classd: DT binding for Class D audio
 amplifier driver
In-Reply-To: <20150908122340.GC9751@sirena.org.uk>
References: <1441086101-15303-1-git-send-email-songjun.wu@atmel.com>
 <1441086101-15303-3-git-send-email-songjun.wu@atmel.com>
 <20150903114316.GV12027@sirena.org.uk> <55EC0AFE.3080809@atmel.com>
 <20150907162548.GW5313@sirena.org.uk> <55EEAC0D.7010003@atmel.com>
 <20150908122340.GC9751@sirena.org.uk>
Message-ID: <55F78C79.30102@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 9/8/2015 20:23, Mark Brown wrote:
> On Tue, Sep 08, 2015 at 05:36:13PM +0800, Wu, Songjun wrote:
>> On 9/8/2015 00:25, Mark Brown wrote:
>
>>> Sure, there's no problem at all having that structure in software but it
>>> should be possible to do this without having to represent this structure
>>> in DT.  It should be possible to register the card at the same time as
>>> the rest of the components rather than needing the separate device in
>>> the DT.
>
>> Do you mean using a single entry in the DT for the whole classD system and
>> instantiate ASoC components from it.
>> For now, there are two entry, they could be combined to one entry.
>
> Yes, exactly.
>
I try to use one entry, but there is a problem.
It's about 'driver_data' in struct device.
In function snd_soc_register_card, the parameter 'card' will be set to 
'driver_data' by the code 'dev_set_drvdata(card->dev, card)'.
Then some resources(eg. regmap, clock) also need be recorded by 
'driver_data'. One entry could only has one 'driver_data'. I think the 
best way is to create two entries, like the current dts.
What's your opinion?

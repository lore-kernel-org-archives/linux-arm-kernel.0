From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 26 Jan 2015 17:49:11 +0100
Subject: [alsa-devel] [PATCH v2 1/3] ASoC: codecs: wm8904: add dt ids table
In-Reply-To: <20150126164229.GB21293@sirena.org.uk>
References: <1418614273-2303-1-git-send-email-voice.shen@atmel.com>
 <20150115115425.GX3043@sirena.org.uk> <54B866B9.8000900@atmel.com>
 <54C65C36.9050106@atmel.com> <20150126164229.GB21293@sirena.org.uk>
Message-ID: <54C67007.6000708@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/26/2015 05:42 PM, Mark Brown wrote:
> On Mon, Jan 26, 2015 at 04:24:38PM +0100, Nicolas Ferre wrote:
>> Le 16/01/2015 02:17, Bo Shen a ?crit :
>
>>>> Does this end up in the i2c_driver_id driver data or do we need some
>>>> extra code when devtype is assigned to check for an of_node and look at
>>>> the DT data instead?  That certainly used to be the case...
>
>>> At the beginning I think as the same as you, and also add the code to
>>> get the data as I do in <drivers/misc/atmel-ssc.c>. However, as I
>>> remember, I2C seems only use the compatible string after the comma, that
>>> means only for "wlf,wm8904", it uses "wm8904" to match. So, I remove all
>>> the code I added, and just keep these, and it can get the device type
>>> correctly.
>
>>> So, when I submit the patch and keep the code as simple as possible.
>
>> I don't understand what's keeping this patch from being applied. Voice,
>> do you mind re-sending?
>
> I need to convince myself that the above actually works and is doing the
> right thing; the above explanation sounds like if it works it might be
> relying on a bug.

I'd call it a undocumented feature. But I wouldn't rely on it being around 
for ever. In my opinion to be future proof the driver should explicitly 
handle the OF case in the probe function.

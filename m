From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Thu, 28 Jun 2012 09:00:04 +0100
Subject: i.MX28 die temperature
In-Reply-To: <201206280058.26485.marex@denx.de>
References: <330B740BA662BF4E8386F534DF556ED819731A@AEDCEXC09.aei.com>
 <4FEAF75E.5090505@cam.ac.uk> <201206271433.15303.jbe@pengutronix.de>
 <201206280058.26485.marex@denx.de>
Message-ID: <4FEC0F04.90001@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/27/2012 11:58 PM, Marek Vasut wrote:
> Dear Juergen Beisert,
>
> [...]
>>
>> It requires a more or less complex state-machine to switch the used 4 or 5
>> pins to different modes to measure the X/Y position and the pressure. And
>> these pins interfere with the ADC input pins.
>>
>>> [...]
>
> I said I'll go through it, but it seems the IIO changed again, so I'll need to
> wrap my head around new stuff in there.
Yeah, sorry about that - people keep wanting new stuff ;)
>
> Besides, I have a feeling that the driver, as is, just simply doesn't fit in as
> it should. I'm discussing with Jonathan, since I can't really make heads or
> tails from the IIO api. It's way too complex and unless I really missed
> something, way underdocumented.
Any documentation writers welcome!
The real trick currently is to
a) figure out what is similar an already present
b) figure out if that driver is actually a good starting point. If it's
left staging then it's clean, but there may be a closer 'clean' driver
still in staging.

Having had documentation continually get left behind we did add
a 'dummy' driver that covers most stuff with lots of comments.
(still in staging at the mo staging/iio/iio_simple_dummy*)


>
>> Regards,
>> Juergen
>
> Best regards,
> Marek Vasut
>

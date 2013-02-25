From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 25 Feb 2013 17:21:49 +0800
Subject: Debugging missing interrupts
In-Reply-To: <1361781448.4640.49.camel@localhost>
References: <1361777691.4640.34.camel@localhost> <512B1AE6.6070903@atmel.com>
 <1361781448.4640.49.camel@localhost>
Message-ID: <512B2D2D.5000206@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/25/2013 16:37, lexa wrote:
> On Mon, 2013-02-25 at 16:03 +0800, Bo Shen wrote:
>> Hi Lexa,
>>
>> On 2/25/2013 15:34, lexa wrote:
>>>
>>> Hello.
>>>
>>> I have a trouble with debugging SSC interface(or maybe with audio
>>> codec). I have a board based on Atmel AT91 (at91sam9m10g45) and codec TI
>>> tlv320aic3106(using driver tlv320aic3x) connected to SSC interface in
>>> I2S mode.
>>
>> Which kernel version do you use?
>
> I use 3.2.38
>
>> SSC work as master or slave?
>>
>
> SSC works as slave for playback and for capture(as far as i know there
> no difference in configuration SSC controller). Audio codec is
> generating bit clock and word clock, and ARM is receiving them.
>
>>> Playback is works well, but the capture cause trouble.
>>> The problem is that arecord don't capture any data, he just writes wav
>>> header and nothing more.
>>
>> Which command do you use for recording? (it will give sample rate,
>> format, and etc)

any information for this?

>>
>>> Interrupt counter on ssc0 does not increased during capture.
>>> Also i checked data and clock lines by oscilloscope, and clearly see
>>> that clock and data transmitting from audio codec during capture.
>>> It's seem to me, that cpu somewhat doesn't accept data from codec. But i
>>> don't understand why, and how to debug this.

Please enable the kernel debug information, this will give out necessary 
register information for debugging. Please also provide it for analysis 
your problem.

>>> I know that provided information is insufficient, but i simply don't
>>> know how to get more detailed information about this problem.

Best Regards,
Bo Shen

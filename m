From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Sun, 04 Jul 2010 11:19:37 +0200
Subject: [PATCH 2/3] ASoC: Add SmartQ sound driver
In-Reply-To: <20100704090549.GD16825@opensource.wolfsonmicro.com>
References: <4c2e8856.487e0e0a.3bb5.3ec0@mx.google.com>
	<20100704090549.GD16825@opensource.wolfsonmicro.com>
Message-ID: <4C305229.30409@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Op 04-07-10 11:05, Mark Brown schreef:
> On Sat, Jul 03, 2010 at 02:46:12AM +0200, Maurus Cuelenaere wrote:
>> This adds sound support for the SmartQ board.
>>
>> The hardware consists of a S3C6410 coupled with a WM8987 over I?S. The WM8750
>> driver is used for driving the WM8987, as they are register compatible.
> I've applied this, but...
>
>> +static struct snd_soc_jack_pin smartq_jack_pins[] = {
>> +	/* Disable speaker when headphone is plugged in */
>> +	{
>> +		.pin	= "Internal Speaker",
>> +		.mask	= SND_JACK_HEADPHONE,
>> +		.invert	= true,
>> +	},
>> +};
> ...it probably also make sense to disable the headphone output when the
> headphone is not plugged in to save power?

I don't see what power there is to save? The speaker and headphone jack are connected to the same physical pins, so when disabling the pins for one of them, the other is also disabled.

The only way to disable the speaker is to shutdown its amplifier (using that GPIO pin).

-- 
Maurus Cuelenaere

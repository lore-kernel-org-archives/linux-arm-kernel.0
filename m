From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Sat, 03 Jul 2010 02:22:44 +0200
Subject: [alsa-devel] [PATCH 1/2] ASoC: Add SmartQ sound driver
In-Reply-To: <20100703001539.GA3869@sirena.org.uk>
References: <4c2e7f3e.887b0e0a.5935.3f95@mx.google.com>
	<20100703001539.GA3869@sirena.org.uk>
Message-ID: <4C2E82D4.90801@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Op 03-07-10 02:15, Mark Brown schreef:
> On Sat, Jan 30, 2010 at 06:23:14PM +0100, Maurus Cuelenaere wrote:
>
> Might want to check your mail setup - the date looks wrong.

Looks like it picked the date I first started this commit, will correct it next time.

>> This adds sound support for the SmartQ board.
>>
>> The hardware consists of a S3C6410 coupled with a WM8987 over I?S. As there's
>> no driver for the WM8987 currently, this uses the WM8750 driver (which should
>> be register compatible).
> There's no need to add a separate driver for a register compatible part,
> just add the I2C/SPI IDs to the existing driver.  Otherwise we just
> duplicate it redundantly.  Please update this and the comment in the
> driver to reflect that.

Ok, will do.

> Otherwise this looks OK, but there's a couple of things that it'd be
> nice to update:
>
>> +	dev_info(&smartq_snd_device->dev, "SmartQ WM8987 audio driver inited\n");
> Best to remove this, it gets a bit noisy.

Ok.

>> +MODULE_AUTHOR("Maurus Cuelenaere");
> Better to add your mail address too.

Ok.

-- 
Maurus Cuelenaere

From: krishna.md@samsung.com (D Krishna Mohan)
Date: Mon, 24 Nov 2014 12:48:31 +0530
Subject: [PATCH] ASoC: rt5631: Fixing compilation warning when DT is
 disabled
In-Reply-To: <20141117155617.GJ27002@pengutronix.de>
References: <1416232589-31319-1-git-send-email-krishna.md@samsung.com>
 <20141117155617.GJ27002@pengutronix.de>
Message-ID: <C8902B5E8A6B4B63A3B9A732345B33AD@sisodomain.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Attaching the patch with changes suggested by Uwe. Though there is another 
patch which I submitted, but I leave it to Mark Brown as to which patch to 
pick.

Previous patch :
>From 80b55f898d0a31b63fd6ed3bd82c548a0559b07b Mon Sep 17 00:00:00 2001
From: Krishna Mohan Dani <krishna.md@samsung.com>
Date: Mon, 17 Nov 2014 19:24:46 +0530
Subject: [PATCH 1/2] ASoC: rt5631: Fixing compilation warning when DT is
 disabled

-Krishna

--------------------------------------------------
From: "UweKleine-K?nig" <u.kleine-koenig@pengutronix.de>
Sent: Monday, November 17, 2014 9:26 PM
To: "Krishna Mohan Dani" <krishna.md@samsung.com>
Cc: <linux-samsung-soc@vger.kernel.org>; 
<linux-arm-kernel@lists.infradead.org>; <alsa-devel@alsa-project.org>; 
<broonie@kernel.org>; <kgene.kim@samsung.com>; "Claude Youn" 
<claude.youn@gmail.com>
Subject: Re: [PATCH] ASoC: rt5631: Fixing compilation warning when DT is 
disabled

> On Mon, Nov 17, 2014 at 07:26:29PM +0530, Krishna Mohan Dani wrote:
>> Fixes the following compilation warning:
>> Warning: 'rt5631_i2c_dt_ids' defined but not used - when DT is not used.
>>
>> Signed-off-by: Claude Youn <claude.youn@gmail.com>
>> Signed-off-by: Krishna Mohan Dani <krishna.md@samsung.com>
>> ---
>>  sound/soc/codecs/rt5631.c |    2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
>> index 3b7d5e4..9425545 100644
>> --- a/sound/soc/codecs/rt5631.c
>> +++ b/sound/soc/codecs/rt5631.c
>> @@ -1691,12 +1691,14 @@ static const struct i2c_device_id rt5631_i2c_id[] 
>> = {
>>  };
>>  MODULE_DEVICE_TABLE(i2c, rt5631_i2c_id);
>>
>> +#ifdef CONFIG_OF
>>  static struct of_device_id rt5631_i2c_dt_ids[] = {
>>  { .compatible = "realtek,rt5631"},
>>  { .compatible = "realtek,alc5631"},
>>  { }
>>  };
>>  MODULE_DEVICE_TABLE(of, rt5631_i2c_dt_ids);
>> +#endif
>
> An (IMHO nicer) alternative is:
>
> -static struct of_device_id rt5631_i2c_dt_ids[] = {
> +static struct of_device_id rt5631_i2c_dt_ids[] __maybe_unused = {
>
> Best regards
> Uwe
>
> -- 
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  | 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ASoC-rt5631-Fixing-compilation-warning-when-DT-is-di.patch
Type: application/octet-stream
Size: 1051 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141124/c50ab313/attachment.obj>

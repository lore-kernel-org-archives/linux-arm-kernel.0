From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 20 Jul 2017 22:30:45 +0200
Subject: [PATCH v3 06/12] mfd: wm97xx-core: core support for wm97xx Codec
In-Reply-To: <20170703090840.s5oae5qxd4fi6rhr@localhost.localdomain> (Charles
 Keepax's message of "Mon, 3 Jul 2017 10:08:40 +0100")
References: <20170630194408.24978-1-robert.jarzmik@free.fr>
 <20170630194408.24978-7-robert.jarzmik@free.fr>
 <20170703090840.s5oae5qxd4fi6rhr@localhost.localdomain>
Message-ID: <8760emsvey.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Charles Keepax <ckeepax@opensource.cirrus.com> writes:

> On Fri, Jun 30, 2017 at 09:44:02PM +0200, Robert Jarzmik wrote:
>> The WM9705, WM9712 and WM9713 are highly integrated codecs, with an
>> audio codec, DAC and ADC, GPIO unit and a touchscreen interface.
...
>> +static const struct reg_default wm97xx_reg_defaults[] = {
>> +};
>
> Should we not have some defaults in here?
Most certainly, I'll copy-paste the ones from :
 - sound/soc/codecs/wm9705.c
 - sound/soc/codecs/wm9712.c
>> +static int wm9705_register(struct wm97xx_priv *wm97xx)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int wm9712_register(struct wm97xx_priv *wm97xx)
>> +{
>> +	return 0;
>> +}
>> +
>
> So are we only adding stubs for the 9705 and 9712? If so we
> should probably make that clear in the commit message at least.
Mmmh, I think I've been too lazy here.
I'll add the true functions, which will be on par with wm9713_register(), adding
2 sub-cells, the codec and the touchscreen.

...zip..
>> +	codec_pdata.ac97 = wm97xx->ac97;
>> +	codec_pdata.regmap = devm_regmap_init_ac97(wm97xx->ac97,
>> +						   &wm9713_regmap_config);
>> +	codec_pdata.batt_pdata = pdata->batt_pdata;
>> +	if (IS_ERR(codec_pdata.regmap))
>> +		return PTR_ERR(codec_pdata.regmap);
>> +
>> +	return devm_mfd_add_devices(wm97xx->dev, -1, cells,
>
> Should probably use the define PLATFORM_DEVID_NONE here.
Yeah sure.

> Other than those minor comments looks ok to me.
Thanks Charles, I'll include them for next iteration.

Cheers.

-- 
Robert

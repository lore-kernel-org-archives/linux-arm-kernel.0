From: wxt@rock-chips.com (Caesar Wang)
Date: Wed, 08 Apr 2015 18:15:28 +0800
Subject: [PATCH] ASoC: max98090: add shutdown callback for max98090
In-Reply-To: <20150408095005.GS6023@sirena.org.uk>
References: <1428483128-23498-1-git-send-email-wxt@rock-chips.com>
 <1428483128-23498-2-git-send-email-wxt@rock-chips.com>
 <20150408095005.GS6023@sirena.org.uk>
Message-ID: <5524FFC0.4070900@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,


? 2015?04?08? 17:50, Mark Brown ??:
> On Wed, Apr 08, 2015 at 04:52:08PM +0800, Caesar Wang wrote:
>
>> +static void max98090_i2c_shutdown(struct i2c_client *i2c)
>> +{
>> +	struct max98090_priv *max98090 = dev_get_drvdata(&i2c->dev);
>> +
>> +	dev_info(&i2c->dev, "shut down device\n");
> Remove this, it's adding noise.

Done
>> +
>> +	/* Enable volume smoothing, disable zero cross.  This will cause
>> +	 * a quick 40ms ramp to mute on shutdown.
>> +	 */
>> +	regmap_write(max98090->regmap,
>> +		M98090_REG_LEVEL_CONTROL, M98090_VSENN_MASK);
>> +	regmap_write(max98090->regmap,
>> +		M98090_REG_DEVICE_SHUTDOWN, 0x00);
>> +	msleep(40);
>> +}
> This is OK but equivalent code should be being added to the driver
> remove path as the same thing should be happening there.
Yeah.I will fix it in v2 patch.

Thanks!

-- 
**************************************************************************************
???    Caesar Wang
??????   Product R&D Dept.III
??????????? Fuzhou Rockchip Electronics Co.Ltd
????????????????89????A?18?? ??????
         ???????????????21? ???????
Addr?  NO.18 Building, A District, Fuzhou Software Park,Gulou District,Fuzhou, Fujian,China(Fuzhou Headquarters)
          21F,Malata Building,Kejizhongyi Avenue,Nanshan District,Shenzhen  (Shenzhen Office)
Tel?+86-591-83991906/07 - 8221
Mobile:+86 15059456742
E-mail : wxt at rock-chips.com
***************************************************************************************
***************************************************************************************
???????????????????????????????????????????????? ??????????????
??????????????????????????????????????????????????????????????
??????????????????????????
  
IMPORTANT NOTICE: This email is from Fuzhou Rockchip Electronics Co., Ltd .The contents of this email and any attachments may
contain information that is privileged, confidential and/or exempt from disclosure under applicable law and relevant NDA.
If you are not the intended recipient, you are hereby notified that any disclosure, copying, distribution, or use of the
information is STRICTLY PROHIBITED. Please immediately contact the sender as soon as possible and destroy the material
in its entirety in any format. Thank you.
***************************************************************************************

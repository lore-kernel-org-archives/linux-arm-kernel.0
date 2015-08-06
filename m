From: ykk@rock-chips.com (Yakir Yang)
Date: Thu, 6 Aug 2015 23:20:48 +0800
Subject: [RFC PATCH 1/8] drm: exynos/dp: fix code style
In-Reply-To: <1438873536.2679.61.camel@perches.com>
References: <1438868947-22132-1-git-send-email-ykk@rock-chips.com>
 <1438869866-23028-1-git-send-email-ykk@rock-chips.com>
 <1438873536.2679.61.camel@perches.com>
Message-ID: <55C37B50.6050706@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joe,

? 2015/8/6 23:05, Joe Perches ??:
> On Thu, 2015-08-06 at 09:04 -0500, Yakir Yang wrote:
>> make checkpatch.pl script happy
> That should not be the primary reason to submit a patch.
>
> Making it easier for human code reader to understand
> what the code does should be though.
Thanks for your reply, but I do think that fix code style and make 
checkpatch.pl passed is my primary reason to submit this patch. I can't 
think out more directly words ;( ,

>> diff --git a/drivers/gpu/drm/exynos/exynos_dp_core.c b/drivers/gpu/drm/exynos/exynos_dp_core.c
> []
>> @@ -123,10 +123,11 @@ static int exynos_dp_read_edid(struct exynos_dp_device *dp)
>>   		dev_dbg(dp->dev, "EDID data includes a single extension!\n");
>>   
>>   		/* Read EDID data */
>> -		retval = exynos_dp_read_bytes_from_i2c(dp, I2C_EDID_DEVICE_ADDR,
>> -						EDID_HEADER_PATTERN,
>> -						EDID_BLOCK_LENGTH,
>> -						&edid[EDID_HEADER_PATTERN]);
>> +		retval =
>> +		exynos_dp_read_bytes_from_i2c(dp, I2C_EDID_DEVICE_ADDR,
>> +					      EDID_HEADER_PATTERN,
>> +					      EDID_BLOCK_LENGTH,
>> +					      &edid[EDID_HEADER_PATTERN]);
> This is a relatively uncommon style.
>
> Because the code uses relatively long variable and
> function names as well as longish macro #defines,
> prefer to ignore the 80 column limit.
Okay, I think it would be better to modify like those:

retval = exynos_dp_read_bytes_from_i2c(
		dp, I2C_EDID_DEVICE_ADDR,
		EDID_HEADER_PATTERN,
		EDID_BLOCK_LENGTH,
		&edid[EDID_HEADER_PATTERN]);


Is it okay ?

- Yakir
>
>
>
>

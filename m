From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 12 Sep 2009 00:12:52 +0800
Subject: [PATCH] video: add PXA3xx accelerator ID [v2]
In-Reply-To: <Pine.LNX.4.64.0909101530120.4458@axis700.grange>
References: <20090910132630.GZ9410@buzzloop.caiaq.de>
	<Pine.LNX.4.64.0909101530120.4458@axis700.grange>
Message-ID: <f17812d70909110912q41c45dcfl8410e3fb51ec7e9c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Ok, now remove 'cpu_is_pxa3xx() && ' above and you should be good to go:-)
> What if tomorrow pxa4xx comes (ok, Eric will disagree, but wtill:-))

It is not likely to be pxa4xx, (chinese people don't like '4', and there are
a lot chinese in Marvell, Shhh..... don't let them know I said this ;-)

Still, I guess having a cpu_is_pxa3xx() should be OK here.

>
>> ? ? ? fbi->backlight_power = inf->pxafb_backlight_power;
>> ? ? ? fbi->lcd_power = inf->pxafb_lcd_power;
>>
>> diff --git a/include/linux/fb.h b/include/linux/fb.h
>> index f847df9..a34bdf5 100644
>> --- a/include/linux/fb.h
>> +++ b/include/linux/fb.h
>> @@ -133,6 +133,7 @@ struct dentry;
>> ?#define FB_ACCEL_NEOMAGIC_NM2230 96 ?/* NeoMagic NM2230 ? ? ? ? ? ? ?*/
>> ?#define FB_ACCEL_NEOMAGIC_NM2360 97 ?/* NeoMagic NM2360 ? ? ? ? ? ? ?*/
>> ?#define FB_ACCEL_NEOMAGIC_NM2380 98 ?/* NeoMagic NM2380 ? ? ? ? ? ? ?*/
>> +#define FB_ACCEL_PXA3XX ? ? ? ? ? ? ? 99 ? ? /* PXA3xx ? ? ? ? ? ? ? ? ? ? ? */
>>
>> ?#define FB_ACCEL_SAVAGE4 ? ? ? ?0x80 /* S3 Savage4 ? ? ? ? ? ? ? ? ? */
>> ?#define FB_ACCEL_SAVAGE3D ? ? ? 0x81 /* S3 Savage3D ? ? ? ? ? ? ? ? ?*/
>> --
>> 1.6.3.3
>>
>
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
>

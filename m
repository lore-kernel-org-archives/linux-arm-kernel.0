From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Tue, 10 Nov 2009 17:46:01 +0100
Subject: [PATCH]: S3C RTC driver: add support for S3C64xx
In-Reply-To: <1b68c6790911100553m267f35dav9638fc6c0340978d@mail.gmail.com>
References: <b2e8f9f70911091746t845b285m3d30314ce7e9fd07@mail.gmail.com>
	<1b68c6790911100553m267f35dav9638fc6c0340978d@mail.gmail.com>
Message-ID: <4AF998C9.3060208@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Op 10-11-09 14:53, jassi brar schreef:
> On Tue, Nov 10, 2009 at 10:46 AM, Maurus Cuelenaere
> <mcuelenaere@gmail.com>  wrote:
>    
>> <snip>
>>
>> +static struct s3c_rtc_platdata s3c_rtc_pdata = {
>> +       .rtc_type       = 0,
>> +};
>>      
> 1) where is this structure defined?
>      Perhaps u forgot to share the plat/rtc.h
>    

Hmm seems I did forgot to include plat/rtc.h ..

> 2) rtc_type isn't very neat. Runtime CPU detection is better.
>   Even better, if you manage to segregate the differences between
> two versions and pass them via platform data somehow.
> For, example, driver could assume resolution as pdata->resolution
> instead of 128 or 32768 or whatever for future SoCs.
>    

pdata->resolution sounds like a good idea.

>> <snip>
>>   #else
>> @@ -518,7 +563,7 @@ static struct platform_driver s3c2410_rtc_driver = {
>>         .suspend        = s3c_rtc_suspend,
>>         .resume         = s3c_rtc_resume,
>>         .driver         = {
>> -               .name   = "s3c2410-rtc",
>> +               .name   = "s3c-rtc",
>>                 .owner  = THIS_MODULE,
>>         },
>>   };
>>      
> why not use platform_device_id ?
>    

I didn't know of platform_device_id, looks like a clean(er) solution for 
this.


I'll post an updated patch with Jassi's and Ben's remarks in mind.

Regards,
Maurus Cuelenaere

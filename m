From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Thu, 31 Jul 2014 21:21:28 +0200
Subject: [PATCH v4 3/4] ARM: dts: Clean up exynos5250-snow
In-Reply-To: <53DA96C7.30009@gmail.com>
References: <1406822910-6255-1-git-send-email-afaerber@suse.de>
 <1406822910-6255-4-git-send-email-afaerber@suse.de>
 <53DA96C7.30009@gmail.com>
Message-ID: <53DA9738.6080809@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 31.07.2014 21:19, schrieb Tomasz Figa:
> Andreas,
> 
> Please see my comments inline.
> 
> On 31.07.2014 18:08, Andreas F?rber wrote:
>> Use the new style of referencing inherited nodes and use symbolic names.
>>
>> Suggested-by: Doug Anderson <dianders@chromium.org>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> 
> [snip]
> 
>> -
>>  	usb at 12110000 {
>> -		samsung,vbus-gpio = <&gpx1 1 0>;
>> +		samsung,vbus-gpio = <&gpx1 1 GPIO_ACTIVE_HIGH>;
>>  	};
> 
> This is a higher level node being overridden, so it should be specified
> using references too.
> 
>>  
>>  	fixed-rate-clocks {
>> @@ -287,7 +206,7 @@
>>  	};
>>  
>>  	hdmi {
> 
> Ditto.

Same problem as with spring: We need the labels first!

Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg

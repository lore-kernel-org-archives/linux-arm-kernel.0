From: mirqus@gmail.com (=?ISO-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Wed, 16 Nov 2011 18:57:21 +0100
Subject: [PATCH 1/3] drivers: base: add support for stmp-style devices
In-Reply-To: <201111161744.19733.arnd@arndb.de>
References: <1321440459-4527-1-git-send-email-w.sang@pengutronix.de>
 <1321440459-4527-2-git-send-email-w.sang@pengutronix.de>
 <201111161744.19733.arnd@arndb.de>
Message-ID: <CAHXqBFJigr+Ut5vaY-g0uDU3GnHyvHfJH9RsTUBRQ6kW8BmhsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/11/16 Arnd Bergmann <arnd@arndb.de>:
> On Wednesday 16 November 2011, Wolfram Sang wrote:
[...]
>> --- /dev/null
>> +++ b/include/linux/stmp_device.h
>> @@ -0,0 +1,19 @@
>> +#ifndef __STMP_DEVICE_H__
>> +#define __STMP_DEVICE_H__
>> +
>> +#define STMP_SET_ADDR ? ? ? ? ? ? ? ?0x4
>> +#define STMP_CLR_ADDR ? ? ? ? ? ? ? ?0x8
>> +#define STMP_TOG_ADDR ? ? ? ? ? ? ? ?0xc
>
> The register numbers should probably go into the implementation file,
> they are not an interface.

Those are offsets - for every register there are "shadow" registers
that do implicit OR, AND NOT, XOR of that register with value written.
There might be better names for those.

Best Regards,
Micha? Miros?aw

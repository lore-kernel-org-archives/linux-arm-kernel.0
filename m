From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Tue, 11 Sep 2012 21:39:45 +0530
Subject: [PATCH 13/16] ARM: omap: move platform_data definitions
In-Reply-To: <CAMQu2gz8F2FcgRuok3x1uJ4pP8=0E2-9jhYGchzU9AUtUHjYhg@mail.gmail.com>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <1347368559-31329-1-git-send-email-arnd@arndb.de>
 <CAMQu2gwLoccyjGwjjgndiW2aR--_S=UhCCTdcav6LicvYWe5SQ@mail.gmail.com>
 <201209111417.42879.arnd@arndb.de>
 <CAMQu2gz8F2FcgRuok3x1uJ4pP8=0E2-9jhYGchzU9AUtUHjYhg@mail.gmail.com>
Message-ID: <504F6249.2090501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 9/11/2012 7:54 PM, Shilimkar, Santosh wrote:
> On Tue, Sep 11, 2012 at 7:47 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Tuesday 11 September 2012, Shilimkar, Santosh wrote:
>>> Just curious to know how you came with some of the above header names ?
>>>
>>> plat/mcbsp ---> dsp-mcbsp.h
>>> There is no connection of DSP with McBSP. "omap-mcbsp.h" would been a
>>> better name.
>>
>> This one was a mistake on my side, as Tony and  Peter already pointed out.
>> How about asoc-mcbsp.h or asoc-omap-mcbsp.h?
>>
> After re-reading the cover-letter and your below response,
> 'asoc-omap-mcbsp.h' seems to be fine.
> 

Note that mcbsp is also applicable to Davinci family of devices.

Thanks,
Vaibhav

>>> plat/nand.h --> /mtd-nand-omap2.h
>>> plat/onenand.h --> /mtd-onenand-omap2.h
>>> May be "omap-nand.h" and "omap-onenand.h"
>>>
>>> plat/mcspi.h-->spi-omap2-mcspi.h
>>> May be "omap-spi.h"
>>>
>>
>> As I wrote in the introductory mail, I tried to always prefix the file
>> names with the subsystem, followed by the name of the driver, in order
>> to standardize on just one set of rules.
>>
> Just read that now.
> 
>> The drivers implementing the three headers above are:
>>
>> drivers/mtd/nand/omap2.c
>> drivers/mtd/onenand/omap2.c
>> drivers/spi/spi-omap2-mcspi.c
>>
>> so these all seem appropriate.
>>
> Sorry I missed the subsystem prefix point.
> These names seems to be fine then.
> 
> Regards
> Santosh
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

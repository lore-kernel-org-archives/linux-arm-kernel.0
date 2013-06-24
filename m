From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 24 Jun 2013 17:04:29 +0530
Subject: [PATCH v12 05/11] edma: config: Enable config options for EDMA
In-Reply-To: <51C82C3C.8040506@ti.com>
References: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
 <201306211632.12577.arnd@arndb.de>
 <CAD=GYpbhBAaSkMtcJaPtVpWar7AcW37QpAk3A0qgwX6G5PDoZg@mail.gmail.com>
 <201306212044.26677.arnd@arndb.de>
 <CAD=GYpY4koXd9f6_ijQfDHsiULD4d53cdu=9X421WXSAit_YQg@mail.gmail.com>
 <51C82C3C.8040506@ti.com>
Message-ID: <51C82EC5.8070102@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/24/2013 4:53 PM, Sekhar Nori wrote:
> On 6/22/2013 3:23 AM, Joel A Fernandes wrote:
>> Hi Arnd,
>>
>> On Fri, Jun 21, 2013 at 1:44 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Friday 21 June 2013, Joel A Fernandes wrote:
>>>> I think we are talking about different things, I agree the 'select
>>>> DMADEVICES' can be dropped but lets please keep the default y option
>>>> (not adding new select statements, just saying that if someone select
>>>> DMADEVICES in menuconfig and if they're ARCH_OMAP=1 , then default to
>>>> EDMA). This will simply allow people to have a default. Thanks.
>>>
>>> Yes, that's ok.
>>
>> Ok, thanks. I will follow up with a patch in my next submissions that builds it.
>>
>> Perhaps a:
>> default y if 'ARCH_OMAP2PLUS'
>>
>> and leave the existing as it is...
>> default n if  'ARCH_DAVINCI || ARCH_OMAP1 || ARCH_OMAP2'
>>
>> would make most sense to me. Basically EDMA is seen on current and all
>> new OMAP2PLUS.
> 
> OMAP2PLUS devices like OMAP3/4 do not have EDMA so this is not really true.

More accurately, there is EDMA hardware on these devices, but its usage
is limited to DSP. ARM uses SDMA instead.

Thanks,
Sekhar

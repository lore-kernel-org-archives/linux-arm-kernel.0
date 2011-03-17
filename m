From: b-cousson@ti.com (Cousson, Benoit)
Date: Thu, 17 Mar 2011 09:19:43 +0100
Subject: [PATCH 1/2] arm: mach-omap2: devices: fix omap3_l3_init() return
	value
In-Reply-To: <324bffcaf53be55bd6f392af3f86fa10@mail.gmail.com>
References: <1300295763-497-1-git-send-email-aaro.koskinen@nokia.com>
	<324bffcaf53be55bd6f392af3f86fa10@mail.gmail.com>
Message-ID: <4D81C41F.8090702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

On 3/17/2011 6:52 AM, Shilimkar, Santosh wrote:
>> -----Original Message-----
>> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-
>> arm-kernel-bounces at lists.infradead.org] On Behalf Of Aaro Koskinen
>> Sent: Wednesday, March 16, 2011 10:46 PM
>> To: linux-omap at vger.kernel.org; linux-arm-
>> kernel at lists.infradead.org; tony at atomide.com
>> Cc: Aaro Koskinen
>> Subject: [PATCH 1/2] arm: mach-omap2: devices: fix omap3_l3_init()
>> return value
>>
>> Fix the return value for the successful case.
>>
>> Signed-off-by: Aaro Koskinen<aaro.koskinen@nokia.com>
>> ---
>>   arch/arm/mach-omap2/devices.c |    2 +-
>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-
>> omap2/devices.c
>> index 0d2d6a9..d478f53 100644
>> --- a/arch/arm/mach-omap2/devices.c
>> +++ b/arch/arm/mach-omap2/devices.c
>> @@ -65,7 +65,7 @@ static int __init omap3_l3_init(void)
>>
>>   	WARN(IS_ERR(od), "could not build omap_device for %s\n",
>> oh_name);
>>
>> -	return PTR_ERR(od);
>> +	return IS_ERR(od) ? PTR_ERR(od) : 0;
>>   }
>>   postcore_initcall(omap3_l3_init);

Maybe we should initialize that before, because in theory the timer12 
secure violation should have been captured easily with this code?

Regards,
Benoit

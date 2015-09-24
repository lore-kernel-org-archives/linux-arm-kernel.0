From: m-karicheri2@ti.com (Murali Karicheri)
Date: Thu, 24 Sep 2015 10:05:23 -0400
Subject: [PATCH 1/3] Documentation: dt: keystone: provide SoC specific
 compatible flags
In-Reply-To: <5602ED34.9010108@oracle.com>
References: <1442938118-4718-1-git-send-email-nm@ti.com>
 <1442938118-4718-2-git-send-email-nm@ti.com> <5602ED34.9010108@oracle.com>
Message-ID: <56040323.1080409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/23/2015 02:19 PM, santosh shilimkar wrote:
> Nishant,
>
> On 9/22/2015 9:08 AM, Nishanth Menon wrote:
>> Keystone2 devices are used on more platforms than just Texas
>> Instruments reference evaluation platforms called EVMs. Providing a
>> generic compatible "ti,keystone" is not sufficient to differentiate
>> various SoC definitions possible on various platforms. So, provide
>> compatible matches for each SoC family by itself.
>>
>> This allows SoC specific logic to be run time handled based on
>> of_machine_is_compatible("ti,k2hk") or as needed for the dependent
>> processor instead of needing to use board dependent compatibles that
>> are needed now.
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
> You need to expand that 'not sufficient' for me. Unless there is
> genuine case to support this, I would want to avoid this churn.
>

I agree. If there are run time check required in code to treat the 
variants of Keystone SoC differently, then this change is needed. At 
this time, SoC DTS captures these differences. IMHO, If a future 
Keystone SoC support required SoC specific compatibility string to 
customize SoC specific initialization code, then it can be introduced at 
that time. I am not sure why this is introduced with out an example usage.

> Regards,
> Santosh
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>


-- 
Murali Karicheri
Linux Kernel, Keystone

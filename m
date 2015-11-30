From: julien.grall@citrix.com (Julien Grall)
Date: Mon, 30 Nov 2015 15:01:20 +0000
Subject: [Xen-devel] [PATCH v3 22/62] arm/gic-v3: Refactor gicv3_init
 into generic and dt specific parts
In-Reply-To: <alpine.DEB.2.02.1511241046350.1107@kaball.uk.xensource.com>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-23-git-send-email-shannon.zhao@linaro.org>
 <alpine.DEB.2.02.1511241046350.1107@kaball.uk.xensource.com>
Message-ID: <565C64C0.7080506@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/11/15 10:51, Stefano Stabellini wrote:
> On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
>> From: Shannon Zhao <shannon.zhao@linaro.org>
>>
>> Refactor gic-v3 related functions into dt and generic parts. This will be
>> helpful when adding acpi support for gic-v3.
>>
>> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
>> ---
>>  xen/arch/arm/gic-v3.c | 95 +++++++++++++++++++++++++++------------------------
>>  1 file changed, 51 insertions(+), 44 deletions(-)
>>
>> diff --git a/xen/arch/arm/gic-v3.c b/xen/arch/arm/gic-v3.c
>> index 4fe0c37..bd13010 100644
>> --- a/xen/arch/arm/gic-v3.c
>> +++ b/xen/arch/arm/gic-v3.c
>> @@ -1138,62 +1138,27 @@ static int __init cmp_rdist(const void *a, const void *b)
>>      return ( l->base < r->base) ? -1 : 0;
>>  }
>>  
>> +static paddr_t __initdata dbase = 0, cbase = 0, csize = 0, vbase = 0;
> 
> It might be best to initialize them to something like INVALID_PADDR
> rather then 0, which is actually a possible address value.

It's even mandatory, we had a patch [1] to allow base address to be 0
and there is no point to re-introduce this restriction.

Regards,

[1] c1fde0dcd4ecb78378ffe8b3e263d28dc3b9c0eb "xen/arm: gic: Allow the
base address to be 0"

-- 
Julien Grall

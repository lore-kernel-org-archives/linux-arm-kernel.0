From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 21 Jul 2014 14:22:34 -0700
Subject: [PATCHv4 4/5] arm: use genalloc for the atomic pool
In-Reply-To: <20140704134254.GA4142@ulmo>
References: <1404324218-4743-1-git-send-email-lauraa@codeaurora.org>
 <1404324218-4743-5-git-send-email-lauraa@codeaurora.org>
 <20140704134254.GA4142@ulmo>
Message-ID: <53CD849A.1000800@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/4/2014 6:42 AM, Thierry Reding wrote:
> On Wed, Jul 02, 2014 at 11:03:37AM -0700, Laura Abbott wrote:
> [...]
>> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> [...]
>> index f5190ac..02a1939 100644
>> --- a/arch/arm/mm/dma-mapping.c
>> +++ b/arch/arm/mm/dma-mapping.c
>> @@ -26,6 +26,7 @@
>>  #include <linux/io.h>
>>  #include <linux/vmalloc.h>
>>  #include <linux/sizes.h>
>> +#include <linux/genalloc.h>
> 
> Includes should be sorted alphabetically. I realize that's not the case
> for this particular file, but the downside of that is that your patch no
> longer applies cleanly on top of linux-next because some other patch did
> add linux/cma.h at the same location.
> 

Yes, I'll fix that up. I'll put genalloc.h before gfp.h.

>>  static int __init early_coherent_pool(char *p)
>>  {
>> -	atomic_pool.size = memparse(p, &p);
>> +	atomic_pool_size = memparse(p, &p);
>>  	return 0;
>>  }
>>  early_param("coherent_pool", early_coherent_pool);
>>  
>> +
> 
> There's a gratuituous blank line her.
> 
> I also need the below hunk on top of you patch to make this compile on
> ARM.
> 

Yes, that does indeed need to be fixed up.

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

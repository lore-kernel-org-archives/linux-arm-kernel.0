From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 9 Mar 2017 12:55:52 +0000
Subject: [PATCH v2 2/4] ARM: nommu: dynamic exception base address setting
In-Reply-To: <20170309124640.GA8369@afzalpc>
References: <314159a7-b664-1256-647d-c05880ad7710@uclinux.org>
 <20170308162258.GA3515@afzalpc>
 <7ab1dfbd-9240-4f4b-70e2-d09ffc1039de@uclinux.org>
 <20170309124640.GA8369@afzalpc>
Message-ID: <49b9120d-bafa-e6ba-53c5-5bedd328d628@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03/17 12:46, afzal mohammed wrote:
> Hi,
> 
> On Thu, Mar 09, 2017 at 09:51:58AM +1000, Greg Ungerer wrote:
>> The patch below works too. Thanks for the quick response.
> 
> Thanks Greg for verifying
> 
> Vladimir, would the diff like below okay ?

Well, we should ask Russell which version he (dis)likes :)

Cheers
Vladimir

> 
> Regards
> afzal
> 
>>> ---8<---
>>> diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
>>> index 3b5c7aaf9c76..081562f5436e 100644
>>> --- a/arch/arm/mm/nommu.c
>>> +++ b/arch/arm/mm/nommu.c
>>> @@ -303,7 +303,9 @@ static inline void set_vbar(unsigned long val)
>>>   */
>>>  static inline bool security_extensions_enabled(void)
>>>  {
>>> -	return !!cpuid_feature_extract(CPUID_EXT_PFR1, 4);
>>> +	if ((read_cpuid_id() & 0x000F0000) == 0x000F0000)
>>> +		return !!cpuid_feature_extract(CPUID_EXT_PFR1, 4);
>>> +	return 0;
>>>  }
>>>  
>>>  static unsigned long __init setup_vectors_base(void)
>>>
> 

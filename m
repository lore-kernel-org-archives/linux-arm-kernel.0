From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 22 Aug 2016 12:56:52 -0600
Subject: [PATCH v3 05/12] firmware: tegra: Add BPMP support
In-Reply-To: <5669893.Rd6yQObxH6@wuerfel>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
 <2059006.oN1pE0IkCo@wuerfel> <20160822140211.GE17367@ulmo.ba.sec>
 <5669893.Rd6yQObxH6@wuerfel>
Message-ID: <866add72-703b-86e1-6e3e-04dbfb872970@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22/2016 08:42 AM, Arnd Bergmann wrote:
> On Monday, August 22, 2016 4:02:11 PM CEST Thierry Reding wrote:
>> On Mon, Aug 22, 2016 at 03:34:15PM +0200, Arnd Bergmann wrote:
>>> On Friday, August 19, 2016 7:32:26 PM CEST Thierry Reding wrote:
>>>> diff --git a/include/soc/tegra/bpmp-abi.h b/include/soc/tegra/bpmp-abi.h
>>>> new file mode 100644
>>>> index 000000000000..0aaef5960e29
>>>> --- /dev/null
>>>> +++ b/include/soc/tegra/bpmp-abi.h
>>>> +#ifndef _ABI_BPMP_ABI_H_
>>>> +#define _ABI_BPMP_ABI_H_
>>>> +
>>>> +#ifdef LK
>>>> +#include <stdint.h>
>>>> +#endif
>>>> +
>>>> +#ifndef __ABI_PACKED
>>>> +#define __ABI_PACKED __attribute__((packed))
>>>> +#endif
>>>> +
>>>> +#ifdef NO_GCC_EXTENSIONS
>>>> +#define EMPTY char empty;
>>>> +#define EMPTY_ARRAY 1
>>>> +#else
>>>> +#define EMPTY
>>>> +#define EMPTY_ARRAY 0
>>>> +#endif
>>>> +
>>>> +#ifndef __UNION_ANON
>>>> +#define __UNION_ANON
>>>> +#endif
>>>
>>> Maybe keep these all out of the kernel?
>>
>> This was discussed a little in an earlier posting. This header file is
>> maintained by the BPMP firmware team and using it verbatim means little
>> to no effort required to update it.
>
> The usual recommendation is to just use Linux coding style in shared
> files, and possibly add another header that provides the required
> definitions. Otherwise you end up with people randomly cleaning up
> the file later ;-)

That's just going to push the problem into all other operating systems; 
what happens when BSD, Windows, QNX, FreeRTOS, ... import this file and 
attempt to apply the same argument, but want the FW team to use their 
coding style?

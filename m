From: pankaj.dubey@samsung.com (pankaj.dubey)
Date: Mon, 19 Dec 2016 18:55:53 +0530
Subject: [PATCH v8 0/8] Introducing Exynos ChipId driver
In-Reply-To: <7504d7e6-4f1e-52c9-a526-33af47ab5d99@samsung.com>
References: <CGME20161210130616epcas1p2ce44d503ae03854e7b36b4d37d54900a@epcas1p2.samsung.com>
 <1481375323-29724-1-git-send-email-pankaj.dubey@samsung.com>
 <7504d7e6-4f1e-52c9-a526-33af47ab5d99@samsung.com>
Message-ID: <9e7466f3-ff3d-e4d4-1368-40491d59202c@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Friday 16 December 2016 06:41 PM, Marek Szyprowski wrote:
> Hi Pankaj
> 
> 
> On 2016-12-10 14:08, Pankaj Dubey wrote:
>> Each Exynos SoC has ChipID block which can give information about SoC's
>> product Id and revision number.
>>
>> This patch series introduces Exynos Chipid SoC driver. At the same time
>> it reduces dependency of mach-exynos files from plat-samsung, by removing
>> soc_is_exynosMMMM and samsung_rev API. Instead of it now we can use
>> soc_device_match API proposed by Arnd and getting discussed in thread
>> [1].
>>
>> Until now we are using static mapping of Exynos Chipid and using this
>> static
>> mapping to know about SoC name and revision via soc_is_exynosMMMM
>> macro. This
>> is quite cumbersome and every time new ARMv7 based Exynos SoC supports
>> lands in
>> mainline a bunch of such new macros needs to be added. Quite long back
>> during
>> support of Exynos5260 it has been discussed to solve this problem.
>>
>> To solve this issue this patchset replaces use of soc_is_exynosMMMM by
>> either
>> of_machine_is_compatible or soc_device_match depending upon usecase.
>>
>> I have tested this patch series on Exynos4210 based Origen board for
>> normal SMP
>> boot.
>>
>>
>> Although I submitted this series as a whole of 8 patchsets, following
>> are dependency
>> details among the patches.
>>
>> Patch 1/8 can be taken without any dependency on other patches.
>> Patch 2/8 and 3/8 has dependency on 1/8 and can be taken along with 1/8.
>> Patch 4/8 has no dependency and can be taken without chipid driver
>> patch 1/8.
>> Patch 5/8 has depency on 1/8
>> Patch 6/8 has no dependency and can be taken without any other patches.
>> Patch 7/8 has dependency on 6/8 and 1/8
>> Patch 8/8 has dependency on rest of patches
> 
> Which kernel should I use as a base for applying those patches? I wanted
> to test them,
> but I got conflicts both for v4.9 and current linux-next (next-20161216).
> 


Sorry for late reply.
Actually these patches were created on top of Krzysztof's for-next
dated: 05/11/2016, I can think for because of following patches [1] and
[2] you might be getting conflict in latest tree. So if possible please
apply following patches on top of Krzysztof's current for-next and then try
[1]: https://patchwork.kernel.org/patch/9421017/
[2]: https://patchwork.kernel.org/patch/9419099/

Hopefully all chipid patches will get applied on top of it. Otherwise I
will be posting v9 very soon after addressing all review comments of v8.
So please test on v9.

Thanks,
Pankaj Dubey

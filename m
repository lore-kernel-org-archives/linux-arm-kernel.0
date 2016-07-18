From: tjakobi@math.uni-bielefeld.de (Tobias Jakobi)
Date: Mon, 18 Jul 2016 13:00:43 +0200
Subject: [PATCH v2 00/10] Exynos IOMMU: proper runtime PM support (use
 device dependencies)
In-Reply-To: <a15e438a-7fa0-3a4d-e6e2-13425512dddd@samsung.com>
References: <1466144820-6286-1-git-send-email-m.szyprowski@samsung.com>
 <5787B2B0.9020809@math.uni-bielefeld.de>
 <5788E352.3040801@math.uni-bielefeld.de>
 <a15e438a-7fa0-3a4d-e6e2-13425512dddd@samsung.com>
Message-ID: <578CB6DB.90608@math.uni-bielefeld.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Marek,


Marek Szyprowski wrote:
> Hi Tobias,
> 
> 
> On 2016-07-15 15:21, Tobias Jakobi wrote:
>> Tobias Jakobi wrote:
>>> Hello Marek,
>>>
>>> I've tested the patchset on 4.7-rc7 and noticed that it breaks reboot on
>>> my ODROID-X2.
>>>
>>> Going to check where exactly things break.
>> Sadly it's the last patch where everything comes together:
>> "iommu/exynos: Add proper runtime pm support"
>>
>> I still have to check if forcing runpm status to 'on' makes a
>> difference. I suspect that the aggressive clock gating might be the
>> reason?
> 
> Thanks for testing. I will check this issue. Could you send me your
> .config?
This is the config I'm currently using:
https://github.com/tobiasjakobi/odroid-environment/blob/master/sourcecode/system/vanilla-4.7-debug.conf

Do you think checking this with no_console_suspend makes sense?

- Tobias


> 
> Best regards

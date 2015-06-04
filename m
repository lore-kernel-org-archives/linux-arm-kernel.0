From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 04 Jun 2015 15:10:22 +0900
Subject: [PATCH 0/6] Exynos SYSMMU (IOMMU) dts and arch updates
In-Reply-To: <556FCB2B.8090406@samsung.com>
References: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
 <1433153450-3680-1-git-send-email-m.szyprowski@samsung.com>
 <556C4342.6060506@samsung.com> <556F89B2.9010607@kernel.org>
 <556FCB2B.8090406@samsung.com>
Message-ID: <556FEBCE.9050604@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04.06.2015 12:51, Krzysztof Kozlowski wrote:
> On 04.06.2015 08:11, Kukjin Kim wrote:
>> On 06/01/15 20:34, Krzysztof Kozlowski wrote:
>>> W dniu 01.06.2015 o 19:10, Marek Szyprowski pisze:
>>>> Hello,
>>>>
>>>> Main changes for Exynos SYSMMU (IOMMU) driver has been finally scheduled
>>>> for merging - see
>>>> https://git.kernel.org/cgit/linux/kernel/git/joro/iommu.git/commit/?h=next
>>>> In meantime there have been quite a lot of changes related to Exynos DTS
>>>> files queued for merging and my patches don't apply anymore. To ease
>>>> merge process I've decided to rebased all Exynos SYSMMU dts changes onto
>>>> latest exynos next tree from: https://github.com/krzk/linux dt-for-next
>>>>
>>>> While rebasing I've fixes a few spotted issues: some nodes still used
>>>> old 'samsung,power-domain' properties (now replaced with 'power-domains')
>>>> and added properties to jpeg codec merged recently.
>>>>
>>>
>>> Thanks for rebasing this stuff.
>>>
>> Same here ;-)
>>
>>> I picked whole patchset with Javier's tested-by. I'll send it to Kukjin
>>> later or directly to arm-soc (depending what will happen with last pull
>>> request).
>>>
>>> Kukjin, you mentioned that you will do something with this patchset the
>>> previous weekend. Since then nothing happened so I am not sure what are
>>> your plans... Can you share them? Do you want to pick it by yourself, do
>>> you have any comments or maybe you need something from our side? (I
>>> checked the patches and they look fine)
>>>
>> Done, thanks.
> 
> Thank you, I tested the for-next branch on some of my boards and
> everything looked fine.

Oh, something wrong happened on some of configs/boards:

Arndale Octa: multi_v7_defconfig
Last tests on samsung tree fail:
1.
http://kernelci.org/boot/exynos5420-arndale-octa_rootfs:nfs/job/samsung/kernel/v4.1-rc6-146-g1c07c562d9d5/defconfig/multi_v7_defconfig/lab/lab-tbaker/?_id=556fbaee59b5146b5cda4447
2.
http://kernelci.org/boot/exynos5420-arndale-octa_rootfs:nfs/job/samsung/kernel/v4.1-rc6-137-g1730fe10f4a8/defconfig/multi_v7_defconfig/lab/lab-tbaker/?_id=556e948659b5144e74da4445

Odroid XU3: multi_v7_defconfig
Last commit fails:
http://kernelci.org/boot/exynos5422-odroidxu3_rootfs:nfs/job/samsung/kernel/v4.1-rc6-146-g1c07c562d9d5/defconfig/multi_v7_defconfig/lab/lab-tbaker/?_id=556fbb2d59b5146b63da4449

I can test tonight on Odroid XU3 but I don't have access to Arndale Octa
board. Maybe guys from SRPOL could test it?

Best regards,
Krzysztof

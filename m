From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 10 Jan 2018 18:19:50 +0900
Subject: [RFC PATCH 0/9] soc: samsung: Add support of suspend-to-RAM on
 Exynos5433
In-Reply-To: <CAJKOXPcJPbVR+WqAzhM8Tuud1Pd9W2p_23iTUveXc5aJtgTJCg@mail.gmail.com>
References: <CGME20180109075904epcas2p302d58aacfbb2195e455a25c90a1c610b@epcas2p3.samsung.com>
 <1515484746-10656-1-git-send-email-cw00.choi@samsung.com>
 <CAJKOXPcJPbVR+WqAzhM8Tuud1Pd9W2p_23iTUveXc5aJtgTJCg@mail.gmail.com>
Message-ID: <5A55DAB6.2020808@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018? 01? 09? 20:56, Krzysztof Kozlowski wrote:
> On Tue, Jan 9, 2018 at 8:58 AM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> In the mainline, there is no case to support the suspend-to-RAM for Samsung
>> Exynos SoC. This patchset support the suspend-to-RAM for 64bit Exynos SoC.
>>
>> For 32bit, arch/arm/mach-exynos/* directoy contains the suspend-related
>> codes such as suspend.c/exynos.c. But, 64bit Exynos should contain
>> the suspend-related codes in the drivers/soc/samsung/*. So, this patchset
>> develop the patch4/5 for drivers/soc/samsung/exynos-pm.c. to support suspend
>> 64bit Exynos SoC.
>>
>> But, I'm not sure what is proper approach for both 32/64bit Exynos.
>> - Approach1 : Split out the supend-related codes between 32/64bit.
>>   : arch/arm/mach-exynos/* contains the suspend-related codes for 32bit.
>>   : drivers/soc/samsung/* contains the suspend-related codes for 64bit.
>> - Approach2 : Consolidate the all suspend-related codes to drivers/soc/samsung/.
> 
> I prefer approach #2 - consolidate the code... unless this creates
> some unmaintainable monster :)

I'll try to consolidate code.

[snip]

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

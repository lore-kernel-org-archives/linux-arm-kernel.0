From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 15 Jul 2015 15:11:16 -0700
Subject: [PATCH v2 3/4] arm64: Add Broadcom iProc family support
In-Reply-To: <55A6D8C8.6030901@broadcom.com>
References: <1436935343-4437-1-git-send-email-rjui@broadcom.com>
 <1436935343-4437-4-git-send-email-rjui@broadcom.com>
 <55A6D673.1040908@hauke-m.de> <55A6D8C8.6030901@broadcom.com>
Message-ID: <55A6DA84.8070504@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/07/15 15:03, Ray Jui wrote:
> 
> 
> On 7/15/2015 2:53 PM, Hauke Mehrtens wrote:
>> On 07/15/2015 06:42 AM, Ray Jui wrote:
>>> This patch adds support to Broadcom's iProc family of arm64 based SoCs
>>> in the arm64 Kconfig and defconfig files
>>>
>>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>>> ---
>>>  arch/arm64/Kconfig           |    5 +++++
>>>  arch/arm64/configs/defconfig |    2 ++
>>>  2 files changed, 7 insertions(+)
>>>
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index 318175f..969ef4a 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -162,6 +162,11 @@ source "kernel/Kconfig.freezer"
>>>  
>>>  menu "Platform selection"
>>>  
>>> +config ARCH_BCM_IPROC
>>> +	bool "Broadcom iProc SoC Family"
>>> +	help
>>> +	  This enables support for Broadcom iProc based SoCs
>>> +
>>
>> Is this working correctly if we have ARCH_BCM_IPROC under ARM and ARM64?
>> They are guarding the same SoC line, which now uses ARM64 CPUS.
>>
> 
> Yes, since the "ARCH=" parameter from the compiler helps to route it to
> the right directory, arch/arm or arch/arm64, and you cannot compile both
> in a single image. Same case for other SoCs, e.g., tegra (ARCH_TEGRA),
> exynos (ARCH_EXYNOS), and etc.
> 
> The benefit of sharing the same arch flag is that the device driver that
> exists in iProc family of SoCs (both arm32 and arm64) can be guarded or
> enabled properly.

Yes, I like that as well, better maintain a single symbol across two
architectures than multiple across multiple architectures.
-- 
Florian

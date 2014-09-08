From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 08 Sep 2014 14:43:10 +0200
Subject: [PATCH 1/2] ARM: exynos_defconfig: Enable Control Groups support
In-Reply-To: <53FE02E6.3030302@suse.de>
References: <1409137341-20516-1-git-send-email-javier.martinez@collabora.co.uk>
 <53FE02E6.3030302@suse.de>
Message-ID: <540DA45E.1040702@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andreas,

On 08/27/2014 06:10 PM, Andreas F?rber wrote:
> Am 27.08.2014 13:02, schrieb Javier Martinez Canillas:
>> systemd needs control groups support to be enabled in the
>> kernel so let's enable it by default since is quite likely
>> that a user-space with systemd will be used.
>> 
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> ---
>>  arch/arm/configs/exynos_defconfig | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
>> index 676c744..590abde 100644
>> --- a/arch/arm/configs/exynos_defconfig
>> +++ b/arch/arm/configs/exynos_defconfig
>> @@ -1,6 +1,7 @@
>>  CONFIG_SYSVIPC=y
>>  CONFIG_NO_HZ=y
>>  CONFIG_HIGH_RES_TIMERS=y
>> +CONFIG_CGROUPS=y
>>  CONFIG_BLK_DEV_INITRD=y
>>  CONFIG_KALLSYMS_ALL=y
>>  CONFIG_MODULES=y
> 
> CONFIG_FHANDLE=y is also needed for systemd to get a serial console.
> multi_v7 has that already.
> 

That's a requirement for systemd >= 209 AFAIK. I've systemd 208 on my debian
jessie and it works without it.

I agree that it should be included but I think it can be in a follow-up patch.

> Regards,
> Andreas
> 

Best regards,
Javier

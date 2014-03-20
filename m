From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 20 Mar 2014 01:09:31 +0100
Subject: [PATCH] ARM: mvebu: Enable NEON support in defconfig
In-Reply-To: <87a9cln48a.fsf@natisbad.org>
References: <1395268736-13338-1-git-send-email-gregory.clement@free-electrons.com>
 <87a9cln48a.fsf@natisbad.org>
Message-ID: <532A31BB.1090408@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

On 20/03/2014 00:44, Arnaud Ebalard wrote:
> Hi Gregory,
> 
> Gregory CLEMENT <gregory.clement@free-electrons.com> writes:
> 
>> CONFIG_NEON is no more turning on unconditionally when Armada 375 or
>> Armada 38x are selected. However we still want it selected for the
>> reference configuration.
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>  arch/arm/configs/mvebu_v7_defconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
>> index 62b6a37626c5..36797dbfa610 100644
>> --- a/arch/arm/configs/mvebu_v7_defconfig
>> +++ b/arch/arm/configs/mvebu_v7_defconfig
>> @@ -26,6 +26,7 @@ CONFIG_ZBOOT_ROM_BSS=0x0
>>  CONFIG_ARM_APPENDED_DTB=y
>>  CONFIG_ARM_ATAG_DTB_COMPAT=y
>>  CONFIG_VFP=y
>> +CONFIG_NEON=y
>>  CONFIG_NET=y
>>  CONFIG_INET=y
>>  CONFIG_BT=y
> 
> Will the lack of support by the hardware be detected automatically
> (Armada 370 does not have neon support for instance)? Or does the

yes the lack of support by the hardware should be detected automatically,
whereas if CONFIG_NEON is not selected NEON will never be used even if
the hardware is present.

Gregory

> logic relies on the fact that CONFIG_KERNEL_MODE_NEON is disabled?
> 
> Cheers,
> 
> a+
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

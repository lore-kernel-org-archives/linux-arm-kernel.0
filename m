From: rjui@broadcom.com (Ray Jui)
Date: Fri, 24 Jul 2015 08:42:47 -0700
Subject: [PATCH v4 3/4] arm64: Add Broadcom iProc family support
In-Reply-To: <20150724085103.GA30410@arm.com>
References: <1437528583-855-1-git-send-email-rjui@broadcom.com>
 <1437528583-855-4-git-send-email-rjui@broadcom.com>
 <20150724085103.GA30410@arm.com>
Message-ID: <55B25CF7.4070403@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 7/24/2015 1:51 AM, Will Deacon wrote:
> (adding Olof)
> 
> On Wed, Jul 22, 2015 at 02:29:42AM +0100, Ray Jui wrote:
>> This patch adds support to Broadcom's iProc family of arm64 based SoCs
>> in the arm64 Kconfig and defconfig files
>>
>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>> ---
>>  arch/arm64/Kconfig           |    5 +++++
>>  arch/arm64/configs/defconfig |    2 ++
>>  2 files changed, 7 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 318175f..969ef4a 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -162,6 +162,11 @@ source "kernel/Kconfig.freezer"
>>  
>>  menu "Platform selection"
>>  
>> +config ARCH_BCM_IPROC
>> +	bool "Broadcom iProc SoC Family"
>> +	help
>> +	  This enables support for Broadcom iProc based SoCs
>> +
> 
> The arm-soc guys have a patch moving the platform-related config options
> out into Kconfig.platforms, so I think you need to co-ordinate with them.
> 

Thanks for letting me know. I see that those patches are already merged
into for-next under arm-soc. I guess I should generate a new patch
series based on for-next and move this config option to Kconfig.platform?

Olof, any comment?

>>  config ARCH_EXYNOS
>>  	bool
>>  	help
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index 4e17e7e..c83d51f 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -31,6 +31,7 @@ CONFIG_MODULES=y
>>  CONFIG_MODULE_UNLOAD=y
>>  # CONFIG_BLK_DEV_BSG is not set
>>  # CONFIG_IOSCHED_DEADLINE is not set
>> +CONFIG_ARCH_BCM_IPROC=y
>>  CONFIG_ARCH_EXYNOS7=y
>>  CONFIG_ARCH_FSL_LS2085A=y
>>  CONFIG_ARCH_HISI=y
>> @@ -102,6 +103,7 @@ CONFIG_SERIO_AMBAKMI=y
>>  CONFIG_LEGACY_PTY_COUNT=16
>>  CONFIG_SERIAL_8250=y
>>  CONFIG_SERIAL_8250_CONSOLE=y
>> +CONFIG_SERIAL_8250_DW=y
>>  CONFIG_SERIAL_8250_MT6577=y
>>  CONFIG_SERIAL_AMBA_PL011=y
>>  CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
> 
> I'm fine with this.
> 
> Will
> 

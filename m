From: cov@codeaurora.org (Christopher Covington)
Date: Mon, 12 Aug 2013 11:21:29 -0400
Subject: [PATCH 1/2] power: Add APM X-Gene system reboot driver
In-Reply-To: <20130809212849.GD12638@lizard.sbx05730.santaca.wayport.net>
References: <1372797539-13111-1-git-send-email-lho@apm.com>
 <1372797539-13111-2-git-send-email-lho@apm.com>
 <20130809212849.GD12638@lizard.sbx05730.santaca.wayport.net>
Message-ID: <5208FD79.4070307@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/2013 05:28 PM, Anton Vorontsov wrote:
> On Tue, Jul 02, 2013 at 02:38:58PM -0600, Loc Ho wrote:
>> power: Add APM X-Gene SoC system reboot driver. This driver handles only
>> system reboot. System shutdown is board specific and can be handled by board
>> driver or GPIO based shutdown driver.
>>
>> Signed-off-by: Loc Ho <lho@apm.com>
>> Signed-off-by: Feng Kan <fkan@apm.com>
>> Signed-off-by: Kumar Sankaran <ksankaran@apm.com>
>> ---
> 
> The patch looks great, thanks for it! Just a few minor issues I noticed...
> 
>>  drivers/power/reset/Kconfig        |    7 +++
>>  drivers/power/reset/Makefile       |    1 +
>>  drivers/power/reset/xgene-reboot.c |  101 ++++++++++++++++++++++++++++++++++++
>>  3 files changed, 109 insertions(+), 0 deletions(-)
>>  create mode 100755 drivers/power/reset/xgene-reboot.c
>>
>> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
>> index 349e9ae..c41a7de 100644
>> --- a/drivers/power/reset/Kconfig
>> +++ b/drivers/power/reset/Kconfig
>> @@ -37,3 +37,10 @@ config POWER_RESET_VEXPRESS
>>  	help
>>  	  Power off and reset support for the ARM Ltd. Versatile
>>  	  Express boards.
>> +
>> +config POWER_RESET_XGENE
>> +        bool
>> +	default y if ARM64
> 
> This is not good. You don't want to select the driver for all ARM64
> builds. I changed it to 'depends on' and made the driver optionally
> selectable.

I thought the desired default was to have a single arm64 kernel binary that
could run on all platforms.

> 
>> +        depends on POWER_RESET	
>> +        help
>> +          Reboot support for the APM SoC X-Gene Eval boards.

[...]

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.

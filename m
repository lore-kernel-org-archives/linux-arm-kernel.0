From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 16 Jan 2017 11:35:02 +0530
Subject: [PATCH 36/37] ARM: DRA7: clockdomain: Change the CLKTRCTRL of
 CM_PCIE_CLKSTCTRL to SW_WKUP
In-Reply-To: <20170113171537.GZ2630@atomide.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-37-git-send-email-kishon@ti.com>
 <20170113171537.GZ2630@atomide.com>
Message-ID: <587C628E.7070804@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Friday 13 January 2017 10:45 PM, Tony Lindgren wrote:
> * Kishon Vijay Abraham I <kishon@ti.com> [170112 02:35]:
>> The PCIe programming sequence in TRM suggests CLKSTCTRL of PCIe should
>> be set to SW_WKUP. There are no issues when CLKSTCTRL is set to HW_AUTO
>> in RC mode. However in EP mode, the host system is not able to access the
>> MEMSPACE and setting the CLKSTCTRL to SW_WKUP fixes it.
> 
> I guess ideally in the long run we would set this dynamically based on
> the selected mode, right?

The programming sequence mentioned in the TRM w.r.t clock programming is same
for both host mode or device mode. Though we never faced any issues in host
mode when HW_AUTO is set, it's better to follow TRM recommended settings IMHO.

Thanks
Kishon

> 
> Regards,
> 
> Tony
> 
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  arch/arm/mach-omap2/clockdomains7xx_data.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-omap2/clockdomains7xx_data.c b/arch/arm/mach-omap2/clockdomains7xx_data.c
>> index 6c67965..67ebff8 100644
>> --- a/arch/arm/mach-omap2/clockdomains7xx_data.c
>> +++ b/arch/arm/mach-omap2/clockdomains7xx_data.c
>> @@ -524,7 +524,7 @@
>>  	.dep_bit	  = DRA7XX_PCIE_STATDEP_SHIFT,
>>  	.wkdep_srcs	  = pcie_wkup_sleep_deps,
>>  	.sleepdep_srcs	  = pcie_wkup_sleep_deps,
>> -	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
>> +	.flags		  = CLKDM_CAN_SWSUP,
>>  };
>>  
>>  static struct clockdomain atl_7xx_clkdm = {
>> -- 
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

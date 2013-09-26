From: cjb@laptop.org (Chris Ball)
Date: Wed, 25 Sep 2013 21:50:07 -0400
Subject: [PATCH 1/3] arm: socfpga: Set the SDMMC clock phase in system
 manager
In-Reply-To: <20130914110031.GB15077@amd.pavel.ucw.cz> (Pavel Machek's message
 of "Sat, 14 Sep 2013 13:00:31 +0200")
References: <1378740833-4883-1-git-send-email-dinguyen@altera.com>
 <1378740833-4883-2-git-send-email-dinguyen@altera.com>
 <20130914110031.GB15077@amd.pavel.ucw.cz>
Message-ID: <8761to4ai8.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dinh,

On Sat, Sep 14 2013, Pavel Machek wrote:
>> From: Dinh Nguyen <dinguyen@altera.com>
>> 
>> Add functionality in the System Manager to set the SDR settings for the
>> SD/MMC IP.
>> 
>> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
>> Cc: Pavel Machek <pavel@denx.de>
>
>> +void socfpga_sysmgr_set_dwmmc_drvsel_smpsel(void)
>> +{
>> +	struct device_node *np;
>> +	u32 timing[2];
>> +	u32 hs_timing;
>> +
>> +	np = of_find_compatible_node(NULL, NULL, "altr,socfpga-dw-mshc");
>> +	of_property_read_u32_array(np, "samsung,dw-mshc-sdr-timing", timing, 2);
>> +	hs_timing = SYSMGR_SDMMC_CTRL_SET(timing[0], timing[1]);
>> +	writel(hs_timing, sys_manager_base_addr + SYSMGR_SDMMCGRP_CTRL_OFFSET);
>> +}
>> +EXPORT_SYMBOL(socfpga_sysmgr_set_dwmmc_drvsel_smpsel);
>
> To get the abstraction right, would it make sense to have timing
> parameters as arguments to socfpga_sysmgr_set_dwmmc_drvsel_smpsel(),
> so that sysmgr code is not walking MMC's device tree directly?

I think this review comment from Pavel is still open, please reply.
Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>

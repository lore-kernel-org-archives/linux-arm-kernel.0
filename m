From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 11 Jan 2018 17:03:53 -0800
Subject: [PATCH] soc: brcmstb: Only register SoC device on STB platforms
In-Reply-To: <20180112010130.3tz7hnmzs74trwhw@localhost>
References: <20180109145409.11612-1-thierry.reding@gmail.com>
 <20180112010130.3tz7hnmzs74trwhw@localhost>
Message-ID: <16b38f56-8431-71d3-2fc6-ea102bd803e1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2018 05:01 PM, Olof Johansson wrote:
> On Tue, Jan 09, 2018 at 03:54:09PM +0100, Thierry Reding wrote:
>> From: Thierry Reding <treding@nvidia.com>
>>
>> After moving the SoC device initialization to an early initcall in
>> commit f780429adfbc ("soc: brcmstb: biuctrl: Move to early_initcall"),
>> the Broadcom STB SoC device is registered on all platforms if support
>> for the device is enabled in the kernel configuration.
>>
>> This causes an additional SoC device to appear on platforms that already
>> register a native one. In case of Tegra the STB SoC device is registered
>> as soc0 (with totally meaningless content in the sysfs attributes) and
>> causes various scripts and programs to fail because they don't know how
>> to parse that data.
>>
>> To fix this, duplicate the check from brcmstb_soc_device_early_init()
>> that already prevents the code from doing anything nonsensical on non-
>> STB platforms.
>>
>> Fixes: f780429adfbc ("soc: brcmstb: biuctrl: Move to early_initcall")
>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>> ---
> 
> 
> Thanks, applied.

Thanks for picking that up, I was just going to submit it.
-- 
Florian

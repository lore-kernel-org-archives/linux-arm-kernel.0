From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 09 Mar 2012 09:42:32 -0700
Subject: [PATCH 09/11] ARM: tegra: Rewrite PCIe support as a driver
In-Reply-To: <20120309063739.GC25208@avionic-0098.mockup.avionic-design.de>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
 <1331218291-16119-10-git-send-email-thierry.reding@avionic-design.de>
 <4F5911E0.6060802@wwwdotorg.org>
 <20120309063739.GC25208@avionic-0098.mockup.avionic-design.de>
Message-ID: <4F5A32F8.80001@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2012 11:37 PM, Thierry Reding wrote:
> * Stephen Warren wrote:
>> On 03/08/2012 07:51 AM, Thierry Reding wrote:
>>> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
...
>>> diff --git a/arch/arm/mach-tegra/board.h b/arch/arm/mach-tegra/board.h
>>
>>> +#define TEGRA_PCIE_MAX_PORTS 2
>>> +
>>> +struct tegra_pcie_pdata {
>>> +	int (*init)(struct platform_device *pdev);
>>> +	int (*exit)(struct platform_device *pdev);
>>> +	bool enable_ports[TEGRA_PCIE_MAX_PORTS];
>>> +};
>>
>> That's a somewhat odd place to put the header; a dedicated
>> mach-tegra/include/mach/tegra_pcie_pdata.h or
>> include/linux/platform_data/tegra_pcie.h might make more sense.
> 
> mach-tegra/include/mach/pcie.h perhaps? That would be less redundant.

New files in that directory should have tegra in the name somewhere, so
that when multi-SoC kernels are built, and multiple mach-*/include/mach
directories are in the include path (or files get moved from those paths
into a single common place), you know which include file you're getting.

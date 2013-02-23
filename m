From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 22 Feb 2013 21:31:17 -0700
Subject: [PATCH 1/4] ARM: tegra: pmc: convert PMC driver to support DT only
In-Reply-To: <1361585022.1804.11.camel@jlo-ubuntu-64.nvidia.com>
References: <1361515491-16199-1-git-send-email-josephl@nvidia.com>
 <1361515491-16199-2-git-send-email-josephl@nvidia.com>
 <20130222130516.GW23234@tbergstrom-lnx.Nvidia.com>
 <1361585022.1804.11.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <51284615.6080808@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/22/2013 07:03 PM, Joseph Lo wrote:
> On Fri, 2013-02-22 at 21:05 +0800, Peter De Schrijver wrote:
>> On Fri, Feb 22, 2013 at 07:44:48AM +0100, Joseph Lo wrote:
>>> The Tegra kernel only support boot from DT now. Clean up the PMC driver
>>> to support DT only, that includes:
>>>
>>> * remove the ifdef of CONFIG_OF
>>> * replace the static mapping of PMC addr to map from DT
>>>
>>> -#ifdef CONFIG_OF
>>>  static const struct of_device_id matches[] __initconst = {
>>>  	{ .compatible = "nvidia,tegra20-pmc" },
>>>  	{ }
>>
>> At least an extra entry for tegra114-pmc is necessary here. tegra114.dtsi only
>> has:
>>
>> pmc {
>> 	compatible = "nvidia,tegra114-pmc", "nvidia,tegra30-pmc";
>> 	reg = <0x7000e400 0x400>;
>> };
>>
> I think it should be something like below, isn't it?
> 
> compatible = "nvidia,tegra114-pmc", "nvidia,tegra30-pmc",
> 		"nvidia,tegra20-pmc";
> 
> or should we add tegra114 and tegra30 in the DT match table?

The Tegra114 PMC HW is probably not 100% backwards-compatible with
previous SoCs' PMC, so the DT file should probably only list the
specific SoC, and the driver should probably include all the compatible
values it supports.

Peter, can you confirm exactly which HW versions, if any, are 100%
backwards-compatible?

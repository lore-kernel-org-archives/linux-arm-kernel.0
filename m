From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 15 Feb 2013 09:45:45 -0700
Subject: [v2 1/4] ARM: tegra20: create a DT header defining CLK IDs
In-Reply-To: <20130215092407.GO3073@tbergstrom-lnx.Nvidia.com>
References: <1360868369-20093-1-git-send-email-hdoyu@nvidia.com>
 <1360868369-20093-2-git-send-email-hdoyu@nvidia.com>
 <511D45E0.1080105@wwwdotorg.org>
 <20130215092407.GO3073@tbergstrom-lnx.Nvidia.com>
Message-ID: <511E6639.1090909@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/15/2013 02:24 AM, Peter De Schrijver wrote:
> On Thu, Feb 14, 2013 at 09:15:28PM +0100, Stephen Warren wrote:
>> On 02/14/2013 11:59 AM, Hiroshi Doyu wrote:
>>> To replace magic number in tegra_car:
>>>
>>> -               clocks = <&tegra_car 28>;
>>> +               clocks = <&tegra_car CLK_HOST1X>;
>>
>>> diff --git a/arch/arm/boot/dts/tegra20-car.h b/arch/arm/boot/dts/tegra20-car.h
>>
>> Sorry, forgot a couple small comments the last time around.
>>
>> This file should probably have some header indicating which binding it
>> describes, rather like the GPIO header in my patch series.
>>
>>> +#define CLK_CPU 0
>>
>> I'd suggest naming that TEGRA20_CLK_CPU, so that the various different
>> clock headers don't conflict. It's not too likely that more than one of
>> the /Tegra/ clock headers will be included at once, but it doesn't seem
>> that unlikely that a board file could end up having a Tegra clock header
>> included plus various other clock headers for some other chip that has
>> some clock outputs.
>>
> 
> I would suggest removing this clock. It's not actually implemented in the CCF
> and rather useless. If you would gate the CPU clock from the CPU by writing to
> this register, how would you ungate it? :) Note that this would gate the clock
> to all CPUs.

(Note that my comment was re: all clocks, not just that one clock)

Can't the PMC or flow-controller ungate the clock based on some event?
Either way, that clock definition exists in HW, right? So I don't think
there's actually any harm in including the definition in the binding
even if we never implement/use it.

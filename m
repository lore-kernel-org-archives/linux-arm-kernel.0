From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 22 Feb 2013 21:32:32 -0700
Subject: [PATCH 2/4] ARM: tegra: pmc: add power on function for secondary
 CPUs
In-Reply-To: <1361587135.1804.16.camel@jlo-ubuntu-64.nvidia.com>
References: <1361515491-16199-1-git-send-email-josephl@nvidia.com>
 <1361515491-16199-3-git-send-email-josephl@nvidia.com>
 <20130222130051.GV23234@tbergstrom-lnx.Nvidia.com>
 <1361587135.1804.16.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <51284660.8060002@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/22/2013 07:38 PM, Joseph Lo wrote:
> On Fri, 2013-02-22 at 21:00 +0800, Peter De Schrijver wrote:
>> On Fri, Feb 22, 2013 at 07:44:49AM +0100, Joseph Lo wrote:
>>> Adding the power on function for secondary CPUs in PMC driver, this can
>>> help us to remove legacy powergate driver and add generic power domain
>>> support later.

>>> diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c

>>> +static u8 tegra_cpu_domains[] = {
>>> +	0xFF,			/* not available for CPU0 */
>>
>> On Tegra114 we can also powergate CPU0, so this needs to be defined then.
>>
> No, DON'T DO THAT!!
> We don't allow any code to power gate CPU0 manually here or elsewhere.
> 
> The function here only for SMP and hotplug bring up for secondary CPU.

Doesn't Tegra114 have improved HW that does actually allow
power-gating/hot-unplugging/... CPU 0, even though older HW didn't?

From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 6 Apr 2017 23:15:00 +0200
Subject: [PATCH v3 00/18] clocksource/arch_timer: Errata workaround
 infrastructure rework
In-Reply-To: <20170406162714.GC7705@e104818-lin.cambridge.arm.com>
References: <20170404171826.25030-1-marc.zyngier@arm.com>
 <20170406162714.GC7705@e104818-lin.cambridge.arm.com>
Message-ID: <e89c2826-85e1-74f4-de73-e4c18b2e7ec9@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/2017 18:27, Catalin Marinas wrote:
> Hi Daniel,
> 
> On Tue, Apr 04, 2017 at 06:18:08PM +0100, Marc Zyngier wrote:
>> Marc Zyngier (18):
>>   arm64: Allow checking of a CPU-local erratum
>>   arm64: Add CNTVCT_EL0 trap handler
>>   arm64: Define Cortex-A73 MIDR
>>   arm64: cpu_errata: Allow an erratum to be match for all revisions of a
>>     core
>>   arm64: cpu_errata: Add capability to advertise Cortex-A73 erratum
>>     858921
>>   arm64: arch_timer: Add infrastructure for multiple erratum detection
>>     methods
>>   arm64: arch_timer: Add erratum handler for CPU-specific capability
>>   arm64: arch_timer: Move arch_timer_reg_read/write around
>>   arm64: arch_timer: Get rid of erratum_workaround_set_sne
>>   arm64: arch_timer: Rework the set_next_event workarounds
>>   arm64: arch_timer: Make workaround methods optional
>>   arm64: arch_timer: Allows a CPU-specific erratum to only affect a
>>     subset of CPUs
>>   arm64: arch_timer: Move clocksource_counter and co around
>>   arm64: arch_timer: Save cntkctl_el1 as a per-cpu variable
>>   arm64: arch_timer: Enable CNTVCT_EL0 trap if workaround is enabled
>>   arm64: arch_timer: Workaround for Cortex-A73 erratum 858921
>>   arm64: arch_timer: Allow erratum matching with ACPI OEM information
>>   arm64: arch_timer: Add HISILICON_ERRATUM_161010101 ACPI matching data
> 
> Are you happy to take the arch_timer patches above? If yes, Marc can
> create a common branch with the first 5 patches which I will merge in
> the arm64 tree. You can then pull the whole series into your tree.

Hi Catalin,

I'm fine with the merge process you are proposing. But before going
forward, I would like to wait a bit in order to give the opportunity to
Thomas to review the patchset.

Thanks.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

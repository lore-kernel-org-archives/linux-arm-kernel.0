From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Thu, 05 Jun 2014 09:59:21 +0100
Subject: [PATCH v2 04/11] sched: Allow all archs to set the power_orig
In-Reply-To: <CAKfTPtB9bh1_ZeQSFsC2eoBaytDBNcmn8ZZpY7Weqxui75Z2kA@mail.gmail.com>
References: <1400860385-14555-1-git-send-email-vincent.guittot@linaro.org>
 <1400860385-14555-5-git-send-email-vincent.guittot@linaro.org>
 <53888FF0.4020403@arm.com>
 <CAKfTPtB+2dsHjZw=KkYgbP4EnPebLjfdNeVDAStXFJ2h8wbm+g@mail.gmail.com>
 <538EE9E9.7090605@arm.com>
 <CAKfTPtB9bh1_ZeQSFsC2eoBaytDBNcmn8ZZpY7Weqxui75Z2kA@mail.gmail.com>
Message-ID: <53903169.3030404@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]
>> Firstly, we need to scale cpu power in update_cpu_power() regarding
>> uArch, frequency and rt/irq pressure.
>> Here the freq related value we get back from arch_scale_freq_power(...,
>> cpu) could be an instantaneous value (curr_freq(cpu)/max_freq(cpu)).
>>
>> Secondly, to be able to scale the runnable avg sum of a sched entity
>> (se->avg->runnable_avg_sum), we preferable have a coefficient
>> representing uArch diffs (cpu_power_orig(cpu)/cpu_power_orig(most
>> powerful cpu in the system) and another coefficient (avg freq over 'now
> 
> AFAICT, the coefficient representing uArch diffs is already taken into
> account into power_freq thanks to scale_cpu, isn't it ?

True, but I can't see how the current signature of
arch_scale_cpu_power() and arch_scale_freq_power() fit into this uArch
and freq invariant updating of se->avg->runnable_avg_sum business.

>> - sa->last_runnable_update'(cpu)/max_freq(cpu). This value would have to
>> be retrieved from the arch in __update_entity_runnable_avg().
>>
[...]

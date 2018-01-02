From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 2 Jan 2018 11:42:39 +0000
Subject: [PATCH v3 2/2] ARM64 / cpuidle: Use new cpuidle macro for
 entering retention state
In-Reply-To: <1510765910-23739-3-git-send-email-pprakash@codeaurora.org>
References: <1510765910-23739-1-git-send-email-pprakash@codeaurora.org>
 <1510765910-23739-3-git-send-email-pprakash@codeaurora.org>
Message-ID: <e1e34569-538d-75f2-34fb-2feb75692ea7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 15/11/17 17:11, Prashanth Prakash wrote:
> CPU_PM_CPU_IDLE_ENTER_RETENTION skips calling cpu_pm_enter() and
> cpu_pm_exit(). By not calling cpu_pm functions in idle entry/exit
> paths we can reduce the latency involved in entering and exiting
> the low power idle state.
> 
> On ARM64 based Qualcomm server platform we measured below overhead
> for calling cpu_pm_enter and cpu_pm_exit for retention states.
> 
> workload: stress --hdd #CPUs --hdd-bytes 32M  -t 30
> 	Average overhead of cpu_pm_enter - 1.2us
> 	Average overhead of cpu_pm_exit  - 3.1us
> 
> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 22 Jan 2015 12:08:50 +0000
Subject: [PATCH RFC 2/2] ARM64: psci: implement system suspend using PSCI
 v0.2 CPU SUSPEND
In-Reply-To: <20150122061812.GB9244@leoy-linaro>
References: <1421840155-18990-1-git-send-email-sudeep.holla@arm.com>
 <1421840155-18990-3-git-send-email-sudeep.holla@arm.com>
 <20150122061812.GB9244@leoy-linaro>
Message-ID: <20150122120850.GC1218@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 22, 2015 at 06:18:12AM +0000, Leo Yan wrote:

[...]

> How about unify the power states passing for cpu idle and suspend?
> 
> below is a example for dts which place all power state into psci
> entry, so that idle-states and system suspend both can reference
> the power state.
> 
> psci {
> 	compatible = "arm,psci-0.2";
> 	method = "smc";
> 
>         power_state {
>                 CPU_POWER_OFF: cpu_power_off {
>                         state = <0x00010000>;
>                 };
> 
>                 CLUSTER_POWER_OFF: cluster_power_off {
>                         state = <0x01010000>;
>                 };
> 
>                 SOC_SUSPEND: soc_suspend {
>                         state = <0x01010001>;
>                 };
>         };
> };

I do not see why this would help. We would end up with phandles to
the nodes above to get the parameter from idle-states, to me it
looks like churn honestly, I do not see where the improvement is.

Lorenzo

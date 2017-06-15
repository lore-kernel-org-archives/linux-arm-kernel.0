From: leo.yan@linaro.org (Leo Yan)
Date: Thu, 15 Jun 2017 08:23:58 +0800
Subject: [PATCH v3 14/21] arm64: dts: hi3660: enable idle states
In-Reply-To: <20170614082338.15673-15-guodong.xu@linaro.org>
References: <20170614082338.15673-1-guodong.xu@linaro.org>
 <20170614082338.15673-15-guodong.xu@linaro.org>
Message-ID: <20170615002358.GD28496@leoy-ThinkPad-T440>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 14, 2017 at 04:23:31PM +0800, Guodong Xu wrote:
> From: Leo Yan <leo.yan@linaro.org>
> 
> On Hi3660 there have two clusters, one is CA53 cluster and another is
> CA73 cluster. This two clusters have different idle states separately.
> With Daniel Lezcano's patch (ARM: cpuidle: Support asymmetric idle
> definition), now ARM idle driver can support different clusters with
> different idle states.
> 
> Base on this, this patch is to bind two clusters idle states on Hi3660.
> Except the "WFI" states are enabled by default for all CPUs, this patch
> also binds below extra idle states:
> 
> - CA53 CPUs have two more states:
>   CPU_SLEEP:       CPU power off state
>   CLUSTER_SLEEP_0: Cluster power off state
> 
> - CA73 CPUs have three more states:
>   CPU_NAP:         CPU retention state
>   CPU_SLEEP:       CPU power off state
>   CLUSTER_SLEEP_1: Cluster power off state

Hi Guodong, Wei and all,

As Daniel reminded, this patch is dependent on patch (ARM: cpuidle:
Support asymmetric idle definition) [1] but his patch has not been
finally merged yet. So let us hold on this patch for Daniel's patch
is picked up firstly.

At the meantime welcome the review and comment for this patch ahead.

[1] https://patchwork.kernel.org/patch/9781869/

[...]

Thanks,
Leo Yan

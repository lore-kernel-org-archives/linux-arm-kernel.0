From: leo.yan@linaro.org (Leo Yan)
Date: Fri, 11 Aug 2017 09:50:21 +0800
Subject: [PATCH v2 1/9] arm64: dts: hi3660: enable idle states
In-Reply-To: <b3d8f55b-3d70-9b3a-a4c6-474a933a13a9@linaro.org>
References: <20170810022615.19204-1-guodong.xu@linaro.org>
 <20170810022615.19204-2-guodong.xu@linaro.org>
 <b3d8f55b-3d70-9b3a-a4c6-474a933a13a9@linaro.org>
Message-ID: <20170811015020.GF3819@leoy-ThinkPad-T440>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Thu, Aug 10, 2017 at 12:07:07PM +0200, Daniel Lezcano wrote:
> 
> Hi Guodong, Leo,
> 
> there are several typos in the patch description. I *humbly* propose an
> alternate description to make it a bit more English friendly.
> 
> """
> 
> There are two clusters on the Hi3660, the first one is Cortex-A53 based
> and the other one is Cortex-A73 based. These two clusters have different
> idle states.
> 
> Thanks to Daniel Lezcano's recent changes, the generic ARM cpuidle
> driver can now support several clusters with different idle states, thus
> supporting the big.Little architecture.
> 
> In addition to the WFI idle state which is the default shallowest state
> for all ARM cpus, the Hi3660 supports the following states:
> 
>  - CA53 CPUs:
> 	- CPU_SLEEP:       CPU power off state
> 	- CLUSTER_SLEEP_0: Cluster power off state
> 
>  - CA73 CPUs:
> 	- CPU_NAP:         CPU retention state
> 	- CPU_SLEEP:       CPU power off state
> 	- CLUSTER_SLEEP_1: Cluster power off state
> 
> This patch adds the idle states description for the Hi3660 to the device
> tree.
> 
> """
> 
> 
> Other than that.
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks a lot for proposing commit log, it's much better :)

Thanks,
Leo Yan

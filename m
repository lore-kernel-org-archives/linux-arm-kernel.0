From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 2 Oct 2017 14:56:21 -0700
Subject: [PATCH v2 5/6] arm64: Fixup users of topology_physical_package_id
In-Reply-To: <20170919184751.25110-6-jeremy.linton@arm.com>
References: <20170919184751.25110-1-jeremy.linton@arm.com>
 <20170919184751.25110-6-jeremy.linton@arm.com>
Message-ID: <20171002215621.GS457@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/19, Jeremy Linton wrote:
> There are a few arm64 specific users (cpufreq, psci, etc) which really
> want the cluster rather than the topology_physical_package_id(). Lets
> convert those users to topology_cod_id(). That way when we start
> differentiating the socket/cluster they will continue to behave correctly.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---

For:

>  drivers/clk/clk-mb86s7x.c        | 2 +-

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

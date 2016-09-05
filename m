From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 06 Sep 2016 00:27:09 +0200
Subject: [PATCH v3 2/2] arm64: dts: rockchip: support the pmu node for
 rk3399
In-Reply-To: <1473099435-28198-3-git-send-email-wxt@rock-chips.com>
References: <1473099435-28198-1-git-send-email-wxt@rock-chips.com>
 <1473099435-28198-3-git-send-email-wxt@rock-chips.com>
Message-ID: <1666797.JgSRLN1JIq@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 6. September 2016, 02:17:15 CEST schrieb Caesar Wang:
> This patch adds to enable the ARM Performance Monitor Units for rk3399.
> ARM cores often have a PMU for counting cpu and cache events like cache
> misses and hits.
> 
> Also, as the Marc posted the patches [0] to support Partitioning per-cpu
> interrupts. Let's add this patch to match it on rk3399 SoCs.
> 
> [0]:
> https://lkml.org/lkml/2016/4/11/182
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> CC: linux-arm-kernel at lists.infradead.org

I've applied this one but did some corrections [0]:

- ppi-partitions is supposed to be a subnode of the gic, that is why the code
also start search for it starting from the gic node - I've moved it
- I've renamed the phandles taking part0/part1 from the example feels a bit to
generic, so it's now ppi_cluster0 and ppi_cluster1 matching the cpu-clusters

I've gave this a spin on my rk3399evb and the ppi-partitions got recognized
as well as the pmu instances got created, but please also double check again.


Thanks
Heiko


[0] https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git/
commit/?id=48120b1af6f072bfd6b075bf9be560ad6fda2faa

From: guohanjun@huawei.com (Hanjun Guo)
Date: Thu, 7 Jun 2018 20:25:26 +0800
Subject: [PATCH v2] irqchip/gic-v3-its: fix ITS queue timeout
In-Reply-To: <86a7s89t13.wl-marc.zyngier@arm.com>
References: <1528252824-15144-1-git-send-email-yangyingliang@huawei.com>
 <86a7s89t13.wl-marc.zyngier@arm.com>
Message-ID: <fc0393df-22d4-0334-91ce-8ddcdbf5ec21@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 2018/6/6 17:13, Marc Zyngier wrote:
[...]
> 
> Wouldn't it be better to just return that the affinity setting request
> is impossible to satisfy? And more to the point, how comes we end-up
> in such a case?

The system is booted with a NUMA node has no memory attaching to it
(memory-less NUMA node), also with NR_CPUS less than CPUs presented
in MADT, so CPUs on this memory-less node are not brought up, and
this NUMA node will not be online too. But the ITS attaching to this NUMA
domain is still valid and represented via SRAT to ITS driver.

This is really the corner case which is triggered by the boot testing
when enabling our D06 boards, but it's a bug :)

Thanks
Hanjun

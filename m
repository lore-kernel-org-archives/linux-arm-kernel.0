From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Tue, 30 Oct 2018 10:15:04 -0700
Subject: [PATCH] soc: ti: QMSS: Fix usage of irq_set_affinity_hint
In-Reply-To: <20181030111103.12110-1-marc.zyngier@arm.com>
References: <20181030111103.12110-1-marc.zyngier@arm.com>
Message-ID: <0a20aaf3-65ce-a7ae-8a0e-877313483969@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

On 10/30/2018 4:11 AM, Marc Zyngier wrote:
> The Keystone QMSS driver is pretty damaged, in the sense that it
> does things like this:
> 
> 	irq_set_affinity_hint(irq, to_cpumask(&cpu_map));
> 
> where cpu_map is a local variable. As we leave the function, this
> will point to nowhere-land, and things will end-up badly.
> 
> Instead, let's use a proper cpumask that gets allocated, giving
> the driver a chance to actually work with things like irqbalance
> as well as have a hypothetical 64bit future.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
Could you please add this patch to your fixes branch ?

FWIW,
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>

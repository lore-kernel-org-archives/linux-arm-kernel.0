From: will.deacon@arm.com (Will Deacon)
Date: Wed, 6 Jul 2016 17:05:25 +0100
Subject: [PATCH v2] drivers/perf: arm-pmu: Handle per-interrupt affinity
 mask
In-Reply-To: <1467815627-4061-1-git-send-email-marc.zyngier@arm.com>
References: <1467815627-4061-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160706160525.GA31910@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2016 at 03:33:47PM +0100, Marc Zyngier wrote:
> On a big-little system, PMUs can be wired to CPUs using per CPU
> interrups (PPI). In this case, it is important to make sure that
> the enable/disable do happen on the right set of CPUs.
> 
> So instead of relying on the interrupt-affinity property, we can
> use the actual percpu affinity that DT exposes as part of the
> interrupt specifier. The DT binding is also updated to reflect
> the fact that the interrupt-affinity property shouldn't be used
> in that case.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> * From v1:
>   - propagate the error if irq_get_percpu_devid_partition fails

Thanks, I'll queue this.

Will

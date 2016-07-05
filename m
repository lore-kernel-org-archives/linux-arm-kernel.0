From: robh@kernel.org (Rob Herring)
Date: Tue, 5 Jul 2016 09:23:50 -0500
Subject: [PATCH] drivers/perf: arm-pmu: Handle per-interrupt affinity mask
In-Reply-To: <1467379291-18413-1-git-send-email-marc.zyngier@arm.com>
References: <1467379291-18413-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160705142350.GA24441@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 01, 2016 at 02:21:31PM +0100, Marc Zyngier wrote:
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
>  Documentation/devicetree/bindings/arm/pmu.txt |  4 +++-

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/perf/arm_pmu.c                        | 22 +++++++++++++++++-----
>  2 files changed, 20 insertions(+), 6 deletions(-)

From: will.deacon@arm.com (Will Deacon)
Date: Fri, 14 Oct 2011 18:23:52 +0100
Subject: [PATCH] ARM: cpu topology: fix warning
In-Reply-To: <1318612470-2151-1-git-send-email-vincent.guittot@linaro.org>
References: <1318612470-2151-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20111014172351.GC19009@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vincent,

On Fri, Oct 14, 2011 at 06:14:30PM +0100, Vincent Guittot wrote:
> kernel/sched.c:7354:2: warning: initialization from incompatible pointer type
> 
> Align cpu_coregroup_mask prototype interface with sched_domain_mask_f typedef
> use int cpu instead of unsigned int cpu

Not sure I parse the commit message...

> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  arch/arm/include/asm/topology.h |    2 +-
>  arch/arm/kernel/topology.c      |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

... but this fixes the warning for me:

Reported-and-tested-by: Will Deacon <will.deacon@arm.com>

Thanks,

Will

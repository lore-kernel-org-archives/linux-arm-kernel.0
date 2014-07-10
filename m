From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 10 Jul 2014 12:03:18 +0100
Subject: [RESEND PATCH] arm64: topology: add MPIDR-based detection
In-Reply-To: <1402102527-10569-1-git-send-email-zlim@broadcom.com>
References: <1402102527-10569-1-git-send-email-zlim@broadcom.com>
Message-ID: <20140710110318.GA10749@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 07, 2014 at 01:55:27AM +0100, Zi Shen Lim wrote:
> Lorenzo and Mark agreed on the following updated patch from Lorenzo:
>     http://www.spinics.net/lists/arm-kernel/msg336998.html
> 
> W.r.t. cluster numbering, we're now back to where we were with the
> the original patch sent out in April:
>     https://lkml.org/lkml/2014/4/22/951
> 
> Were there any other objections to this approach?
> AFAICT, this patch should be good to go for 3.16.
> ------->8--------
> 
> Create cpu topology based on MPIDR. When hardware sets MPIDR to sane
> values, this method will always work. Therefore it should also work well
> as the fallback method. [1]
> 
> When we have multiple processing elements in the system, we create
> the cpu topology by mapping each affinity level (from lowest to highest)
> to threads (if they exist), cores, and clusters.
> 
> [1] http://www.spinics.net/lists/arm-kernel/msg317445.html
> 
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Zi Shen Lim <zlim@broadcom.com>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  arch/arm64/include/asm/cputype.h |  2 ++
>  arch/arm64/kernel/topology.c     | 47 ++++++++++++++++++++++++++++------------
>  2 files changed, 35 insertions(+), 14 deletions(-)

Applied for 3.17. Thanks.

-- 
Catalin

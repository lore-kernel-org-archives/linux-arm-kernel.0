From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 29 Oct 2015 17:19:44 +0000
Subject: [PATCH] ARM64: Enable multi-core scheduler support by default
In-Reply-To: <1445273749-16778-1-git-send-email-dietmar.eggemann@arm.com>
References: <1445273749-16778-1-git-send-email-dietmar.eggemann@arm.com>
Message-ID: <20151029171944.GS8899@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 05:55:49PM +0100, Dietmar Eggemann wrote:
> Make sure that the task scheduler domain hierarchy is set-up correctly
> on systems with single or multi-cluster topology.
> 
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 34d71dd86781..dc70d715bc38 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -51,6 +51,7 @@ CONFIG_PCI=y
>  CONFIG_PCI_MSI=y
>  CONFIG_PCI_XGENE=y
>  CONFIG_SMP=y
> +CONFIG_SCHED_MC=y
>  CONFIG_PREEMPT=y
>  CONFIG_KSM=y
>  CONFIG_TRANSPARENT_HUGEPAGE=y

Question: does enabling this option have any (positive) effect on the
vanilla kernel or it requires additional patches like EAS?

Thanks.

-- 
Catalin

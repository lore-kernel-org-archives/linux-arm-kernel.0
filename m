From: robherring2@gmail.com (Rob Herring)
Date: Thu, 26 Jul 2012 07:57:51 -0500
Subject: [PATCH] ARM: tegra: fix PCIe resource calculation
In-Reply-To: <1343239358-3239-1-git-send-email-swarren@wwwdotorg.org>
References: <1343239358-3239-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <50113ECF.10209@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/25/2012 01:02 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Commit 0acc43c "ARM: tegra: use fixed PCI i/o mapping" re-numbered the
> resource array entries that the driver used, but missed one location. This
> causes request_resource() to fail, and the driver to panic.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Rob, I'm not sure if you can squash this into your PCIE commit, or if
> we need to apply it on top?

I'm rebasing the branch and will incorporate it. Thanks for testing.

Rob

> 
>  arch/arm/mach-tegra/pcie.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c
> index 576347a..3463fb5 100644
> --- a/arch/arm/mach-tegra/pcie.c
> +++ b/arch/arm/mach-tegra/pcie.c
> @@ -406,7 +406,7 @@ static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
>  	pp->res[1].name = pp->prefetch_space_name;
>  	if (pp->index == 0) {
>  		pp->res[1].start = PREFETCH_MEM_BASE_0;
> -		pp->res[1].end = pp->res[2].start + PREFETCH_MEM_SIZE_0 - 1;
> +		pp->res[1].end = pp->res[1].start + PREFETCH_MEM_SIZE_0 - 1;
>  	} else {
>  		pp->res[1].start = PREFETCH_MEM_BASE_1;
>  		pp->res[1].end = pp->res[1].start + PREFETCH_MEM_SIZE_1 - 1;
> 

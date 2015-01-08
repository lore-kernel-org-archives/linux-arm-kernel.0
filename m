From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 8 Jan 2015 11:16:29 +0100
Subject: [PATCH v2 03/21] ARM: tegra: skip gic_arch_extn setup if DT has
 a LIC node
In-Reply-To: <1420652576-22309-4-git-send-email-marc.zyngier@arm.com>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
 <1420652576-22309-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150108101628.GE1987@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 07, 2015 at 05:42:38PM +0000, Marc Zyngier wrote:
> If we detect that our DT has a LIC node, don't setup gic_arch_extn,
> and skip tegra_legacy_irq_syscore_init as well.
> 
> This is only a temporary measure until that code is removed for good.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/mach-tegra/irq.c   | 11 +++++++++++
>  arch/arm/mach-tegra/tegra.c |  1 -
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
> index 7f87a50..b37141d 100644
> --- a/arch/arm/mach-tegra/irq.c
> +++ b/arch/arm/mach-tegra/irq.c
> @@ -255,11 +255,21 @@ static void tegra114_gic_cpu_pm_registration(void)
>  static void tegra114_gic_cpu_pm_registration(void) { }
>  #endif
>  
> +static const struct of_device_id tegra_ictlr_match[] __initconst = {
> +	{ .compatible = "nvidia,tegra-ictlr" },

Like I said elsewhere, I think this should be "nvidia,tegra20-ictlr" and
there should be another entry for "nvidia,tegra30-ictlr".

Otherwise looks good, so with that fixed:

Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150108/778ef8b2/attachment.sig>

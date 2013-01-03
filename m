From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 03 Jan 2013 13:17:16 -0700
Subject: [PATCH v4 05/19] ARM: GIC: remove direct use of gic_raise_softirq
In-Reply-To: <1357235668-9450-6-git-send-email-robherring2@gmail.com>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
 <1357235668-9450-6-git-send-email-robherring2@gmail.com>
Message-ID: <50E5E74C.20008@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/2013 10:54 AM, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> In preparation of moving gic code to drivers/irqchip, remove the direct
> platform dependencies on gic_raise_softirq. Move the setup of
> smp_cross_call into the gic code and use arch_send_wakeup_ipi_mask
> function to trigger wake-up IPIs.

For all the Tegra-related parts,
Acked-by: Stephen Warren <swarren@nvidia.com>

Will this series be put into an arm-soc (or other stable) branch that I
can pull into any Tegra branches in case there are any merge conflicts?

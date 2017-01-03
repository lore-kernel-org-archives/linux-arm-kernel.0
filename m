From: robh@kernel.org (Rob Herring)
Date: Tue, 3 Jan 2017 11:46:01 -0600
Subject: [PATCH 8/9] irqchip/ls-scfg-msi: add LS1043a v1.1 MSI support
In-Reply-To: <1482829985-24421-8-git-send-email-Minghuan.Lian@nxp.com>
References: <1482829985-24421-1-git-send-email-Minghuan.Lian@nxp.com>
 <1482829985-24421-8-git-send-email-Minghuan.Lian@nxp.com>
Message-ID: <20170103174601.jbmqo7iataemzyxc@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 27, 2016 at 05:13:04PM +0800, Minghuan Lian wrote:
> A MSI controller of LS1043a v1.0 only includes one MSIR and
> is assigned one GIC interrupt. In order to support affinity,
> LS1043a v1.1 MSI is assigned 4 MSIRs and 4 GIC interrupts.
> But the MSIR has the different offset and only supports 8 MSIs.
> The bits between variable bit_start and bit_end in structure
> ls_scfg_msir are used to show 8 MSI interrupts. msir_irqs and
> msir_base are added to describe the difference of MSI between
> LS1043a v1.1 and other SoCs.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
>  .../interrupt-controller/fsl,ls-scfg-msi.txt       |  1 +
>  drivers/irqchip/irq-ls-scfg-msi.c                  | 45 +++++++++++++++++++---
>  2 files changed, 40 insertions(+), 6 deletions(-)

Acked-by: Rob Herring <robh@kernel.org> 

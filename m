From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Wed, 23 Mar 2016 10:18:11 +0100
Subject: [PATCH 2/2 v5] irqchip/Layerscape: Add SCFG MSI controller support
In-Reply-To: <1457321782-3245-2-git-send-email-Minghuan.Lian@nxp.com>
References: <1457321782-3245-1-git-send-email-Minghuan.Lian@nxp.com>
 <1457321782-3245-2-git-send-email-Minghuan.Lian@nxp.com>
Message-ID: <7239962.9Fyo0vfqsc@ws-stein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 March 2016 11:36:22, Minghuan Lian wrote:
> Some kind of NXP Layerscape SoC provides a MSI
> implementation which uses two SCFG registers MSIIR and
> MSIR to support 32 MSI interrupts for each PCIe controller.
> The patch is to support it.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>

Tested-by: Alexander Stein <alexander.stein@systec-electronic.com>

Using an intel e1000e card which uses 3 MSIs. But the IRQ numbers are a bit strange though:
> grep eth3 /proc/interrupts
> 
>  63:         49          0       MSI 134742016 Edge      eth3-rx-0
>  64:          3          0       MSI 134742017 Edge      eth3-tx-0
>  65:          4          0       MSI 134742018 Edge      eth3

Best regards,
Alexander

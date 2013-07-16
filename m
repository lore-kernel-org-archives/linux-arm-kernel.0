From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 16 Jul 2013 11:37:15 +0800
Subject: [v7 3/3] sata: imx: add ahci sata support on imx platforms
In-Reply-To: <1373945328-20893-4-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1373945328-20893-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1373945328-20893-4-git-send-email-Hong-Xing.Zhu@freescale.com>
Message-ID: <20130716033711.GF28375@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 11:28:48AM +0800, Richard Zhu wrote:
> From: Richard Zhu <r65037@freescale.com>
> 
> imx6q contains one Synopsys AHCI SATA controller,
> But it can't share ahci_platform driver with other
> controllers.
> Because there are some misalignments of the generic
> AHCI controller.
> The bits definitions of the HBA registers, the Vendor
> Specific registers, the AHCI PHY clock and the AHCI
> signals adjustment window(GPR13 register).
>  - CAP_SSS(bit20) of the HOST_CAP is writable, default
>  value is '0', should be configured to be '1'
>  - bit0 (only one AHCI SATA port on imx6q) of the
>  HOST_PORTS_IMPL should be set to be '1'.(default 0)
>  - One Vendor Specific register HOST_TIMER1MS(offset:0xe0)
>  should be configured regarding to the frequency of AHB
>  bus clock.
>  - Configurations of the AHCI PHY clock, and the signal
>  parameters of the GPR13
> 
> Setup its own ahci sata driver, contained the imx6q specific
> initialized codes, re-use the generic ahci_platform driver, and
> keep the generic ahci_platform driver clean as much as possible.
> 
> Signed-off-by: Richard Zhu <r65037@freescale.com>

Reviewed-by: Shawn Guo <shawn.guo@linaro.org>

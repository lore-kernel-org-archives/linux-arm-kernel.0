From: ryder.lee@mediatek.com (Ryder Lee)
Date: Mon, 30 Apr 2018 10:02:26 +0800
Subject: [PATCH v6 0/2] PCI: mediatek: Fixups for the IRQ handle routine
 and MT7622's class code
In-Reply-To: <1524201910-22836-1-git-send-email-honghui.zhang@mediatek.com>
References: <1524201910-22836-1-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <1525053746.5013.8.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-04-20 at 13:25 +0800, Honghui Zhang (???) wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> Two fixups for mediatek's host bridge:
> The first patch fixup class type and vendor ID for MT7622.
> The second patch fixup the IRQ handle routine by using irq_chip solution
> to avoid IRQ reentry which may exist for both MT2712 and MT7622.
> 
> Change since v5:
>  - Make the comments consistend with the code modification in the first patch.
>  - Using writew to performing a 16-bit write.
>  - Using irq_chip solution to fix the IRQ issue.
> 
> The v5 patchset could be found in:
>  https://patchwork.kernel.org/patch/10133303
>  https://patchwork.kernel.org/patch/10133305
> 
> Change since v4:
>  - Only setup vendor ID for MT7622, igorning the device ID since mediatek's
>    host bridge driver does not cares about the device ID.
> 
> Change since v3:
>  - Setup the class type and vendor ID at the beginning of startup instead
>    of in a quirk.
>  - Add mediatek's vendor ID, it could be found in:
>    https://pcisig.com/membership/member-companies?combine=&page=4
> 
> Change since v2:
>  - Move the initialize of the iterate before the loop to fix an
>    INTx IRQ issue in the first patch
> 
> Change since v1:
>  - Add the second patch.
>  - Make the first patch's commit message more standard.
> Honghui Zhang (2):
>   PCI: mediatek: Set up vendor ID and class type for MT7622
>   PCI: mediatek: Using chained IRQ to setup IRQ handle
> 
>  drivers/pci/host/pcie-mediatek.c | 220 +++++++++++++++++++++++----------------
>  include/linux/pci_ids.h          |   2 +
>  2 files changed, 133 insertions(+), 89 deletions(-)


Acked-by: Ryder Lee <ryder.lee@mediatek.com> for the series.

Thanks

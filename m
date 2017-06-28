From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 28 Jun 2017 14:50:49 -0500
Subject: [PATCH 0/3] change powerup logic for MediaTek PCIe controller
In-Reply-To: <1497866400-41844-1-git-send-email-ryder.lee@mediatek.com>
References: <1497866400-41844-1-git-send-email-ryder.lee@mediatek.com>
Message-ID: <20170628195049.GQ17844@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 19, 2017 at 05:59:57PM +0800, Ryder Lee wrote:
> Hi Bjorn,
> 
> This patch series does some modifications to powerup logic to avoid unbalanced
> PM warnings, and turns off host power if no link is detected.
> 
> I also make some properties(eg, PHY/reset/..) optional to gain more flexibility
> just in case future SoCs don't have it.
> 
> Could you also fold this patch series into pci/host-mediatek for v4.13?
> Thanks!
> 
> Ryder Lee (3):
>   PCI: mediatek: modify controller powerup logic
>   PCI: mediatek: turn off subsys power if no link up detected
>   PCI: mediatek: make some properties optioanl
> 
>  drivers/pci/host/pcie-mediatek.c | 110 +++++++++++++++++++++------------------
>  1 file changed, 58 insertions(+), 52 deletions(-)

I folded these into the initial driver commit on pci/host-mediatek
for v4.13, thanks!

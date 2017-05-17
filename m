From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 17 May 2017 12:11:54 -0500
Subject: [PATCH v6 2/3] iommu/pci: reserve IOVA for PCI masters
In-Reply-To: <1494912127-12890-3-git-send-email-oza.oza@broadcom.com>
References: <1494912127-12890-1-git-send-email-oza.oza@broadcom.com>
 <1494912127-12890-3-git-send-email-oza.oza@broadcom.com>
Message-ID: <20170517171154.GF31462@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 16, 2017 at 10:52:06AM +0530, Oza Pawandeep wrote:
> this patch reserves the IOVA for PCI masters.
> ARM64 based SOCs may have scattered memory banks.
> such as iproc based SOC has
> 
> <0x00000000 0x80000000 0x0 0x80000000>, /* 2G @ 2G */
> <0x00000008 0x80000000 0x3 0x80000000>, /* 14G @ 34G */
> <0x00000090 0x00000000 0x4 0x00000000>, /* 16G @ 576G */
> <0x000000a0 0x00000000 0x4 0x00000000>; /* 16G @ 640G */
> 
> but incoming PCI transcation addressing capability is limited

s/transcation/transaction/

> by host bridge, for example if max incoming window capability
> is 512 GB, then 0x00000090 and 0x000000a0 will fall beyond it.
> 
> to address this problem, iommu has to avoid allocating IOVA which

s/iommu/IOMMU/

> are reserved. which inturn does not allocate IOVA if it falls into hole.

s/inturn/in turn/

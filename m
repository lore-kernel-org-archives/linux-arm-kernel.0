From: bhelgaas@google.com (Bjorn Helgaas)
Date: Wed, 20 May 2015 15:03:30 -0500
Subject: [PATCH v2 0/2] PCI: designware: improve iATU programming and usage
In-Reply-To: <1430382149-1645-1-git-send-email-jszhang@marvell.com>
References: <1430382149-1645-1-git-send-email-jszhang@marvell.com>
Message-ID: <20150520200330.GB32152@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[+cc Pratyush]

On Thu, Apr 30, 2015 at 04:22:27PM +0800, Jisheng Zhang wrote:
> The outbound iATU programming functions are similar, so PATCH1 consolidates
> them into one.
> 
> Most transactions' type are cfg0 and MEM, so current iATU usage is not
> balanced. PATCH2 adopts idea from Minghuan Lian <Minghuan.Lian@freescale.com>:
> 
>  http://www.spinics.net/lists/linux-pci/msg40440.html
> 
> to change the iATU allocation: iATU0 for cfg and IO, iATU1 for MEM.
> 
> Changes since v1:
> - remove outbound iATU programming for IO in dw_pcie_host_init, since it can
>   be done by berlin_pcie_{rd|wr}_other_conf() latter.
> - only do outbound iATU programming for MEM if pp->ops->rd_other_conf is not
>   set. Thank Fabrice Gasnier to point out "some platforms doesn't have support
>   for ATU"
> 
> Jisheng Zhang (2):
>   PCI: designware: consolidate outbound iATU programming functions
>   PCI: designware: use iATU0 for cfg and IO, iATU1 for MEM
> 
>  drivers/pci/host/pcie-designware.c | 142 ++++++++++++++++---------------------

Applied both with Pratyush's ack to pci/host-designware for v4.2, thanks!

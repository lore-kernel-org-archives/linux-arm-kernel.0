From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 17 Aug 2016 16:01:00 -0500
Subject: [PATCH v2 0/2] PCI: designware: let dw_pcie_link_up() beware of
 LTSSM training bit
In-Reply-To: <1470823623-1360-1-git-send-email-jszhang@marvell.com>
References: <1470823623-1360-1-git-send-email-jszhang@marvell.com>
Message-ID: <20160817210100.GD27353@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2016 at 06:07:01PM +0800, Jisheng Zhang wrote:
> patch1 is a trivial clean up: move the parameters for wait for link
> into the core pcie-designware.c
> 
> Since link may be UP but still in link training, if so, we can't think
> the link is up and operating correctly. So patch2 teaches
> dw_pcie_link_up() beware of the PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING bit.
> 
> Since v1:
>   - add Joao's Ack
>   - rebased on v4.8-rc1
> 
> Jisheng Zhang (2):
>   PCI: designware: mv parameters for wait for link into
>     pcie-designware.c
>   PCI: designware: let dw_pcie_link_up() beware of LTSSM training bit
> 
>  drivers/pci/host/pcie-designware.c | 11 +++++++++--
>  drivers/pci/host/pcie-designware.h |  5 -----
>  2 files changed, 9 insertions(+), 7 deletions(-)

Applied to pci/host-designware for v4.9, thanks, Jisheng.

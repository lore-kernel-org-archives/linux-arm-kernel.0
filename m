From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 10 Aug 2016 18:21:45 +0800
Subject: [PATCH v2 0/2] PCI: designware: let dw_pcie_link_up() beware of
 LTSSM training bit
In-Reply-To: <1470823623-1360-1-git-send-email-jszhang@marvell.com>
References: <1470823623-1360-1-git-send-email-jszhang@marvell.com>
Message-ID: <20160810182145.7a821b38@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 10 Aug 2016 18:07:01 +0800 Jisheng Zhang wrote:

> patch1 is a trivial clean up: move the parameters for wait for link
> into the core pcie-designware.c
> 
> Since link may be UP but still in link training, if so, we can't think
> the link is up and operating correctly. So patch2 teaches
> dw_pcie_link_up() beware of the PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING bit.

hmm, there's one accident with my email system, the v2 series is sent twice

Sorry for inconvenience,
Jisheng

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
> 

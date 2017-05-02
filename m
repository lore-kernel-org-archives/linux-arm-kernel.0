From: dingtianhong@huawei.com (Ding Tianhong)
Date: Tue, 2 May 2017 08:56:41 +0800
Subject: [PATCH 0/2] Add new PCI_DEV_FLAGS_NO_RELAXED_ORDERING flag
In-Reply-To: <cover.1493678834.git.leedom@chelsio.com>
References: <cover.1493678834.git.leedom@chelsio.com>
Message-ID: <187e33fe-2c61-076f-7ce8-53b6e900414e@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Casey:

This solution looks good to me, I will test this for ixgbe.:)

Thanks
Ding

On 2017/5/2 7:13, Casey Leedom wrote:
> Some devices have problems with Transaction Layer Packets with the Relaxed
> Ordering Attribute set.  This patch set adds a new PCIe Device Flag,
> PCI_DEV_FLAGS_NO_RELAXED_ORDERING, a set of PCI Quirks to catch some known
> devices with Relaxed Ordering issues, and a use of this new flag by the
> cxgb4 driver to avoid using Relaxed Ordering with problematic Root Complex
> Ports.
> 
> It's been years since I've submitted kernel.org patches, I appolgise for the
> almost certain submission errors.
> 
> Casey Leedom (2):
>   PCI: Add new PCIe Fabric End Node flag,
>     PCI_DEV_FLAGS_NO_RELAXED_ORDERING
>   net/cxgb4: Use new PCI_DEV_FLAGS_NO_RELAXED_ORDERING flag
> 
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4.h      |  1 +
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c | 17 +++++++++++
>  drivers/net/ethernet/chelsio/cxgb4/sge.c        |  5 ++--
>  drivers/pci/quirks.c                            | 38 +++++++++++++++++++++++++
>  include/linux/pci.h                             |  2 ++
>  5 files changed, 61 insertions(+), 2 deletions(-)
> 

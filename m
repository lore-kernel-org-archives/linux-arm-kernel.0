From: robh@kernel.org (Rob Herring)
Date: Thu, 14 Jan 2016 20:28:00 -0600
Subject: [PATCH v2 next-next] net: hns: enet specifies a reference to dsaf
In-Reply-To: <1452654880-28980-1-git-send-email-yankejian@huawei.com>
References: <1452654880-28980-1-git-send-email-yankejian@huawei.com>
Message-ID: <20160115022800.GA29856@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 13, 2016 at 11:14:40AM +0800, Kejian Yan wrote:
> This patch replace the assoication between dsaf and enet from string
> matching to object reference. It requires the DTS to be updated within
> BIOS. Thanks god it can be done for all released boards.
> 
> Signed-off-by: Kejian Yan <yankejian@huawei.com>
> ---
> change log:
> v2:
>  merge the two patches into one to allow bisection.


> 
> v1:
>  first submit.
> 
> v1 patch reference:
>  https://lkml.org/lkml/2015/12/5/11
>  https://lkml.org/lkml/2015/12/5/12
> ---
>  .../devicetree/bindings/net/hisilicon-hns-dsaf.txt    |  5 +----
>  .../devicetree/bindings/net/hisilicon-hns-nic.txt     |  7 ++++---
>  arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi          | 19 +++++++++----------

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/net/ethernet/hisilicon/hns/hnae.c             | 17 +++++++----------
>  drivers/net/ethernet/hisilicon/hns/hnae.h             |  7 +++++--
>  drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c     |  4 ++++
>  drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c    | 10 +---------
>  drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h    |  1 +
>  drivers/net/ethernet/hisilicon/hns/hns_enet.c         | 13 +++++++++----
>  drivers/net/ethernet/hisilicon/hns/hns_enet.h         |  2 +-
>  10 files changed, 42 insertions(+), 43 deletions(-)

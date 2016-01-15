From: robh@kernel.org (Rob Herring)
Date: Thu, 14 Jan 2016 20:17:18 -0600
Subject: [patch v3 net-next 1/2] dts: hisi: fixes no syscon fault when
 init mdio
In-Reply-To: <1452668999-443-2-git-send-email-yankejian@huawei.com>
References: <1452668999-443-1-git-send-email-yankejian@huawei.com>
 <1452668999-443-2-git-send-email-yankejian@huawei.com>
Message-ID: <20160115021718.GA24459@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 13, 2016 at 03:09:58PM +0800, Kejian Yan wrote:
> When linux start up, we get the log below:
> "Hi-HNS_MDIO 803c0000.mdio: no syscon hisilicon,peri-c-subctrl
> mdio_bus mdio at 803c0000: mdio sys ctl reg has not maped"
> 
> The source code about the subctrl is dealt syscon, but dts doesn't.
> It cause such fault, so this patch adds the syscon info on dts files to
> fixes it.
> 
> Signed-off-by: Kejian Yan <yankejian@huawei.com>
> ---
> change log:
> v3:
>  1) uses capital letter at the beginning of sentences
>  2) updates the right device node name
> 
> v2:
>  1) updates the related documented in the binding as well
>  2) uses the normal naming conventions using '-' instead of '_'
> 
> v1:
>  first submit
> 
> v2 patch link: https://lkml.org/lkml/2015/12/7/80
> v1 patch link: https://lkml.org/lkml/2015/11/28/3
> ---
>  .../devicetree/bindings/arm/hisilicon/hisilicon.txt      | 16 ++++++++++++++++
>  arch/arm64/boot/dts/hisilicon/hip05.dtsi                 |  5 +++++
>  arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi             |  4 ++--
>  3 files changed, 23 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

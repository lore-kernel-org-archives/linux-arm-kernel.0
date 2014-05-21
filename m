From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 May 2014 23:01:04 +0900
Subject: [PATCH V3 0/4] dts: Add usb2phy to Exynos 5250/5420
In-Reply-To: <1400498356-26803-1-git-send-email-vikas.sajjan@samsung.com>
References: <1400498356-26803-1-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <037c01cf74fd$1afaddb0$50f09910$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vikas Sajjan wrote:
> 
> Based on 'for-next' branch of Kgene's linux-samsung tree.
> These patches are as per discussions on the driver side patches
> which have already been acked. [1]
> 
Sounds good. I will apply this whole series if dt guys have no objection to
add the exynos5-sysreg dt binding.

Thanks,
Kukjin

> Changes from v2:
> 	- Addressed kukjin's comments to update DT binding documentation
> for sysreg.
> 	- removed the version for each patch. Made all patches version as
> same.
> 
> Changes from v1:
>  - Rebase on 'for-next' branch.
>  - Removed 'phy-names' property as per discuusion in the driver patches.
> [1]
> 
> V1 of this series was the next version for earlier patch-series:
> [PATCH v7 0/2] dts: Add usb2phy to Exynos 5250 [2]
> 
> Changes from v7 series:
>  - Added patches to enable usb 2.0 support on exynos5420;
>    which include dt nodes for usb2phy as well as ehci and ohci
>    controllers.
> 
> Changes from v6:
>  - Splitted the patch into two:
>     adding syscon nodes to Exynos5250 and Exynos5420 in first;
>     and phy entry change in the second.
>  - Changed the name of phandle for usb2phy from 'usb2_phy_new'
>    to 'usb2_phy_gen' indicating generic phy.
>  - Using clock macros in dt entries.
> 
> [1] http://www.spinics.net/lists/linux-usb/msg106908.html
>     http://www.spinics.net/lists/linux-usb/msg106837.html
> [2] http://www.spinics.net/lists/linux-usb/msg106427.html
> 
> Kamil Debski (1):
>   ARM: dts: Add usb2phy to Exynos 5250
> 
> Vivek Gautam (3):
>   ARM: dts: Add sysreg sytem controller node to exynos5250 and
>     exynos5420
>   ARM: dts: Add usb2phy support on exynos5420
>   ARM: dts: Add usb 2.0 support on exynos5420
> 
>  .../devicetree/bindings/arm/samsung/sysreg.txt     |   11 ++++-
>  arch/arm/boot/dts/exynos5250.dtsi                  |   27 ++++++++++++
>  arch/arm/boot/dts/exynos5420.dtsi                  |   45
++++++++++++++++++++
>  3 files changed, 81 insertions(+), 2 deletions(-)

From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 16 Aug 2017 10:52:32 +0900
Subject: [PATCH v2 0/5] usb: Replace the deprecated extcon API
In-Reply-To: <1501748448-26821-1-git-send-email-cw00.choi@samsung.com>
References: <CGME20170803082049epcas1p3ca6cb415ce40b24fa360f7155ea0829c@epcas1p3.samsung.com>
 <1501748448-26821-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <5993A560.2070301@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Kishon and Felipe,

I applied these patches on extcon-next branch for v4.14-rc1.

And I created the immutable branch ('ib-extcon-usb-phy-4.14')
and send the pull-request for these patches in order to
prevent the merge conflict.

Best Regards,
Chanwoo Choi


The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git ib-extcon-usb-phy-4.14

for you to fetch changes up to 808ae8f3c7fefef3aece08820c108b68cdb06e1e:

  extcon: Remove deprecated extcon_set/get_cable_state_() (2017-08-16 09:21:49 +0900)

----------------------------------------------------------------
Chanwoo Choi (5):
      phy: qcom-usb-hs: Replace the extcon API
      phy: rockchip-inno-usb2: Replace the extcon API
      phy: phy-bcm-ns2-usbdrd: Replace the deprecated extcon API
      usb: gadget: udc: Replace the deprecated extcon API
      extcon: Remove deprecated extcon_set/get_cable_state_()

 drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c     |  8 ++++----
 drivers/phy/qualcomm/phy-qcom-usb-hs.c        | 14 +++-----------
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 10 +++++-----
 drivers/usb/gadget/udc/snps_udc_plat.c        |  6 +++---
 include/linux/extcon.h                        | 11 -----------
 5 files changed, 15 insertions(+), 34 deletions(-)


On 2017? 08? 03? 17:20, Chanwoo Choi wrote:
> These patches replace the deprecated extcon API and remove them from extcon.
> 
> Patch4 (drivers/usb/gadget/udc/snps_udc_plat.c) neeeds the review
> from usb maintainer. After finishing the review of patch4,
> I'll create the immutable branch and send the pull request
> to both usb and phy maintainer.
> 
> Changes from v1:
> - Fix capital error for 'acked-by' tag on patch2
> - Add the acked-by tag of 'Kishon Vijay Abraham I' to patch3
> 
> Chanwoo Choi (5):
>   phy: qcom-usb-hs: Replace the extcon API
>   phy: rockchip-inno-usb2: Replace the extcon API
>   phy: phy-bcm-ns2-usbdrd: Replace the deprecated extcon API
>   usb: gadget: udc: Replace the deprecated extcon API
>   extcon: Remove deprecated extcon_set/get_cable_state_()
> 
>  drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c     |  8 ++++----
>  drivers/phy/qualcomm/phy-qcom-usb-hs.c        | 14 +++-----------
>  drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 10 +++++-----
>  drivers/usb/gadget/udc/snps_udc_plat.c        |  6 +++---
>  include/linux/extcon.h                        | 11 -----------
>  5 files changed, 15 insertions(+), 34 deletions(-)
> 

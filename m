From: kishon@ti.com (kishon)
Date: Fri, 18 Jan 2013 10:58:03 +0530
Subject: [RFC PATCH 3/6] usb: otg: utils: change the phy lib to support
 multiple PHYs of same type
In-Reply-To: <50F821DD.1040609@ti.com>
References: <1358348462-27693-1-git-send-email-kishon@ti.com>
 <1358348462-27693-4-git-send-email-kishon@ti.com> <50F821DD.1040609@ti.com>
Message-ID: <50F8DD63.8070404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday 17 January 2013 09:37 PM, Roger Quadros wrote:
> On 01/16/2013 05:00 PM, Kishon Vijay Abraham I wrote:
>> In order to add support for multipe PHY's of the same type, the API's
>> for adding PHY and getting PHY has been changed. Now the binding
>> information of the PHY and controller should be done in platform file
>> using usb_bind_phy API. And for getting a PHY, the device pointer of the
>> USB controller and an index should be passed. Based on the binding
>> information that is added in the platform file, get_phy will return the
>> approappropriate PHY.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>   arch/arm/mach-shmobile/board-marzen.c |    2 +-
>>   drivers/power/ab8500_charger.c        |    2 +-
>>   drivers/power/isp1704_charger.c       |    2 +-
>>   drivers/power/pda_power.c             |    2 +-
>>   drivers/power/twl4030_charger.c       |    2 +-
>>   drivers/usb/chipidea/udc.c            |    2 +-
>>   drivers/usb/dwc3/core.c               |    4 +-
>>   drivers/usb/gadget/fsl_udc_core.c     |    2 +-
>>   drivers/usb/gadget/mv_udc_core.c      |    2 +-
>>   drivers/usb/gadget/omap_udc.c         |    2 +-
>>   drivers/usb/gadget/pxa25x_udc.c       |    2 +-
>>   drivers/usb/gadget/pxa27x_udc.c       |    2 +-
>>   drivers/usb/gadget/s3c-hsudc.c        |    2 +-
>>   drivers/usb/host/ehci-fsl.c           |    2 +-
>>   drivers/usb/host/ehci-msm.c           |    2 +-
>>   drivers/usb/host/ehci-mv.c            |    2 +-
>>   drivers/usb/host/ehci-tegra.c         |    2 +-
>>   drivers/usb/host/ohci-omap.c          |    2 +-
>>   drivers/usb/musb/am35x.c              |    2 +-
>>   drivers/usb/musb/blackfin.c           |    2 +-
>>   drivers/usb/musb/da8xx.c              |    2 +-
>>   drivers/usb/musb/davinci.c            |    2 +-
>>   drivers/usb/musb/musb_dsps.c          |    2 +-
>>   drivers/usb/musb/omap2430.c           |    2 +-
>>   drivers/usb/musb/tusb6010.c           |    2 +-
>>   drivers/usb/musb/ux500.c              |    2 +-
>>   drivers/usb/otg/ab8500-usb.c          |    3 +-
>>   drivers/usb/otg/fsl_otg.c             |    5 ++-
>>   drivers/usb/otg/gpio_vbus.c           |    3 +-
>>   drivers/usb/otg/isp1301_omap.c        |    3 +-
>>   drivers/usb/otg/msm_otg.c             |    3 +-
>>   drivers/usb/otg/mv_otg.c              |    3 +-
>>   drivers/usb/otg/nop-usb-xceiv.c       |    3 +-
>>   drivers/usb/otg/otg.c                 |   67 +++++++++++++++------------------
>>   drivers/usb/otg/twl4030-usb.c         |    3 +-
>>   drivers/usb/phy/mv_u3d_phy.c          |    3 +-
>>   drivers/usb/phy/omap-usb2.c           |   11 ++----
>>   drivers/usb/phy/rcar-phy.c            |    3 +-
>>   include/linux/usb/phy.h               |   12 +++---
>>   39 files changed, 87 insertions(+), 89 deletions(-)
>
> I think it better to leave the existing add/get APIs as they are add add
> new APIs that support multiple PHYs. You could probably mark the old
> ones as deprecated.
>
> That way you don't need to wait till all users are converted and tested.

Makes sense. Will do that :-)

Thanks
Kishon

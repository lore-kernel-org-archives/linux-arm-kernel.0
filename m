From: Peter.Chen@freescale.com (Peter Chen)
Date: Mon, 20 Jan 2014 06:48:24 +0000
Subject: [PATCH v9 00/12] Add power management support for mxs phy
In-Reply-To: <1388111921-17326-1-git-send-email-peter.chen@freescale.com>
References: <1388111921-17326-1-git-send-email-peter.chen@freescale.com>
Message-ID: <e3a207a65094481e9a3e149ac89e6505@BL2PR03MB226.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



 
> 
> Hi Felipe & Shawn,
> 
> The serial adds power management support for MXS PHY, it includes:
> 
> - Add one PHY API .set_wakeup, and related API implementation at mxs phy
> driver
> - misc changes and bug fixes for mxs phy to support low power mode and
> wakeup.
> 
> It is based on the lastest Greg's usb-next, 3.13-rc5.
> 

Hi Felipe,

I would like to confirm if this patchset is ok, and will be in
your 3.15 tree?

Peter

> Changes for v9:
> - Fix the build warning if CONFIG_SUSPEND is not set
> 
> Changes for v8:
> - Shawn has already applied two dts patches, so delete them at
>   v8 version, http://marc.info/?l=linux-arm-kernel&m=138785188404939&w=2
> - Using of_get_property to avoid imx6 fail at probe when using old DTB
> [5/12]
> - Do not consider failure if alias id is not existed, it can avoid fail
>   at probe when using old DTB [8/12]
> - We don't need more changes for [8/12] change due to we use
>   "mxs_phy->port_id ==" as condition
> 
> Changes for v7:
> - Fixed indentation problem at binding doc [1/14]
> - s/ganranteed/guaranteed, and add explanation for "auto setting" [3/14]
> - add static before SIMPLE_DEV_PM_OPS [13/14]
> - add one patch to change usb device description [7/14]
> - Delete the .nofity_suspend and .notify_resume due to Felipe
>   does not agree to add them as PHY API, will use other ways to implement
>   them in future.
> 
> Changes for v6:
> - Add description for IC bug fixes logic. [9/15]
> - Move is_imx6q_phy and is_imx6sl_phy from [9/15] to [14/15]
> - %s/mxs_phy_clock_switch/mxs_phy_clock_switch_delay to reflect
> the function meaning more precise [15/15]
> 
> Changes for v5:
> Add Marc and Michael Grzeschik's commnets
> - typo error at [2/15]
> - sqhash patches which introducing mxs_phy_disconnect_line and
> fixed but at this function. [13/15]
> - Introducing flag MXS_PHY_NEED_IP_FIX who stands for the SoCs
> who have IC fixes. [2/15, 8/15]
> - Delete one patch for low speed connection problem at every rare
> situations due to the root cause has still not found.
> 
> Peter Chen (12):
>   usb: doc: phy-mxs: Add more compatible strings
>   usb: phy-mxs: Add platform judgement code
>   usb: phy-mxs: Add auto clock and power setting
>   usb: doc: phy-mxs: update binding for adding anatop phandle
>   usb: phy-mxs: Add anatop regmap
>   usb: phy-mxs: change description of usb device speed
>   usb: phy-mxs: Enable IC fixes for related SoCs
>   usb: phy-mxs: add controller id
>   usb: phy: Add set_wakeup API
>   usb: phy-mxs: Add implementation of set_wakeup
>   usb: phy-mxs: Add system suspend/resume API
>   usb: phy-mxs: Add sync time after controller clear phcd
> 
>  Documentation/devicetree/bindings/usb/mxs-phy.txt |    5 +-
>  drivers/usb/phy/phy-mxs-usb.c                     |  310
> ++++++++++++++++++++-
>  include/linux/usb/phy.h                           |   16 +
>  3 files changed, 316 insertions(+), 15 deletions(-)
> 
> --
> 1.7.8
> 

From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 28 Oct 2013 16:20:08 +0800
Subject: [Patch v2 00/14] Add power management support for MXS PHY
In-Reply-To: <1382421528-17897-1-git-send-email-peter.chen@freescale.com>
References: <1382421528-17897-1-git-send-email-peter.chen@freescale.com>
Message-ID: <20131028082008.GE31499@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 22, 2013 at 01:58:34PM +0800, Peter Chen wrote:
> Hi Felipe,

Hi Felipe, would you please give any comments for this patchset?
My another patchset chipidea's PM support also depends on this.
Thanks.

Peter

> 
>    The serial adds power management support for MXS PHY, it includes:
> 
>    - Add three common PHY API, .set_wakeup, .notify_suspend, notify_resume.
>    - Related above API implementation at mxs phy driver
>    - misc changes for mxs phy to support low power mode and wakeup.
> 
> Changes for v2:
> 
> - Add missing patches which introduce platform judgement code [1/14,2/14]
> - re-order the patch sequence, like doc->dts->source file, 
> the reviewers can know the meaning of dt properties before review source
> - Add description of two IC problems exsiting at mxs PHY; change
> "high speed" to "HS" and "non-high speed" to "FS/LS" [5/14]
> - Change the dt property disconnect-line-without-vbus
> that the separator should be "-" not the "_", meanwhile, related source
> code has changed.
> - Using one local variable to get the function return val to avoid long
> condition statement. [13/14]
> 
> Peter Chen (14):
>   usb: doc: phy-mxs: Add more compatible strings
>   usb: phy-mxs: Add platform judgement code
>   usb: phy-mxs: Add auto clock and power setting
>   usb: doc: phy-mxs: update binding for adding anatop phandle
>   ARM: dts: imx6: add anatop phandle for usbphy
>   usb: phy-mxs: Add anatop regmap
>   usb: phy: add notify suspend and resume callback
>   usb: phy-mxs: Add implementation of nofity_suspend and notify_resume
>   usb: phy-mxs: Enable IC fixes for mx6 SoC serial
>   usb: doc: phy-mxs: update binding for adding disconnect line property
>   ARM: dts: imx6: Add disconnect-line-without-vbus property for usbphy
>   usb: phy: Add set_wakeup API
>   usb: phy-mxs: Add implementation of set_wakeup
>   usb: phy-mxs: Add system suspend/resume API
> 
>  Documentation/devicetree/bindings/usb/mxs-phy.txt |   12 +-
>  arch/arm/boot/dts/imx6qdl.dtsi                    |    3 +
>  drivers/usb/phy/phy-mxs-usb.c                     |  328 ++++++++++++++++++++-
>  include/linux/usb/phy.h                           |   39 +++
>  4 files changed, 367 insertions(+), 15 deletions(-)
> 

-- 

Best Regards,
Peter Chen

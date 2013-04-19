From: horms@verge.net.au (Simon Horman)
Date: Fri, 19 Apr 2013 11:14:14 +0900
Subject: [PATCH v3 4/4] ARM: shmobile: BOCK-W: enable USB in defconfig
In-Reply-To: <5170789D.5020108@cogentembedded.com>
References: <201304170135.10251.sergei.shtylyov@cogentembedded.com>
 <20130418140552.GO20929@verge.net.au>
 <5170789D.5020108@cogentembedded.com>
Message-ID: <20130419021414.GB25718@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 19, 2013 at 02:50:05AM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 04/18/2013 06:05 PM, Simon Horman wrote:
> 
> >
> >>Enable USB platform EHCI/OHCI and common PHY drivers in 'bockw_defconfig'.
> >>Enable USB storage driver and SCSI disk driver that it needs as well...
> >>
> >>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >I realise that this is not going to be useful until the rest
> >of the series has been merged. But regardless I have pre-emptively
> >queued it up for v3.11 in the defconfig-bockw branch.
> >>---
> >>  arch/arm/configs/bockw_defconfig |   11 ++++++++++-
> >>  1 file changed, 10 insertions(+), 1 deletion(-)
> >>
> >>Index: renesas/arch/arm/configs/bockw_defconfig
> >>===================================================================
> >>--- renesas.orig/arch/arm/configs/bockw_defconfig
> >>+++ renesas/arch/arm/configs/bockw_defconfig
> >>@@ -48,6 +48,8 @@ CONFIG_DEVTMPFS_MOUNT=y
> >>  # CONFIG_STANDALONE is not set
> >>  # CONFIG_PREVENT_FIRMWARE_BUILD is not set
> >>  # CONFIG_FW_LOADER is not set
> >>+CONFIG_SCSI=y
> >>+CONFIG_BLK_DEV_SD=y
> >>  CONFIG_NETDEVICES=y
> >>  # CONFIG_NET_CADENCE is not set
> >>  # CONFIG_NET_VENDOR_BROADCOM is not set
> >>@@ -71,7 +73,14 @@ CONFIG_SERIAL_SH_SCI_NR_UARTS=6
> >>  CONFIG_SERIAL_SH_SCI_CONSOLE=y
> >>  # CONFIG_HW_RANDOM is not set
> >>  # CONFIG_HWMON is not set
> >>-# CONFIG_USB_SUPPORT is not set
> >>+CONFIG_USB=y
> >>+CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
> >>+CONFIG_USB_EHCI_HCD=y
> >>+CONFIG_USB_OHCI_HCD=y
> >>+CONFIG_USB_OHCI_HCD_PLATFORM=y
> >>+CONFIG_USB_EHCI_HCD_PLATFORM=y
> >>+CONFIG_USB_STORAGE=y
> >>+CONFIG_USB_RCAR_PHY=y
> >>
> 
>    Unfortunately, you've made a mistake in this last line of the patch:
> you've truncated it to just "CONFIG_USB_RCAR". :-(
>    Will you correct it?

Sorry about that, I will fix it.

From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 6 Dec 2013 16:48:16 -0500
Subject: [PATCH v2 0/5] Kesytone II USB support
In-Reply-To: <1386187811-9596-1-git-send-email-w-kwok2@ti.com>
References: <1386187811-9596-1-git-send-email-w-kwok2@ti.com>
Message-ID: <52A24620.4060801@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wingman,

On Wednesday 04 December 2013 03:10 PM, WingMan Kwok wrote:
> Here is the updated version of the series which addresses comments from
> earlier version [1].  The PHY register programming is moved to a separate
> PHY driver.
> 
> Series adds USB host support for Keystone SOCs. Keystone SOCs uses dwc3
> hardware IP implementation.  On Keystone II platforms, we use no-op phy driver.
> 
> All three patches are posted together just for completeness. Only first patch
> is expected to go via usb tree and other two via linux-keystone tree.
>
The series looks fine now and probably can be split now.
 
> Patchset are tested on Keystone II EVM with USB2.0 and USB3.0 flash drives.
> 
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> WingMan Kwok (5):
>   usb: dwc3: Add Keystone specific glue layer
>   usb: phy: Add keystone usb phy driver
Please update the minor comments on patch 1 and resubmit above
two patches so that Felipe can pick these up. 

>   ARM: dts: keystone: Add usb phy devicetree bindings
>   ARM: dts: keystone: Add usb devicetree bindings
>   ARM: keystone: defconfig: enable USB support
> 
On the dts part just enable the phy,usb3 nodes from
board dts file and have status disabled in common dts file.
With those update, please repost them and I will take
them in my 3.14 queue.

Regards,
Santosh

From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 16 Jul 2013 11:22:38 +0530
Subject: [PATCH v2 0/4] usb: musb: fix USB enumeration issue in OMAP3
 platform
In-Reply-To: <1373282057-20181-1-git-send-email-kishon@ti.com>
References: <1373282057-20181-1-git-send-email-kishon@ti.com>
Message-ID: <51E4DFA6.2010501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

On Monday 08 July 2013 04:44 PM, Kishon Vijay Abraham I wrote:
> This series fixes the USB enumeration issue caused because of the controller
> not able to get a reference to the PHY because of incorrect binding in the
> board file.
> 
> In the case of non-dt boot, the platform specific initialization file
> (board file) will do usb_bind_phy that binds the usb controller with the
> PHY using device names. After the device names are created using 
> PLATFORM_DEVID_AUTO, our original method of binding by device names doesn't
> work reliably (since the device name changes). Hence the usb controller
> is made to use labels for getting the PHY.
> 
> Here the PHY name is added in the plat data of USB controller device which
> should be used by the controller driver to get the PHY.
> Two new APIs usb_get_phy_by_name and devm_usb_get_phy_by_name are added to
> be used by the controller to get the PHY by name.

You haven't picked this patch series?

-Kishon

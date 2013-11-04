From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 04 Nov 2013 13:26:44 +0100
Subject: [PATCH RFC 1/4] phy: Add new Exynos5 USB 3.0 PHY driver
In-Reply-To: <527744B2.4090303@ti.com>
References: <1383205544-32244-1-git-send-email-gautam.vivek@samsung.com>
 <1383205544-32244-2-git-send-email-gautam.vivek@samsung.com>
 <527744B2.4090303@ti.com>
Message-ID: <1539581.zprt32081v@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

On Monday 04 of November 2013 12:24:42 Kishon Vijay Abraham I wrote:
> Hi Vivek,
> 
> On Thursday 31 October 2013 01:15 PM, Vivek Gautam wrote:
> > Add a new driver for the USB 3.0 PHY on Exynos5 series of SoCs.
> > The new driver uses the generic PHY framework and will interact
> > with DWC3 controller present on Exynos5 series of SoCs.
> 
> In Exynos, you have a single IP that supports both USB3 and USB2 PHY 
> right? I think that needs to be mentioned here.

Nope. There are two separate, different IPs.

> Do you have separate registers that should be used for 
> initializing/powerin_on/powering_off etc.. for usb2 phy and usb3 phy? If 
> so, then you should model this driver as a single driver that supports 
> two PHYs similar to what Sylwester has done before?

Sylwester's MIPI PHY uses such model because it has a single register
that controls both PHYs.

Best regards,
Tomasz

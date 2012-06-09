From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 8 Jun 2012 19:31:19 -0600 (MDT)
Subject: [PATCH 04/11] ARM: OMAP2+: usb_host_fs: add custom reset for
 usb_host_fs (fsusb)
In-Reply-To: <20120608063859.GL12766@atomide.com>
References: <20120607060901.25532.68354.stgit@dusk>
 <20120607061308.25532.19767.stgit@dusk> <20120607073112.GX12766@atomide.com>
 <alpine.DEB.2.00.1206070136550.6684@utopia.booyaka.com>
 <20120607075158.GZ12766@atomide.com>
 <alpine.DEB.2.00.1206070406050.6684@utopia.booyaka.com>
 <20120607105228.GC12766@atomide.com>
 <alpine.DEB.2.00.1206071404470.14977@utopia.booyaka.com>
 <20120608063859.GL12766@atomide.com>
Message-ID: <alpine.DEB.2.00.1206081929000.23401@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Jun 2012, Tony Lindgren wrote:

> Oh OK yeah makes sense as that's hwmod internal function. Then the driver
> specific part should use just void __iomem *base and use readl/writel and
> live under include/linux/platform_data/omap-usb.h.

This sounds like something that might be flame-bait, since these functions 
aren't platform_data.

How about putting these functions in arch/arm/plat-omap/include/plat?  
Drivers are able to include those files easily.


- Paul

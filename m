From: mporter@ti.com (Matt Porter)
Date: Wed, 3 Oct 2012 11:00:58 -0400
Subject: [PATCH v2 0/7] uio_pruss cleanup and platform support
In-Reply-To: <1348861072-14507-1-git-send-email-mporter@ti.com>
References: <1348861072-14507-1-git-send-email-mporter@ti.com>
Message-ID: <20121003150058.GB11180@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2012 at 03:37:45PM -0400, Matt Porter wrote:
> Changes since v1:
> 	- Replaced uio_pruss private SRAM API use with genalloc
> 	- Added DA850 platform device and clock support
> 	- Added DA850 L3 RAM gen_pool support
> 	- Split out DT binding
> 
> This series enables uio_pruss on both DA850 and AM33xx. The driver
> previously was not enabled by any platform and the private SRAM API
> was accessing an invalid SRAM bank for use on DA850. For AM33xx,
> DT, pinctrl, and runtime PM support are added since AM33xx only
> boots via DT.

I'm dropping AM33xx/OMAP support from v3 for this series since the
focus has turned to fixing Davinci SRAM to provide genalloc support
and the associated use of that in the driver.

I'll have a separate series with AM33xx support since dealing cleanly
with external resets on OMAP is a bigger issue.

-Matt

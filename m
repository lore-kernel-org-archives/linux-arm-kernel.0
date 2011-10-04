From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 4 Oct 2011 13:00:26 +0200
Subject: [PATCH 18/30] omap-usb: automatically select MFD_OMAP_USB_HOST
In-Reply-To: <1317566760-25681-19-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-19-git-send-email-arnd@arndb.de>
Message-ID: <20111004110026.GZ4118@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Sun, Oct 02, 2011 at 04:45:48PM +0200, Arnd Bergmann wrote:
> The ehci-omap and ohci-omap3 drivers both depend on the
> omap-usb-host MFD support driver. By default, this is
> automatically turned on, but it is possible to disable
> the driver, which results in a link error.
I don't see the Kconfig entry for e.g. the ohci-omap3 driver, but shouldn't
the dependency be handled there ?
If ohci-omap3 depends on omap-usb-host, then we should not be able to disable
the latter while the former is selected.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/

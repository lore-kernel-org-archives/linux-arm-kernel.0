From: david.a.cohen@linux.intel.com (David Cohen)
Date: Tue, 17 Dec 2013 15:31:40 -0800
Subject: [PATCH 0/7] usb: dwc3: pm_runtime implementation
In-Reply-To: <1386884325-11440-1-git-send-email-balbi@ti.com>
References: <1386884325-11440-1-git-send-email-balbi@ti.com>
Message-ID: <20131217233140.GA21267@psi-dev26.jf.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 03:38:38PM -0600, Felipe Balbi wrote:
> hi all,
> 
> these patches add pm_runtime support for all glue layers.
> 
> I plan to add pm_runtime support for dwc3 after these
> patches are merged upstream.
> 
> Please test.

At first time I failed to notice you were removing #ifdef's around pm
callback functions. Instead of saying DWC3 will start to have warnings
when CONFIG_PM is not selected, I'd say your patch set is now a
dependence of my RFC :)
https://lkml.org/lkml/2013/12/13/4

Br, David Cohen

> 
> Felipe Balbi (7):
>   usb: dwc3: keystone: add basic PM support
>   usb: dwc3: omap: add basic pm_runtime support
>   usb: dwc3: pci: add pm_runtime support
>   usb: dwc3: omap: fix pm_runtime usage
>   usb: dwc3: omap: fix order of pm_runtime vs child removal
>   usb: dwc3: exynos: remove DEV_PM_OPS hackery
>   usb: dwc3: exynos: add pm_runtime support
> 
>  drivers/usb/dwc3/dwc3-exynos.c   | 73 +++++++++++++++++++++++-------
>  drivers/usb/dwc3/dwc3-keystone.c | 97 ++++++++++++++++++++++++++++++++++++++--
>  drivers/usb/dwc3/dwc3-omap.c     | 45 +++++++++++++++----
>  drivers/usb/dwc3/dwc3-pci.c      | 66 ++++++++++++++++++++-------
>  4 files changed, 239 insertions(+), 42 deletions(-)
> 
> -- 
> 1.8.4.GIT
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: balbi@ti.com (Felipe Balbi)
Date: Mon, 19 Nov 2012 22:14:54 +0200
Subject: [PATCH 119/493] usb: remove use of __devexit_p
In-Reply-To: <1353349642-3677-119-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-119-git-send-email-wfp5p@virginia.edu>
Message-ID: <20121119201454.GA24309@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 19, 2012 at 01:21:08PM -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> needed.
> 
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Peter Korsgaard <jacmet@sunsite.dk> 
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com> 
> Cc: Felipe Balbi <balbi@ti.com> 
> Cc: Li Yang <leoli@freescale.com> 
> Cc: Alan Stern <stern@rowland.harvard.edu> 
> Cc: Wan ZongShun <mcuos.com@gmail.com> 
> Cc: Ben Dooks <ben-linux@fluff.org> 
> Cc: Kukjin Kim <kgene.kim@samsung.com> 
> Cc: linux-usb at vger.kernel.org 
> Cc: linux-omap at vger.kernel.org 
> Cc: linuxppc-dev at lists.ozlabs.org 
> Cc: linux-arm-kernel at lists.infradead.org 
> Cc: linux-samsung-soc at vger.kernel.org 
> ---
>  drivers/usb/c67x00/c67x00-drv.c      | 2 +-
>  drivers/usb/chipidea/ci13xxx_imx.c   | 2 +-
>  drivers/usb/chipidea/ci13xxx_msm.c   | 2 +-
>  drivers/usb/chipidea/ci13xxx_pci.c   | 2 +-
>  drivers/usb/chipidea/core.c          | 2 +-
>  drivers/usb/chipidea/usbmisc_imx6q.c | 2 +-
>  drivers/usb/dwc3/core.c              | 2 +-
>  drivers/usb/dwc3/dwc3-exynos.c       | 2 +-
>  drivers/usb/dwc3/dwc3-omap.c         | 2 +-
>  drivers/usb/dwc3/dwc3-pci.c          | 2 +-
>  drivers/usb/gadget/bcm63xx_udc.c     | 2 +-
>  drivers/usb/gadget/fsl_qe_udc.c      | 2 +-
>  drivers/usb/gadget/hid.c             | 2 +-
>  drivers/usb/gadget/lpc32xx_udc.c     | 2 +-
>  drivers/usb/gadget/net2272.c         | 4 ++--
>  drivers/usb/gadget/omap_udc.c        | 2 +-
>  drivers/usb/gadget/s3c-hsotg.c       | 2 +-
>  drivers/usb/host/bcma-hcd.c          | 2 +-
>  drivers/usb/host/ehci-atmel.c        | 2 +-
>  drivers/usb/host/ehci-msm.c          | 2 +-
>  drivers/usb/host/ehci-platform.c     | 2 +-
>  drivers/usb/host/ehci-s5p.c          | 2 +-
>  drivers/usb/host/ehci-w90x900.c      | 2 +-
>  drivers/usb/host/fhci-hcd.c          | 2 +-
>  drivers/usb/host/fsl-mph-dr-of.c     | 2 +-
>  drivers/usb/host/isp1362-hcd.c       | 2 +-
>  drivers/usb/host/isp1760-if.c        | 2 +-
>  drivers/usb/host/ohci-at91.c         | 2 +-
>  drivers/usb/host/ohci-exynos.c       | 2 +-
>  drivers/usb/host/ohci-jz4740.c       | 2 +-
>  drivers/usb/host/ohci-omap3.c        | 2 +-
>  drivers/usb/host/ohci-platform.c     | 2 +-
>  drivers/usb/host/ohci-s3c2410.c      | 2 +-
>  drivers/usb/host/ohci-tmio.c         | 2 +-
>  drivers/usb/host/r8a66597-hcd.c      | 2 +-
>  drivers/usb/host/sl811-hcd.c         | 2 +-
>  drivers/usb/host/ssb-hcd.c           | 2 +-
>  drivers/usb/host/u132-hcd.c          | 2 +-
>  drivers/usb/musb/am35x.c             | 2 +-
>  drivers/usb/musb/da8xx.c             | 2 +-
>  drivers/usb/musb/davinci.c           | 2 +-
>  drivers/usb/musb/musb_core.c         | 2 +-
>  drivers/usb/musb/musb_dsps.c         | 2 +-
>  drivers/usb/musb/omap2430.c          | 2 +-
>  drivers/usb/musb/tusb6010.c          | 2 +-
>  drivers/usb/musb/ux500.c             | 2 +-
>  drivers/usb/otg/ab8500-usb.c         | 2 +-
>  drivers/usb/otg/fsl_otg.c            | 2 +-
>  drivers/usb/otg/msm_otg.c            | 2 +-
>  drivers/usb/otg/mxs-phy.c            | 2 +-
>  drivers/usb/otg/nop-usb-xceiv.c      | 2 +-
>  drivers/usb/phy/mv_u3d_phy.c         | 2 +-
>  drivers/usb/phy/omap-usb2.c          | 2 +-
>  drivers/usb/phy/rcar-phy.c           | 2 +-
>  drivers/usb/renesas_usbhs/common.c   | 2 +-
>  55 files changed, 56 insertions(+), 56 deletions(-)

For drivers/usb/gadget, drivers/usb/dwc3/, drivers/usb/musb/,
drivers/usb/otg/, drivers/usb/phy, and drivers/usb/renesas_usbhs:

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121119/76682349/attachment.sig>

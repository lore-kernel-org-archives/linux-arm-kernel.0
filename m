From: nava.manne@xilinx.com (Nava kishore Manne)
Date: Fri, 2 Sep 2016 06:02:14 +0000
Subject: [PATCH v5] Axi-usb: Add support for 64-bit addressing.
In-Reply-To: <20160901175636.GV16583@xsjsorenbubuntu>
References: <1472719976-25410-1-git-send-email-navam@xilinx.com>
 <20160901175636.GV16583@xsjsorenbubuntu>
Message-ID: <C89496FEAE474D468F30D558A9468D9F26D143CB@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Soren,

        Thanks for the review....

> -----Original Message-----
> From: S?ren Brinkmann [mailto:soren.brinkmann at xilinx.com]
> Sent: Thursday, September 01, 2016 11:27 PM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: robh+dt at kernel.org; pawel.moll at arm.com; mark.rutland at arm.com;
> ijc+devicetree at hellion.org.uk; galak at codeaurora.org; balbi at kernel.org;
> gregkh at linuxfoundation.org; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org; linux-
> usb at vger.kernel.org; Nava kishore Manne <navam@xilinx.com>
> Subject: Re: [PATCH v5] Axi-usb: Add support for 64-bit addressing.
>
> On Thu, 2016-09-01 at 14:22:56 +0530, Nava kishore Manne wrote:
> > This patch updates the driver to support 64-bit DMA addressing.
> >
> > Signed-off-by: Nava kishore Manne <navam@xilinx.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> > Changes for v5:
> >                 -None.
> >
> > Changes for v4:
> >                 -Used boolen property insted of addrwith property in the DT
> >                  as suggested by Arnd Bergmann.
> >                 -Adopt the DT relevant changes into the driver.
> >
> > Changes for v3:
> >                 -Added new compatable string for 5.00 IP version as suggested by
> >                  Arnd Bergmann.
> >                 -Used write_fn() insted of lo_hi_writeq() as suggested by
> >                  Arnd Bergmann.
> > Changes for v2:
> >                 -Added dma-ranges property in device tree as suggested by
> >                  Arnd Bergmann.
> >                 -Modified the driver code based on the xlnx,addrwidth.
> >
> >  .../devicetree/bindings/usb/udc-xilinx.txt         |  5 ++-
> >  drivers/usb/gadget/udc/udc-xilinx.c                | 52
> +++++++++++++++++++++-
> >  2 files changed, 54 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/udc-xilinx.txt
> > b/Documentation/devicetree/bindings/usb/udc-xilinx.txt
> > index 47b4e39..d08d972 100644
> > --- a/Documentation/devicetree/bindings/usb/udc-xilinx.txt
> > +++ b/Documentation/devicetree/bindings/usb/udc-xilinx.txt
> > @@ -1,12 +1,14 @@
> >  Xilinx USB2 device controller
> >
> >  Required properties:
> > -- compatible               : Should be "xlnx,usb2-device-4.00.a"
> > +- compatible               : Should be "xlnx,usb2-device-4.00.a" or
> > +                     "xlnx,usb2-device-5.00"
> >  - reg                      : Physical base address and size of the USB2
> >                       device registers map.
> >  - interrupts               : Should contain single irq line of USB2 device
> >                       controller
> >  - xlnx,has-builtin-dma     : if DMA is included
> > +- xlnx,has-64bit-dma       : if DMA is included 64-bit addressing support.
>
> We add these properties to describe the IP configuration + we have the
> version indicator in the compatible string. Do we really need both? It seems
> that all versions use the same driver and differentiation is made through the
> DT properties that describe the IP configuration parameters.
> Wouldn't it be better to just have one generic 'xlnx,axi-usb2' (or
> whatever) compatible string instead of patching the driver for each new
> version without really needing to differentiate the IP versions through it?
>
I think matching on the version number is slightly better, as we have the version
Already and it identifies the 64-bit  registers existence.

Regards,
Navakishore


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

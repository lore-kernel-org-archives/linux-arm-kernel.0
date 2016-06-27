From: nava.manne@xilinx.com (Nava kishore Manne)
Date: Mon, 27 Jun 2016 12:47:35 +0000
Subject: [PATCH v4] Axi-usb: Add support for 64-bit addressing.
In-Reply-To: <20160602225815.GA5508@rob-hp-laptop>
References: <1464626798-1334-1-git-send-email-navam@xilinx.com>
 <20160602225815.GA5508@rob-hp-laptop>
Message-ID: <C89496FEAE474D468F30D558A9468D9F26CF4FCD@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping!!

> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: Friday, June 03, 2016 4:28 AM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: pawel.moll at arm.com; mark.rutland at arm.com;
> ijc+devicetree at hellion.org.uk; galak at codeaurora.org; Michal Simek
> <michals@xilinx.com>; Soren Brinkmann <sorenb@xilinx.com>;
> balbi at ti.com; gregkh at linuxfoundation.org; Hyun Kwon
> <hyunk@xilinx.com>; Nava kishore Manne <navam@xilinx.com>; Radhey
> Shyam Pandey <radheys@xilinx.com>; devicetree at vger.kernel.org; linux-
> arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v4] Axi-usb: Add support for 64-bit addressing.
> 
> On Mon, May 30, 2016 at 10:16:38PM +0530, Nava kishore Manne wrote:
> > This patch updates the driver to support 64-bit DMA addressing.
> >
> > Signed-off-by: Nava kishore Manne <navam@xilinx.com>
> > ---
> > Changes for v4:
> > 		-Used boolen property insted of addrwith property in the DT
> > 		 as suggested by Arnd Bergmann.
> > 		-Adopt the DT relevant changes into the driver.
> >
> > Changes for v3:
> >                 -Added new compatable string for 5.00 IP version as suggested by
> >                  Arnd Bergmann.
> >                 -Used write_fn() insted of lo_hi_writeq() as suggested by
> >                  Arnd Bergmann.
> >
> > Changes for v2:
> >                 -Added dma-ranges property in device tree as suggested by Arnd
> Bergmann.
> >                 -Modified the driver code based on the xlnx,addrwidth.
> >
> >  .../devicetree/bindings/usb/udc-xilinx.txt         |  5 ++-
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
> >  drivers/usb/gadget/udc/udc-xilinx.c                | 52
> +++++++++++++++++++++-
> >  2 files changed, 54 insertions(+), 3 deletions(-)

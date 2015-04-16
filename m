From: Minghuan.Lian@freescale.com (Minghuan.Lian at freescale.com)
Date: Thu, 16 Apr 2015 01:15:17 +0000
Subject: [PATCH] irqchip/gicv3-its: Decrease page size when needed
In-Reply-To: <8ba82758f57122dd360b2e6fac8040fc@www.loen.fr>
References: <1429091364-31939-1-git-send-email-Minghuan.Lian@freescale.com>
 <20150415115118.GN18660@io.lakedaemon.net>
 <8ba82758f57122dd360b2e6fac8040fc@www.loen.fr>
Message-ID: <DM2PR0301MB06407F457016250193B6E9D3E2E40@DM2PR0301MB0640.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

OK, I will follow your comment.

Thanks,
Minghuan

> -----Original Message-----
> From: Marc Zyngier [mailto:marc.zyngier at arm.com]
> Sent: Wednesday, April 15, 2015 10:17 PM
> To: Jason Cooper; Lian Minghuan-B31939
> Cc: Arnd Bergmann; linux-pci at vger.kernel.org; Hu Mingkai-B21284; Zang
> Roy-R61911; Yoder Stuart-B08248; Wood Scott-B07421; Bjorn Helgaas; linux-
> arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] irqchip/gicv3-its: Decrease page size when needed
> 
> On 2015-04-15 12:51, Jason Cooper wrote:
> > Minghuan Lian,
> >
> > On Wed, Apr 15, 2015 at 05:49:22PM +0800, Minghuan Lian wrote:
> >> The default page size of ITS table has been changed to 64KB, but for
> >> some platforms the real size of allocate memory which calculated by
> >> DEVBITS of register GITS_TYPER may smaller than default size. In this
> >> case, psz must be decreased, otherwise, the wrong page number will
> >> cause kernel hang.
> >>
> >> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> >> ---
> >>  drivers/irqchip/irq-gic-v3-its.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >
> > Please run scripts/get_maintainer.pl on your patches before sending.
> > This
> > needs to be sent to myself and Thomas Gleixner for review.
> 
> Please also CC me on anything that touches GICv3 or the ITS code.
> 
> Thanks,
> 
>          M.
> --
> Fast, cheap, reliable. Pick two.

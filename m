From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 27 Oct 2016 15:18:54 +0100
Subject: [PATCH 1/6] dt/bindings: adjust bindings for Layerscape SCFG MSI
In-Reply-To: <DB4PR04MB07813D4DA5D5567229394A7D8FAB0@DB4PR04MB0781.eurprd04.prod.outlook.com>
References: <1477398945-22774-1-git-send-email-Minghuan.Lian@nxp.com>
 <20161026103101.GC19965@leverpostej>
 <DB4PR04MB07813D4DA5D5567229394A7D8FAB0@DB4PR04MB0781.eurprd04.prod.outlook.com>
Message-ID: <20161027141826.GC30535@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 26, 2016 at 10:09:07PM +0000, Leo Li wrote:
> 
> > -----Original Message-----
> > From: Mark Rutland [mailto:mark.rutland at arm.com]
> > Sent: Wednesday, October 26, 2016 5:31 AM
> > To: M.H. Lian <minghuan.lian@nxp.com>
> > Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> > devicetree at vger.kernel.org; Marc Zyngier <marc.zyngier@arm.com>; Stuart
> > Yoder <stuart.yoder@nxp.com>; Leo Li <leoyang.li@nxp.com>; Scott Wood
> > <scott.wood@nxp.com>; Shawn Guo <shawnguo@kernel.org>; Mingkai Hu
> > <mingkai.hu@nxp.com>
> > Subject: Re: [PATCH 1/6] dt/bindings: adjust bindings for Layerscape SCFG MSI
> > 
> > On Tue, Oct 25, 2016 at 08:35:40PM +0800, Minghuan Lian wrote:

> > > -- compatible: should be "fsl,<soc-name>-msi" to identify
> > > -	      Layerscape PCIe MSI controller block such as:
> > > -              "fsl,1s1021a-msi"
> > > -              "fsl,1s1043a-msi"
> > > +- compatible: should be "fsl,ls-scfg-msi"
> > 
> > This breaks old DTBs, and throws away information which you describe above as
> > valuable. So another NAK for that.
> 
> I agree with you that we should maintain the backward compatibility.
> But on the other hand, I just found that there is a silly typo in the
> original binding that "ls" is wrongly spelled as "1s" and they look
> too close to be noticed in previous patch reviews.  :(

Sure, that's annoying, but we're stuck with it.

> The driver and all the DTSes used the binding with the typo which
> covered up the problem.  So even if we want to keep the
> "fsl,<soc-name>-msi" binding, we probably want to fix the typo, right?
> And that breaks the backward compatibility too.

Regardless of what we do, we should *not* break compatibility. The old
strings must remain.

However, we can *add* correctly-spelt variants, and mark the existing
strings as deprecated (in both the binding and driver). The in-kernel
dts can be updated to use the correctly-spelt strings.

Thanks,
Mark.

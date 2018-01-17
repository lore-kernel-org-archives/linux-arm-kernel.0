From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 17 Jan 2018 17:16:57 +0100
Subject: [PATCH 3/8] staging: fsl-mc: Add SPDX license identifiers
In-Reply-To: <VI1PR0402MB36641599B3ADF70F23C0BF20EAE90@VI1PR0402MB3664.eurprd04.prod.outlook.com>
References: <1516108750-24938-1-git-send-email-bogdan.purcareata@nxp.com>
 <1516108750-24938-4-git-send-email-bogdan.purcareata@nxp.com>
 <20180116151312.GA1174@kroah.com>
 <VI1PR0402MB36641599B3ADF70F23C0BF20EAE90@VI1PR0402MB3664.eurprd04.prod.outlook.com>
Message-ID: <20180117161657.GA7837@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 03:56:19PM +0000, Bogdan Purcareata wrote:
> > -----Original Message-----
> > From: Greg KH [mailto:gregkh at linuxfoundation.org]
> > Sent: Tuesday, January 16, 2018 5:13 PM
> > To: Bogdan Purcareata <bogdan.purcareata@nxp.com>
> > Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>; Ruxandra Ioana Ciocoi Radulescu
> > <ruxandra.radulescu@nxp.com>; devel at driverdev.osuosl.org; robh at kernel.org;
> > stuyoder at gmail.com; arnd at arndb.de; marc.zyngier at arm.com; Roy Pledge
> > <roy.pledge@nxp.com>; Ioana Ciornei <ioana.ciornei@nxp.com>; linux-
> > kernel at vger.kernel.org; Horia Geant? <horia.geanta@nxp.com>; Nipun Gupta
> > <nipun.gupta@nxp.com>; tglx at linutronix.de; linux-arm-
> > kernel at lists.infradead.org; jason at lakedaemon.net
> > Subject: Re: [PATCH 3/8] staging: fsl-mc: Add SPDX license identifiers
> > 
> > On Tue, Jan 16, 2018 at 03:19:05PM +0200, Bogdan Purcareata wrote:
> > > diff --git a/drivers/staging/fsl-mc/bus/dpbp-cmd.h b/drivers/staging/fsl-
> > mc/bus/dpbp-cmd.h
> > > index 5904836..1ac8ec6 100644
> > > --- a/drivers/staging/fsl-mc/bus/dpbp-cmd.h
> > > +++ b/drivers/staging/fsl-mc/bus/dpbp-cmd.h
> > > @@ -1,33 +1,8 @@
> > > +/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
> > 
> > Hm, I don't think you want to do that.  How can a Linux driver subsytem
> > that wraps calls to the kernel's driver core (which are GPL-only), be
> > accessed by BSD-3 code?
> 
> For this particular file, the original license was dual GPL/BSD. The
> patch removes the license text and adds an equivalent SPDX tag.

Argh, I picked the wrong file. Ment to pick the fsl-mc-bus.c file, which
you also marked with a dual license, despite it not having that before.
Sorry for that confusion.

> > If I didn't know any better, I would think you were trying to create a
> > "GPL Condom" here :)
> > 
> > Anyway, why all of the BSD-3 stuff here?  That makes no sense for kernel
> > code at all, and this is a relicensing of the file, have you gotten
> > legal approval of everyone that has modified the file while it was under
> > the GPL-v2 only text to be able to change it to BSD-3 as well?
> 
> Previous to this patch, the files under drivers/staging/fsl-mc/ use a combination of GPL-2.0 and (GPL-2.0+ / BSD-3-Clause) licenses (expressed by the full license text). 
> 
> The original intent was to have an uniform dual license for all files. Before making this change, I have consulted the other current contributors, but based on your feedback, we think it's best to keep the current licenses.

Thank you.

Also you can have a few free '\n' characters for your email editor :)

> > Careful, this is a _VERY_ tricky thing to do right.  I need a
> > signed-off-by on this type of patch from your legal council to ensure
> > that they know exactly what you are doing, and have reviewed it
> > properly, before I can take it.
> > 
> > Hint, stick to the existing license in the files, it makes more sense,
> > you are not going to be taking this code out of Linux and putting it
> > anywhere.
> 
> I will send a v2 keeping the existing license for each file - removing the full license text and adding a SPDX tag. This way there will be no change from a legal standpoint.

That's great, thanks.

greg k-h

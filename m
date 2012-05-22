From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 22 May 2012 09:41:59 +0800
Subject: [PATCH v2 00/12] add imx usb driver for mx28/6x
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803BB2B2F@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <201205212141.52171.marex@denx.de> <4FBA9BE4.7020303@grid-net.com>
 <201205212207.34978.marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803BB2B2F@039-SN2MPN1-023.039d.mgd.msft.net>
Message-ID: <20120522014158.GF6206@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2012 at 09:38:33AM +0800, Chen Peter-B29397 wrote:
>  
> > > >
> > > >> Hi Richard,
> > > >>
> > > >> On Mon, May 21, 2012 at 6:23 AM, Richard Zhao
> > > >>
> > > >> <richard.zhao@freescale.com>  wrote:
> > > >>> The work is based on  ci13xxx rework done by Alexander Shishkin.
> > > >>>
> > > >>> Status:
> > > >>>   - this version only support host
> > > >>>   - usbotg controler works at host role
> > > >>>
> > > >>> Changes since V1:
> > > >>>   - Merge the work of Marek
> > > >>>   - re-implement connect change notify
> > > >>>   - imx6q: move part of code to clk
> > > >>>   - imx6q: add config-on-boot gpios
> > > >>
> > > >> Can you please also add the driver into the defconfig files?
> > > >>
> > > >> What about the existing USB host drivers for
> > mx27/mx31/mx35/mx25/mx35?
> > > >>
> > > >> Is the idea to switch to drivers/usb/chipidea/host.c too?
> > > >
> > > > I think the core is the same, it's just the ci13xxx-imx driver that'd
> > > > need to be written differently for these
> > >
> > > So that means driver that you did are not going to be up streamed for
> > > mx28/mxs? And those interested should be tracking this patch set?
> > 
> > This here is definitelly going to support mx28 and I'm slowly working
> > through
> > the DT stuff to test this, all right?
> > 
> > We were talking about imx.{xz|x,y is [0-9a-z]} \ imx.{23,28,6q}
> >
> This driver needs to work on both DT and non-DT support.
> Let's do it after next version when we need to add it for old mxc platform.
I don't think so. We only need to go right direction and don't do
extra work for what is going to be abandoned.

Thanks
Richard
> 
>  
> > >
> > > -Subodh
> > 
> > Best regards,
> > Marek Vasut
> 

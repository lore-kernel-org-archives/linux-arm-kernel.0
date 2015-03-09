From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 09 Mar 2015 22:54:36 +0100
Subject: [PATCH 1/5] soc: mediatek: Add SMI driver
In-Reply-To: <1425923977.2317.4.camel@tiscali.nl>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
 <1425902271.13300.18.camel@mhfsdcap03> <1425923977.2317.4.camel@tiscali.nl>
Message-ID: <57664636.GGm8GTyWMF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 March 2015 18:59:37 Paul Bolle wrote:
> Hi Yong,
> 
> Yong Wu schreef op ma 09-03-2015 om 19:57 [+0800]:
> > On Fri, 2015-03-06 at 12:30 +0100, Paul Bolle wrote:
> > > On Fri, 2015-03-06 at 18:48 +0800, yong.wu at mediatek.com wrote:
> > > > --- a/drivers/soc/mediatek/Kconfig
> > > > +++ b/drivers/soc/mediatek/Kconfig
> > > > @@ -20,3 +20,10 @@ config MT8173_PMIC_WRAP
> > > >  	  PMIC wrapper is a proprietary hardware in MT8173 to make
> > > >  	  communication protocols to access PMIC device.
> > > >  	  This driver implement access protocols for MT8173.
> > > > +
> > > > +config MTK_SMI
> > > > +        bool
> > > 
> > > Nit: make this one tab instead of 8 spaces, please.
> > > 
> > > > +	help
> > > > +	  Smi help enable/disable iommu in mt8173 and control the
> > > > +	  clock of each local arbiter.
> > > > +	  It should be true while MTK_IOMMU enable.
> > > 
> > > I don't think anyone using the *config tools will ever see this text, as
> > > there's no prompt. So you might as well make this a comment or drop it
> > > altogether.
> > > 
> >      We could search it in the tool even though we don't see it. In next
> > version, I will try to make it a comment.

No, please leave it the way it was. I prefer having help texts even
for silent options over using comments to do the same.

	Arnd

From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 17 Sep 2012 11:57:19 +0100
Subject: [PATCH v4 12/24] xen/arm: introduce CONFIG_XEN on ARM
In-Reply-To: <505374E2.5080308@mvista.com>
References: <alpine.DEB.2.02.1209141145150.29232@kaball.uk.xensource.com>
 <1347621207-11294-12-git-send-email-stefano.stabellini@eu.citrix.com>
 <505374E2.5080308@mvista.com>
Message-ID: <alpine.DEB.2.02.1209171155010.29232@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 14 Sep 2012, Sergei Shtylyov wrote:
> Hello.
> 
> On 09/14/2012 03:13 PM, Stefano Stabellini wrote:
> 
> > Changes in v2:
> 
> > - mark Xen guest support on ARM as EXPERIMENTAL.
> 
> > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > ---
> >  arch/arm/Kconfig |   10 ++++++++++
> >  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 2f88d8d..e92518d 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1897,6 +1897,16 @@ config DEPRECATED_PARAM_STRUCT
> >  	  This was deprecated in 2001 and announced to live on for 5 years.
> >  	  Some old boot loaders still use this way.
> >  
> > +config XEN_DOM0
> > +	def_bool y
> > +
> > +config XEN
> > +	bool "Xen guest support on ARM (EXPERIMENTAL)"
> > +	depends on EXPERIMENTAL && ARM && OF
> > +	select XEN_DOM0
> 
>    What's the point of selecting it if it's always "y"?

That's because on X86 is not always "y": there are things under
drivers/xen that compile on both platforms and depend on XEN_DOM0.

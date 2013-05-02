From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Thu, 2 May 2013 14:13:09 -0400
Subject: [PATCH, RFC 18/22] Xen: SWIOTLB is only used on x86
In-Reply-To: <alpine.DEB.2.02.1305021638100.5398@kaball.uk.xensource.com>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
 <1367507786-505303-19-git-send-email-arnd@arndb.de>
 <alpine.DEB.2.02.1305021638100.5398@kaball.uk.xensource.com>
Message-ID: <20130502181309.GA23642@phenom.dumpdata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 02, 2013 at 04:38:50PM +0100, Stefano Stabellini wrote:
> On Thu, 2 May 2013, Arnd Bergmann wrote:
> > Enabling SWIOTLB_XEN on ARM results in build errors because the
> > underlying SWIOTLB is only available on X86:
> > 
> > drivers/xen/swiotlb-xen.c: In function 'is_xen_swiotlb_buffer':
> > drivers/xen/swiotlb-xen.c:105:2: error: implicit declaration of function 'mfn_to_local_pfn
> > 
> > Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Acked as well. Should I pull this in or Arnd are you OK with taking
with my our Acks?

Thanks.
> 
> 
> >  drivers/xen/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> > index dd4d9cb..f03bf50 100644
> > --- a/drivers/xen/Kconfig
> > +++ b/drivers/xen/Kconfig
> > @@ -141,7 +141,7 @@ config XEN_GRANT_DEV_ALLOC
> >  
> >  config SWIOTLB_XEN
> >  	def_bool y
> > -	depends on PCI
> > +	depends on PCI && X86
> >  	select SWIOTLB
> >  
> >  config XEN_TMEM
> > -- 
> > 1.8.1.2
> > 

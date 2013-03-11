From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 11 Mar 2013 16:11:33 +0100
Subject: [PATCH v8 3/7] ARM: davinci: Add support for configuring
 DA8XX_REMOTEPROC
In-Reply-To: <513DC4A1.8020700@ti.com>
References: <1362782508-3166-1-git-send-email-rtivy@ti.com>
 <1362782508-3166-4-git-send-email-rtivy@ti.com> <513DC4A1.8020700@ti.com>
Message-ID: <1363014693.3137.88.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-03-11 at 17:18 +0530, Sekhar Nori wrote:
> On 3/9/2013 4:11 AM, Robert Tivy wrote:
> > diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> > index 96ce101..21d04f1 100644
> > --- a/drivers/remoteproc/Kconfig
> > +++ b/drivers/remoteproc/Kconfig
> > @@ -5,7 +5,7 @@ config REMOTEPROC
> >  	tristate
> >  	depends on EXPERIMENTAL
> >  	depends on HAS_DMA
> > -	select FW_CONFIG
> > +	select FW_LOADER
> >  	select VIRTIO
> >  
> >  config OMAP_REMOTEPROC

This fixes the typo introduced in the typo introduced in (one line)
commit e121aefa7d9f10eee5cf26ed47129237a05d940b ("remoteproc: fix
missing CONFIG_FW_LOADER configurations"). That seems a separate issue.
Can't it be submitted as a separate (one line) patch? 

That would probably make it easier to get it into stable. Ohad has
already stated that this would be a good idea.


Paul Bolle

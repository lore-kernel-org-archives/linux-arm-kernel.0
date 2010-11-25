From: jimmy.rubin@stericsson.com (Jimmy RUBIN)
Date: Thu, 25 Nov 2010 08:16:38 +0100
Subject: [PATCH 07/10] MCDE: Add display subsystem framework
In-Reply-To: <201011121738.53536.arnd@arndb.de>
References: <1289390653-6111-1-git-send-email-jimmy.rubin@stericsson.com>
	<1289390653-6111-7-git-send-email-jimmy.rubin@stericsson.com>
	<1289390653-6111-8-git-send-email-jimmy.rubin@stericsson.com>
	<201011121738.53536.arnd@arndb.de>
Message-ID: <F45880696056844FA6A73F415B568C695365D85C41@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> > +struct kobj_type ovly_type = {
> > +	.release = overlay_release,
> > +};
> 
> You certainly should not define a new kobj_type for use in a device
> driver.
> This is an internal data structure of the linux core code. It might
> make
> sense if you were trying to become the new frame buffer layer
> maintainer
> and rewrite all the existing drivers to be based on the concept of
> overlays, but even then there is probably a better way.
> 
> Maybe you were thinking of using kref instead of kobj?
> 

Good point, I looked at kref and that is what we want to do.

> > +int __init mcde_dss_init(void)
> > +{
> > +	return 0;
> > +}
> > +
> > +void mcde_dss_exit(void)
> > +{
> > +}
> 
> If they don't do anything, don't define them.
> 
Agree, will remove them

/Jimmy

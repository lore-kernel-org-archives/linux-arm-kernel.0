From: nm@ti.com (Nishanth Menon)
Date: Thu, 28 Jul 2011 00:53:47 -0500
Subject: [RFC/PATCH 2/7] OMAP3: beagle: don't touch omap_device internals
In-Reply-To: <20110722085716.GI32058@legolas.emea.dhcp.ti.com>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
	<1311292338-11830-4-git-send-email-khilman@ti.com>
	<20110722085716.GI32058@legolas.emea.dhcp.ti.com>
Message-ID: <20110728055346.GA11921@foobar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11:57-20110722, Felipe Balbi wrote:
[...]
> >  	/* Custom OPP enabled for all xM versions */
> >  	if (cpu_is_omap3630()) {
> > -		struct omap_hwmod *mh = omap_hwmod_lookup("mpu");
> > -		struct omap_hwmod *dh = omap_hwmod_lookup("iva");
> > -		struct device *dev;
> > +		struct device *mpu_dev, *iva_dev;
> >  
> > -		if (!mh || !dh) {
> > +		mpu_dev = omap2_get_mpuss_device();
> > +		iva_dev = omap2_get_iva_device();
> 
> out of curiosity again, nothing to do with this patch.
> 
> Maybe it would be nicer to have an api such as:
> 
> omap2_get_device(name);
> 
> there are already four devices to be gotten, if that number grows any
> bigger, so will the number of helper functions.
I agree, in fact, on a different topic, I hit the same requirement
here is the patch I had done:

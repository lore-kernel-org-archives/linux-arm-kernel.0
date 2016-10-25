From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 25 Oct 2016 16:16:39 +0200
Subject: [PATCH v5 1/7] drm: sunxi: Add a basic DRM driver for Allwinner
 DE2
In-Reply-To: <20161025064422.4jua6qmpr7zu3ijt@phenom.ffwll.local>
References: <cover.1477142934.git.moinejf@free.fr>
 <8afc5e020c5767face34fe3a9ab300ce9e67ba00.1477142934.git.moinejf@free.fr>
 <20161025064422.4jua6qmpr7zu3ijt@phenom.ffwll.local>
Message-ID: <20161025161639.0131598a07b79f42ce5829c6@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Oct 2016 08:44:22 +0200
Daniel Vetter <daniel@ffwll.ch> wrote:

> > +	/* start the subdevices */
> > +	ret = component_bind_all(dev, drm);
> > +	if (ret < 0)
> > +		goto out2;
> > +
> > +	ret = drm_dev_register(drm, 0);
> 
> This needs to be the very last step in your driver load sequence.
> Kerneldoc explains why. Similar, but inverted for unloading:
> drm_dev_unregister is the very first thing you must call.

Thanks, and also for embedding the drm device.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/

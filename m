From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Wed, 10 Nov 2010 23:09:11 +0530
Subject: [PATCH v3 02/13] OMAP: DMA: Introduce errata handling feature
In-Reply-To: <87hbfpcfh6.fsf@deeprootsystems.com>
References: <1288099513-1854-1-git-send-email-manjugk@ti.com>
	<1288099513-1854-3-git-send-email-manjugk@ti.com>
	<87sjzakuxp.fsf@deeprootsystems.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DC1A7CBE@dbde02.ent.ti.com>
	<87hbfpcfh6.fsf@deeprootsystems.com>
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DC1A7D8D@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org





> -----Original Message-----
> From: Kevin Hilman [mailto:khilman at deeprootsystems.com] 
> Sent: Wednesday, November 10, 2010 9:56 PM
> To: G, Manjunath Kondaiah
> Cc: linux-omap at vger.kernel.org; 
> linux-arm-kernel at lists.infradead.org; Peter Ujfalusi; 
> Cousson, Benoit; Shilimkar, Santosh
> Subject: Re: [PATCH v3 02/13] OMAP: DMA: Introduce errata 
> handling feature
> 
> "G, Manjunath Kondaiah" <manjugk@ti.com> writes:
> 
> [...]
> 
> >> > +	if (omap_type() == OMAP3430_REV_ES1_0)
> >> > +		SET_DMA_ERRATA(DMA_ERRATA_i88);
> >> > +
> >> > +	/*
> >> > +	 * Errata 3.2/3.3: sometimes 0 is returned if 
> CSAC/CDAC is
> >> 
> >> This doesn't look like a unique errata identifier.  Chapter 3 
> >> is usually
> >> the 'Cautions' section, and I don't listed in either the 
> 34xx (v5.9),
> >> 36xx (v1.3) or 44xx (v1.3) errata docs under this number, and 
> >> don't see
> >> that number in either of the 24xx errata docs either.   
> >> Please clarify.
> >
> > Even I tried to find this info from errata docs prior to migrating
> > all errata's to generic errata handling. This code was 
> exising earlier,
> > hence I retained it "as is", no documentation exists for 
> this errata.
> >
> 
> Hmm, OK.  
> 
> According to the code, it seems to affect every IP execpt 
> 1510, yet it's
> not documented in any of the errata docs.  
> 
> I wonder what happens if it is removed?

This errata work around is used in two API's:
1. omap_get_dma_src_pos
2. omap_get_dma_dst_pos
which are used in sound and usb drivers.

we can run sound and usb unit tests which are using above two 
API's and if there no issues, drop this errata work around?

-Manjunath

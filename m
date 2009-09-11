From: daniel@caiaq.de (Daniel Mack)
Date: Fri, 11 Sep 2009 17:20:19 +0200
Subject: [PATCH] video: add PXA3xx accelerator ID [v2]
In-Reply-To: <20090910133327.GA9410@buzzloop.caiaq.de>
References: <20090910132630.GZ9410@buzzloop.caiaq.de>
	<Pine.LNX.4.64.0909101530120.4458@axis700.grange>
	<20090910133327.GA9410@buzzloop.caiaq.de>
Message-ID: <20090911152019.GZ18340@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 10, 2009 at 03:33:27PM +0200, Daniel Mack wrote:
> On Thu, Sep 10, 2009 at 03:31:34PM +0200, Guennadi Liakhovetski wrote:
> > > +	if (cpu_is_pxa3xx() && inf->acceleration_enabled)
> > > +		fbi->fb.fix.accel = FB_ACCEL_PXA3XX;
> > > +
> > 
> > Ok, now remove 'cpu_is_pxa3xx() && ' above and you should be good to go:-) 
> > What if tomorrow pxa4xx comes (ok, Eric will disagree, but wtill:-))
> 
> Don't know. I left it in there intentionally, but I'm fine to remove it.
> Or Eric does it when applying ;) Eric?

What I was considering are cases where a kernel binary that works on
both PXA3xx and other PXAs shares the same pxafb_mach_info struct across
different board support code. The accel flag would then be set for wrong
platforms.

But this might be academic, that's why I don't have a strong opinion on
that :)

Daniel

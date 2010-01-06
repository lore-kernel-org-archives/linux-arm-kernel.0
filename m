From: abhijitpagare@ti.com (Pagare, Abhijit)
Date: Wed, 6 Jan 2010 14:39:43 +0530
Subject: [PATCH 1/1] ARM: OMAP4: PM: Add check for avoiding dependency
	related update.
In-Reply-To: <alpine.DEB.2.00.1001051608340.21295@utopia.booyaka.com>
References: <1261583238-22187-1-git-send-email-abhijitpagare@ti.com>
	<alpine.DEB.2.00.0912300125320.24862@utopia.booyaka.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C02E919C@dbde02.ent.ti.com>
	<alpine.DEB.2.00.1001051608340.21295@utopia.booyaka.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C041BB3A@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul at pwsan.com]
> Sent: Wednesday, January 06, 2010 4:40 AM
> To: Pagare, Abhijit
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: RE: [PATCH 1/1] ARM: OMAP4: PM: Add check for avoiding dependency
> related update.
> 
> On Wed, 30 Dec 2009, Pagare, Abhijit wrote:
> 
> > > -----Original Message-----
> > > From: Paul Walmsley [mailto:paul at pwsan.com]
> > > Sent: Wednesday, December 30, 2009 2:02 PM
> >
> > > But really, I'd rather not apply this patch.  The best way forward is
> to
> > > apply a patch that adds the OMAP4 wakeup and sleep dependencies
> > > themselves.  Have you had a chance to look at the series that I sent
> you a
> > > few weeks ago off-list that reorganizes the wakeup and sleep
> dependencies
> > > to determine if it is adequate for you to add the OMAP4 wakeup/sleep
> > > dependencies afterwards?
> >
> > I had a look at the dependency patches that you had sent to me earlier
> > and it seems feasible to add the OMAP4 related dependency data on top of
> > those patches. A small change exists but can be taken care of.
> 
> Great, I've just cleaned those up, rebased them, and posted them to the
> list.  If you prefer, you can also get from the
> 'move_wkdeps_sleepdeps_to_clkdm' branch at git://git.pwsan.com/linux-2.6
> 

I checked the dependency patch-set. The complete stuff looks really neat. Applying OMAP4 on top of this would be feasible.
The only thing is that till the point the OMAP4 dependency patches go in the "autodeps" variable in arch/arm/clockdomain.c would not be initialized which will cause a kernel boot-crash for the functions _clkdm_add_autodeps(clkdm) and _clkdm_del_autodeps(clkdm). Hence the hack patch referred to in the subject above is essential. Should I re-post it with the missing FIXME indication that you had recommended?

Thanks & Regards,
Abhijit

> 
> - Paul

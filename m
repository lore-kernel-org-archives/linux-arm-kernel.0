From: abhijitpagare@ti.com (Pagare, Abhijit)
Date: Thu, 21 Jan 2010 11:51:32 +0530
Subject: [PATCH] OMAP CPU ID: fix OMAP4 build failure
In-Reply-To: <alpine.DEB.2.00.1001202008530.3977@utopia.booyaka.com>
References: <alpine.DEB.2.00.1001191412130.3977@utopia.booyaka.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C07CC987@dbde02.ent.ti.com>
	<alpine.DEB.2.00.1001202008530.3977@utopia.booyaka.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C07CCF8B@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Paul,


> -----Original Message-----
> From: Paul Walmsley [mailto:paul at pwsan.com]
> Sent: Thursday, January 21, 2010 8:50 AM
> To: Pagare, Abhijit
> Cc: tony at atomide.com; linux-omap at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: RE: [PATCH] OMAP CPU ID: fix OMAP4 build failure
> 
> Hello Abhijit,
> 
> On Wed, 20 Jan 2010, Pagare, Abhijit wrote:
> 
> > I think the latest patch-set that I had posted has this change in it.
> > You can refer to the patch in the link below
> >
> > http://marc.info/?l=linux-omap&m=126088474831309&w=2
> 
> Looks like this patch had somehow not made it into the for_2.6.34 branch;
> this has now been fixed, which resolves the problem.  But this part we
> should discuss further:
> 
> > I had used this flag earlier as there was nothing fixed as to name it as
> > ES1 that time.
> 
> Yep, I understand.
> 
> > So now it can be migrated from CHIP_IS_OMAP4430 to CHIP_IS_OMAP4430ES1.
> > I think CHIP_IS_OMAP4430 would be redundant in that case and should be
> > removed. A patch would be essential to take care of that in the places
> > where it is used. If you feel the same I can send a patch for fixing
> > this.
> 
> In the past, there have been some clock, clockdomain, powerdomain, IP
> block, etc. changes going from ES1 to ES2 revisions.  But most clocks,
> etc. stay the same.  So it seems best to keep the actual CHIP_IS_* bits
> ES-level sensitive, then define a rollup macro like CHIP_IS_OMAP4430 for
> what stays the same.  Until ES2 details are available, this shouldn't
> require any further changes to the codebase aside from id.c.

Sounds okay.

> 
> We don't currently define a rollup macro for CHIP_IS_OMAP3430, but it's
> planned for 2.6.34 to include all of the individual CHIP_IS_OMAP* bits.
> We'd do the same thing for OMAP2xxx but most of the 2xxx data in the
> kernel tree has no ES-level information, so we'll probably leave those
> as-is.  We'll probably add in a Sitara CHIP_IS_* bit in there also.
> 
> Anyway, there's no need for you to change your patch, now that it's
> included in the for_2.6.34 branch.  But keep in mind that we'll probably
> post another id.c cleanup patch to change things around as described
> above, unless you or others have some strong reason not to...

Yes a patch will be essential for cleaning the id.c as we would have to also match up to the changes made by Tony for OMAP3 in his recently posted "OMAP3: Fix cpu detection" patch.
I can send the patch when we need to push that change in for OMAP4.

Thanks & Regards,
Abhijit

> 
> 
> - Paul

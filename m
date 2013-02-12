From: j-keerthy@ti.com (J, KEERTHY)
Date: Tue, 12 Feb 2013 10:22:20 +0000
Subject: [PATCH] ARM: OMAP: Clock: Remove CK_* flags
In-Reply-To: <alpine.DEB.2.00.1302120638580.14983@utopia.booyaka.com>
References: <1359966525-7603-1-git-send-email-j-keerthy@ti.com>
 <alpine.DEB.2.00.1302080248550.8539@utopia.booyaka.com>
 <DC88CAD03C0052499C1907B327FC63229B92FF@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1302081805450.28008@utopia.booyaka.com>
 <alpine.DEB.2.00.1302081855370.28008@utopia.booyaka.com>
 <DC88CAD03C0052499C1907B327FC63229B966E@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1302111538430.8260@utopia.booyaka.com>
 <DC88CAD03C0052499C1907B327FC63229B989B@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1302120638580.14983@utopia.booyaka.com>
Message-ID: <DC88CAD03C0052499C1907B327FC63229B98DD@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul at pwsan.com]
> Sent: Tuesday, February 12, 2013 12:09 PM
> To: J, KEERTHY
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: RE: [PATCH] ARM: OMAP: Clock: Remove CK_* flags
> 
> On Tue, 12 Feb 2013, J, KEERTHY wrote:
> 
> > > -----Original Message-----
> > > From: Paul Walmsley [mailto:paul at pwsan.com]
> > > Sent: Monday, February 11, 2013 9:10 PM
> > > To: J, KEERTHY
> > > Cc: linux-omap at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> > > Subject: RE: [PATCH] ARM: OMAP: Clock: Remove CK_* flags
> > >
> > > On Mon, 11 Feb 2013, J, KEERTHY wrote:
> > >
> > > > Can I pull the other patches and rebase this patch on top of
> them?
> > > > I need the branch where I can pull the other clock related
> patches.
> > > > I will rebase this patch on top, Verify the PM suspend on
> OMAP4460
> > > > And post it.
> > >
> > > It's based on Tony's omap-for-v3.9/pm branch.
> > >
> >
> > I am on the above branch. I am not seeing retention with/without the
> patch.
> 
> Sounds like you get to do some bisecting :-)
> 

Heh :-). It narrowed down to this patch:

commit 17b7e7d33530e2bbd3bdc90f4db09b91cfdde2bb
Author: Paul Walmsley <paul@pwsan.com>
Date:   Sat Jan 26 00:48:54 2013 -0700

    ARM: OMAP4: clock/hwmod data: start to remove some IP block control "clocks"
    
    Remove some leaf "clocks" that are actually IP block idle control
    points, since these should now be handled by the hwmod code.
    
    There are still a few types of MODULEMODE clocks that need to be
    cleaned up:
    
    - those still in use by driver or integration code
    
    - those in DEFINE_CLK_OMAP_MUX_GATE() blocks; the gate portion of
      these should be removed
    
    A similar process may also be possible on OMAP2/3.
    
    Signed-off-by: Paul Walmsley <paul@pwsan.com>
    Cc: Beno?t Cousson <b-cousson@ti.com>
    Cc: Mike Turquette <mturquette@linaro.org>

> 
> - Paul

Regards,
Keerthy

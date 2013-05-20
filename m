From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Mon, 20 May 2013 17:55:58 +0000
Subject: [PATCH-V2] ARM: OMAP2+: AM33xx: Fix missing reset status data
 to GFX hwmod
In-Reply-To: <alpine.DEB.2.02.1305201439020.6174@utopia.booyaka.com>
References: <1369057116-31423-1-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.02.1305201439020.6174@utopia.booyaka.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EC8EF8A@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Paul Walmsley [mailto:paul at pwsan.com]
> Sent: Monday, May 20, 2013 8:09 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap at vger.kernel.org; tony at atomide.com; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH-V2] ARM: OMAP2+: AM33xx: Fix missing reset status
> data to GFX hwmod
> 
> On Mon, 20 May 2013, Vaibhav Hiremath wrote:
> 
> > GFX has a reset status register (PRM_GFX.RM_GFX_RSTST),
> > so update the GFX hwmod data with .rstst_off and .st_shift
> > information.
> >
> > Although it doesn't have impact on kernel boot, but this is
> > regression fix from original hwmod commit.
> >
> 
> Did it ever work?  If not, then it's not a regression, right?
> 

As we know none of the GFX sw is available in the mainline, so never got
exercised so far; but kernel boots up fine without any issues.
I was also confused a bit on this, but then thought, this could be regression
As it is fixing wrong/missing data without which GFX will not work.
May be I was wrong.

Thanks,
Vaibhav

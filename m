From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Wed, 27 Mar 2013 06:17:00 +0000
Subject: [PATCH] ARM: AM33XX: Add missing .clkdm_name to clkdiv32k_ick
 clock
In-Reply-To: <alpine.DEB.2.00.1303261812010.23957@utopia.booyaka.com>
References: <1364211443-27536-1-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1303261812010.23957@utopia.booyaka.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EC3B0AE@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Paul Walmsley
> Sent: Tuesday, March 26, 2013 11:43 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> Tony Lindgren
> Subject: Re: [PATCH] ARM: AM33XX: Add missing .clkdm_name to
> clkdiv32k_ick clock
> 
> On Mon, 25 Mar 2013, Vaibhav Hiremath wrote:
> 
> > During common-clock migration, .clkdm_name field got missed
> > for "clkdiv32k_ick" clock, which leaves "clk_24mhz_clkdm"
> > unused; so boot process will try to disable the clockdomain
> > even childs of this clock is enabled, which keeps child modules
> > in idle mode.
> 
> Looks fine to me.  You're planning to update the patch description,
> right?
> So should I wait until you repost it?
> 
Yeup, will submit today.

> Also you should probably trim the crash log after "[    2.626025] LR is
> at
> clk_enable+0x30/0x3c"
> 
Ok, 

Thanks,
Vaibhav

> 
> 
> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

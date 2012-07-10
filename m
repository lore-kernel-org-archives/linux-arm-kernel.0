From: tony@atomide.com (Tony Lindgren)
Date: Tue, 10 Jul 2012 01:37:27 -0700
Subject: [PATCH v2 04/14] ARM: OMAP5: Add minimal support for OMAP5430 SOC
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA699A3@DBDE01.ent.ti.com>
References: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com>
 <1341566515-22665-5-git-send-email-santosh.shilimkar@ti.com>
 <4FFA9B61.8030808@ti.com> <20120709131156.GH1122@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA69538@DBDE01.ent.ti.com>
 <20120710081851.GL1122@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA699A3@DBDE01.ent.ti.com>
Message-ID: <20120710083726.GN1122@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Hiremath, Vaibhav <hvaibhav@ti.com> [120710 01:35]:
> On Tue, Jul 10, 2012 at 13:48:52, Tony Lindgren wrote:
> > 
> > No thanks.. We don't want to make it 32 bit and bloat all the compiled in
> > clock even further. 
> > 
> 
> In that case, how about just get rid of cpu_mask completely and trust the 
> data passed by clock-tree for clksel dividers?
> Let clock-tree data handle this, even if in some cases we end up in 
> duplicating data for some clocks??

Yes something like that. We already know which clocks need to
be registered, so whatever we still use CK_XXXX for should be also
initialized in omapxxxx_clk_init() functions.

Regards,

Tony

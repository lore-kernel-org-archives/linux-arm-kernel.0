From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 22 Apr 2012 17:10:45 +0200
Subject: [PATCH] arm: at91: fix build-error for board-dt
In-Reply-To: <201204221339.18385.arnd@arndb.de>
References: <1335004105-3162-1-git-send-email-w.sang@pengutronix.de>
 <201204211839.15535.arnd@arndb.de>
 <20120422015059.GE9142@game.jcrosoft.org>
 <201204221339.18385.arnd@arndb.de>
Message-ID: <20120422151045.GF9142@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13:39 Sun 22 Apr     , Arnd Bergmann wrote:
> On Sunday 22 April 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 18:39 Sat 21 Apr     , Arnd Bergmann wrote:
> > > On Saturday 21 April 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > > > Ok, we can discard this patch and see it as a bug report.
> > > > > Since you know best what you'd like, would you send a patch?
> > > > I'll fix on 3.5 by make it depends on AT91SAM9
> > > 
> > > I think it should be fixed for v3.4, especially since it's so easy
> > > to trigger and the fix will be trivial.
> > The symbol does not exist before
> > 
> > and the board-dt is sam9 only
> 
> How about this patch for v3.4 then? It ensures that we don't try to build
> ARCH_AT91RM9200 or ARCH_AT91X40 with MACH_AT91SAM_DT, which would be broken
> in v3.4-rc4 as Wolfram pointed out.
no I don't like it either

I prefer to apply this patch from 3.5
1441bd325bbbcd38d190b2444481b23cdf70069a ARM: at91: add SOC_AT91SAM9 kconfig
option to factorise select

and then fix it

so the board will be build only for sam9

Best Regards,
J.

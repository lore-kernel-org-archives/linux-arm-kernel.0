From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Fri, 25 Feb 2011 19:37:15 +0530
Subject: [PATCH 8/8] OMAP2+: clockevent: late-init GPTIMER clockevent
	hwmodright before timer init
In-Reply-To: <20110224154108.GB20560@atomide.com>
References: <20110223070455.5874.51326.stgit@twilight.localdomain>
	<20110223071153.5874.58923.stgit@twilight.localdomain>
	<581270b49665fcf8227a96065dbbc584@mail.gmail.com>
	<alpine.DEB.2.00.1102240109500.6198@utopia.booyaka.com>
	<alpine.DEB.2.00.1102240114160.6198@utopia.booyaka.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB037A0958B7@dbde02.ent.ti.com>
	<20110224154108.GB20560@atomide.com>
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037A095EA9@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Tony Lindgren [mailto:tony at atomide.com]
> Sent: Thursday, February 24, 2011 9:11 PM
> To: DebBarma, Tarun Kanti
> Cc: Paul Walmsley; Shilimkar, Santosh; linux-omap at vger.kernel.org; linux-
> arm-kernel at lists.infradead.org; Hilman, Kevin; Cousson, Benoit
> Subject: Re: [PATCH 8/8] OMAP2+: clockevent: late-init GPTIMER clockevent
> hwmodright before timer init
> 
> * DebBarma, Tarun Kanti <tarun.kanti@ti.com> [110224 00:27]:
> > I have tested on OMAP3 and works fine.
> > On OMAP2, I guess there is different issue for which it does not work.
> 
> That's because commit 15490ef8ff8fd22d677cb5d4f6a98e5a79118dba changed
> things to include CONFIG_CPU_32v6K. And this means that omap-for-linus
> won't boot on omap2 currently using omap2plus_defconfig. The master
> branch boots because of the patches in omap-testing.
> 
> To boot test omap-for-linus, you can temporarily merge in the
> omap-testing branch that has the pending patches from Russell to
> make non-6K ARMv6 processors work with CONFIG_CPU_32v6K.
I have re-based the changes on omap-testing branch and tested on
OMAP2420 and OMAP2430.
--
Tarun

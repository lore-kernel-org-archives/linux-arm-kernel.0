From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 26 Mar 2013 18:02:17 +0100
Subject: [RFCv1 01/11] arm: mvebu: move L2 cache initialization in
 init_early()
In-Reply-To: <201303261653.48998.arnd@arndb.de>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1364316746-8702-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <201303261653.48998.arnd@arndb.de>
Message-ID: <20130326180217.4c471227@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Tue, 26 Mar 2013 16:53:48 +0000, Arnd Bergmann wrote:
> On Tuesday 26 March 2013, Thomas Petazzoni wrote:
> > @@ -72,6 +73,10 @@ void __init armada_370_xp_init_early(void)
> >                         ARMADA_370_XP_MBUS_WINS_SIZE,
> >                         ARMADA_370_XP_SDRAM_WINS_BASE,
> >                         ARMADA_370_XP_SDRAM_WINS_SIZE);
> > +
> > +#ifdef CONFIG_CACHE_L2X0
> > +       l2x0_of_init(0, ~0UL);
> > +#endif
> 
> I guess you should remove the #ifdef as well here, it's not needed.

Right, will fix for the next version.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

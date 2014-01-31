From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 31 Jan 2014 11:54:10 +0100
Subject: [PATCH v2 2/3] ata: sata_mv: fix disk hotplug for Armada 370/XP
 SoCs
In-Reply-To: <20140131104643.GC10250@kw.sim.vm.gnt>
References: <1389711007-7239-1-git-send-email-simon.guinot@sequanux.org>
 <1389711007-7239-3-git-send-email-simon.guinot@sequanux.org>
 <20140126083210.2998ef12@skate>
 <20140131104643.GC10250@kw.sim.vm.gnt>
Message-ID: <20140131115410.557cf050@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Simon Guinot,

On Fri, 31 Jan 2014 11:46:44 +0100, Simon Guinot wrote:

> > > +	/*
> > > +	 * To allow disk hotplug on Armada 370/XP SoCs, the PHY speed must be
> > > +	 * updated in the LP_PHY_CTL register.
> > > +	 */
> > > +	if (pdev->dev.of_node &&
> > > +		of_device_is_compatible(pdev->dev.of_node,
> > > +					"marvell,armada-370-xp-sata"))
> > 
> > Testing whether pdev->dev.of_node is not NULL does not seems to be
> > useful. A quick read of of_device_is_compatible() and the function it's
> > calling seem to indicate that of_device_is_compatible will return false
> > if the passed struct device_node * is NULL.
> 
> I see.
> 
> It seems to me, you already have a patch ready to send. Isn't it ?
> Or do you want me to do the update ?

I see that your patches have been merged, so I will send followup fixes.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

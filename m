From: tony@atomide.com (Tony Lindgren)
Date: Thu, 11 Oct 2012 07:47:56 -0700
Subject: [PATCH 0/4] OMAP-GPMC generic timing migration
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9FBC41@DBDE01.ent.ti.com>
References: <cover.1349450723.git.afzal@ti.com> <5076B166.2020006@gmail.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9FBC41@DBDE01.ent.ti.com>
Message-ID: <20121011144756.GB12552@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mohammed, Afzal <afzal@ti.com> [121011 05:48]:
> Hi Daniel,
> 
> On Thu, Oct 11, 2012 at 17:15:42, Daniel Mack wrote:
> 
> > Admittedly, I lost track on the multiple GPMC series here, and they also
> > cause major merge conflicts with Linus' current master branch.
> > 
> > Could you tell me which patches I need on top of soon-to-be-3.7-rc1? I
> 
> Series [1-2] plus this series would be the required.
> Note that 1st patch of series [2] has already reached mainline.
> 
> Another easy way would be, pull,
> git://gitorious.org/x0148406-public/linux-kernel.git gpmc-timing
> 
> git checkout -b gpmc <myremote/gpmc-timing>
> git rebase --onto <Linus-current-master> next-20121005 (or "080aa9c")

After -rc1 is out, let's plan on adding the minimal
set required for removing plat and mach includes from
drivers into a clean-up branch. Afzal, can you maybe
do a pull request for that set against -rc1 when it's
out? Just the minimal set of patches.

> > would like to augment this to make GPMC attached NAND probable in DT, in
> > case this is still an open topic.
> 
> I would be doing gpmc DT conversion next. Hoping that this
> series too will be picked up by Tony, as once this series is
> accepted, during DT conversion we need not rely on
> auxdata (a last resort option) for timings.

Yes, then please do a second pull request for what's needed
to apply the minimal DT bindings. For the DT binding, let's
just leave out the timings for now as we can load those from
auxdata. Then the binding for the timings can be added
later on. So just the minimal binding using standard features
for the iorange and interrupt.

Thanks,

Tony 

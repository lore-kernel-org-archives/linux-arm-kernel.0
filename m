From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Jul 2018 12:16:41 +0100
Subject: arm: v4.18-rc5 with cpuidle on TC2 (A7 boot) spectre v2 issue
In-Reply-To: <20180719103919.GB19287@e105550-lin.cambridge.arm.com>
References: <2abc6c11-2e8c-a4ea-6911-0f495d90ace6@arm.com>
 <20180719100109.GH17271@n2100.armlinux.org.uk>
 <20180719103919.GB19287@e105550-lin.cambridge.arm.com>
Message-ID: <20180719111640.GJ17271@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2018 at 11:39:19AM +0100, Morten Rasmussen wrote:
> On Thu, Jul 19, 2018 at 11:01:10AM +0100, Russell King - ARM Linux wrote:
> > On Thu, Jul 19, 2018 at 11:42:50AM +0200, Dietmar Eggemann wrote:
> > > Hi,
> > > 
> > > running v4.18-rc5 (plus still missing "power: vexpress: fix corruption in
> > > notifier registration", otherwise I get this rcu_sched stall issue) on TC2
> > > (A7 boot) with vanilla multi_v7_defconfig plus
> > > CONFIG_ARM_BIG_LITTLE_CPUIDLE=y gives me continuous:
> > > 
> > > ...
> > >  CPUX: Spectre v2: incorrect context switching function, system vulnerable
> > > ...
> > > 
> > > messages.
> > > 
> > > Work around is to disable CONFIG_HARDEN_BRANCH_PREDICTOR.
> > 
> > or disable big.Little if you want the hardening.
> > 
> > The choices are currently either protection against Spectre or big.Little
> > support since the two are mutually exclusive at the moment.
> 
> Would it be possible to make those message only appear once like they do
> when booting on A15?

Yes, it's possible.  Feel free to send a patch, thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up

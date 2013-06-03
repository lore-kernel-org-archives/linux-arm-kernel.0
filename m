From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 3 Jun 2013 14:15:27 +0100
Subject: [RFC PATCH 2/3] drivers: mfd: vexpress: add timeout API to
 vexpress config interface
In-Reply-To: <1370261030.16073.5.camel@linaro1.home>
References: <1369399986-15649-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1369399986-15649-3-git-send-email-lorenzo.pieralisi@arm.com>
 <1370254532.3407.36.camel@linaro1.home>
 <20130603115219.GA22821@e102568-lin.cambridge.arm.com>
 <1370261030.16073.5.camel@linaro1.home>
Message-ID: <20130603131527.GC22821@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 03, 2013 at 01:03:50PM +0100, Jon Medhurst (Tixy) wrote:
> On Mon, 2013-06-03 at 12:52 +0100, Lorenzo Pieralisi wrote:
> > On Mon, Jun 03, 2013 at 11:15:32AM +0100, Jon Medhurst (Tixy) wrote:
> > > On Fri, 2013-05-24 at 13:53 +0100, Lorenzo Pieralisi wrote:
> > > > In case some transactions to the Serial Power Controller (SPC) are lost owing
> > > > to multiple operations handled at once by the M3 controller the OS needs to
> > > > rely on a configuration API that can time out so that failures do not result
> > > > in an unusable system.
> > > > 
> > > > This patch adds a timeout API to the vexpress config programming interface,
> > > > and refactors the existing read/write functions so that they can be reused
> > > > seamlessly on top of the newly defined API.
> > > 
> > > Isn't one of the main purposes of the config interface to serialise
> > > transactions to the config bus, so why would the SPC be handling
> > > multiple transactions at once? And if we can in fact loose transactions
> > > doesn't this mean we get random failures in the system? E.g. if this
> > > happened at boot in vexpress_spc_populate_opps then cpufreq will fail.
> > 
> > It has more to do with firmware carrying out background operations like
> > powering up a cluster when a DVFS is requested.
> 
> Would that make it drop transactions or just take a longer time to get
> around to servicing them?

It should just take longer to service them, that's what the behaviour
should be.

Lorenzo

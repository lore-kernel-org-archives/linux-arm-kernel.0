From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Mar 2011 17:54:07 +0100
Subject: [RFC PATCHv1 1/2] Export SoC info through sysfs
In-Reply-To: <20110310161917.GD27206@opensource.wolfsonmicro.com>
References: <1299689961-5028-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<201103101711.59544.arnd@arndb.de>
	<20110310161917.GD27206@opensource.wolfsonmicro.com>
Message-ID: <201103101754.07679.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 March 2011, Mark Brown wrote:
> On Thu, Mar 10, 2011 at 05:11:59PM +0100, Arnd Bergmann wrote:
> > On Thursday 10 March 2011, Mark Brown wrote:
> 
> > > You could, though the bus will just be a noop.  Typically it's more than
> > > one bus but software basically can't tell.
> 
> > Yes. The main reason for representing such a bus in sysfs would be
> > to match the SOC's block diagram with the structure in the kernel.
> 
> If you're doing that things like power domains tend to be a lot more
> interesting since you can do something meaningful with them in software.
> The non-visible buses aren't reliably documented anyway and the first
> procesor datasheet I just pulled up had a whole bunch of devices that
> span multiple buses anyway :)

Yes, I'm aware that devices are not alwasy in a clear hierarchy and
that you have bus addressing, device driver, clock, power and interrupt
(and possibly more) trees that often don't match up.

My point is simply that we should still try to find a helpful tree
representation in these cases, even if it's not perfect. Almost anything
is better than having lots of unrelated devices in a flat directory.

	Arnd

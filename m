From: marvin24@gmx.de (Marc Dietrich)
Date: Wed, 27 Jun 2012 20:50:57 +0200
Subject: [PATCH V2] ARM: dt: tegra: paz00: add regulators
In-Reply-To: <20120627113100.GF308@opensource.wolfsonmicro.com>
References: <1340757060-27232-1-git-send-email-swarren@wwwdotorg.org>
 <20120627113100.GF308@opensource.wolfsonmicro.com>
Message-ID: <21985997.TUGv5fZBXQ@ax5200p>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 June 2012 12:31:01 Mark Brown wrote:
> On Tue, Jun 26, 2012 at 06:31:00PM -0600, Stephen Warren wrote:
> > sm1: HW defaults and schematic match at 1.0v. marvin24's kernel had a max
> > of 1.125v, but this wasn't applied since apply_uV wasn't set.
> 
> apply_uV is only valid if a single voltage is specified.  

yes, that's why there is a ".apply_uV = (_minmv == _maxmv)" in the regulator 
macro.

> If a voltage
> range were specified and it were acted on we'd take the lowest (not
> highest) voltage allowed.

Sorry, I don't get it. In this case, the board wouldn't boot at all because 
nearly all supplies would be undervoltaged. I just checked and all voltages 
are actually set to the *highest* (max) value. Maybe they aren't changed at 
all?

Marc

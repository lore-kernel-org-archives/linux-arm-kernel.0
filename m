From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 24 Jul 2014 15:45:41 +0100
Subject: [PATCH RESEND v2] bus: ARM CCN PMU driver
In-Reply-To: <39594081.3C5fmmXpMJ@wuerfel>
References: <1406050379-15199-1-git-send-email-pawel.moll@arm.com>
 <201407232223.39341.arnd@arndb.de> <39594081.3C5fmmXpMJ@wuerfel>
Message-ID: <1406213141.25343.175.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-07-23 at 23:29 +0200, Arnd Bergmann wrote:
> On Wednesday 23 July 2014 22:23:38 Arnd Bergmann wrote:
> > On Tuesday 22 July 2014, Pawel Moll wrote:
> > > Driver providing perf backend for ARM Cache Coherent Network
> > > interconnect. Supports counting all hardware events and crosspoint
> > > watchpoints.
> > > 
> > > Currently works with CCN-504 only, although there should be
> > > no changes required for CCN-508 (just impossible to test it now).
> > > 
> > > Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> > 
> > Applied to next/drivers, thanks!
> 
> I'm getting build errors with CONFIG_PERF_EVENTS disabled. 
> Is the patch below the right answer, or should we still load
> the driver and #ifdef the perf-events code?
> 
> It seems to me that the driver doesn't do anything besides
> perf events, but I could be missing something.

No, you're right. At the moment this is only a PMU driver, and I don't
expect this would change any time soon, so your change will do the job,
thanks!

Pawel

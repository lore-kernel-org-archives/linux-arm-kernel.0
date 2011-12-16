From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 16 Dec 2011 11:01:10 +0100
Subject: [PATCH v2] [RESEND] Handle instruction cache maintenance fault
 properly
In-Reply-To: <20111216022205.GA28787@shutemov.name>
References: <AANLkTilVp0xvAJNns3TEe4SzEUpN8hMC9DdwmwW7i9yX@mail.gmail.com>
 <20111215215649.GJ24496@pengutronix.de>
 <20111216022205.GA28787@shutemov.name>
Message-ID: <20111216100110.GK24496@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hallo,

On Fri, Dec 16, 2011 at 04:22:05AM +0200, Kirill A. Shutemov wrote:
> On Thu, Dec 15, 2011 at 10:56:49PM +0100, Uwe Kleine-K?nig wrote:
> > Hello,
> > 
> > On Tue, May 11, 2010 at 01:33:14PM +0300, Kirill A. Shutemov wrote:
> > > Between "clean D line..." and "invalidate I line" operations in
> > > v7_coherent_user_range(), the memory page may get swapped out.
> > > And the fault on "invalidate I line" could not be properly handled
> > > causing the oops.
> > > 
> > > In ARMv6 "external abort on linefetch" replaced by "instruction cache
> > > maintenance fault". Let's handle it as translation fault. It fixes the
> > > issue.
> > > 
> > > I'm not sure if it's reasonable to check arch version in run-time.
> > > Let's do it in compile time for now.
> > > 
> > > Signed-off-by: Siarhei Siamashka <siarhei.siamashka@nokia.com>
> > > Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
> > I found this patch in Catalin's stack that I picked up to get support
> > for Cortex-M3. Is this still relevant?
> 
> It's in upstream. See 8c0b742.
Ah, I missed that because it applies again on top of 3.2-rc because of

	993bf4e (ARM: 6256/1: Check arch version and modify fsr_info[] depends on it at runtime)

Thanks and sorry for the noise,
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

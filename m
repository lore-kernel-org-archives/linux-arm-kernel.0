From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 16 Apr 2014 10:20:45 +0200
Subject: [PATCH v2 2/6] PCI: tegra: use new OF interrupt mapping when
 possible
In-Reply-To: <20140415182651.GA17721@google.com>
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
 <1394025951-32438-3-git-send-email-l.stach@pengutronix.de>
 <20140404165559.GE9007@google.com>
 <1397556454.4574.13.camel@weser.hi.pengutronix.de>
 <20140415182651.GA17721@google.com>
Message-ID: <1397636445.5070.8.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 15.04.2014, 12:30 -0600 schrieb Bjorn Helgaas:
> On Tue, Apr 15, 2014 at 12:07:34PM +0200, Lucas Stach wrote:
> > Hi Bjorn,
> > 
> > Am Freitag, den 04.04.2014, 10:55 -0600 schrieb Bjorn Helgaas:
> > > On Wed, Mar 05, 2014 at 02:25:47PM +0100, Lucas Stach wrote:
> > > > This is the recommended method of doing the IRQ
> > > > mapping. For old devicetrees we fall back to the
> > > > previous practice.
> > > > 
> > > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > Applied with Stephen's Tested-by to my pending/host-tegra branch.  I'll
> > > rebase and rename it after v3.15-rc1, and I think we can squeeze it into
> > > v3.15 shortly after that.  Thanks.
> > > 
> > 
> > Are you still planning to push this into 3.15, or has this slipped to
> > 3.16?
> 
> Yes, I'm hoping to put them in v3.15.  I assume these actually
> fix something, e.g., we need these changes to boot with new devicetrees, or
> something?
> 
> The changelogs don't make it clear that these are fixes, and I want to heed
> Linus' guidance: "Anyway, because -rc1 is already pretty darn big, I do
> *not* want to hear about 'sorry this missed the window, can I still sneak
> in'.  Fixes only."
> 
> I should have applied these sooner to make the merge window; I apologize
> for that.  Anyway, if you outline what these fix, I'll update the
> changelogs in my tree.
> 
Actually they are a bit on the fence.

The i.MX and thus the designware patch actually fixes wrong behavior,
where all PCI legacy interrupts would be mapped to a single GIC
interrupt, which would leave INT B,C,D nonfunctional on i.MX.

The others only make DT interrupt mapping functional for all drivers, so
they would be useful if you need to remap interrupts across bridges or
something. But apparently nobody had the need to to this on platforms
other than i.MX until now, so those patches only fix a theoretical
issue.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

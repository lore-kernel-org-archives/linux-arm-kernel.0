From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 15 Mar 2017 18:12:53 +0100
Subject: [RFC PATCH 2/4] pinctrl: rockchip: convert to raw spinlock
In-Reply-To: <20170315165900.63f32371.john@metanate.com>
References: <20170313183813.3582-1-john@metanate.com>
 <2549921.4Nq1JGygY8@phil> <20170315165900.63f32371.john@metanate.com>
Message-ID: <5561804.yNijhH7yqI@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 15. M?rz 2017, 16:59:00 CET schrieb John Keeping:
> On Wed, 15 Mar 2017 17:41:21 +0100, Heiko Stuebner wrote:
> > Am Mittwoch, 15. M?rz 2017, 17:28:56 CET schrieb Heiko Stuebner:
> > > Am Montag, 13. M?rz 2017, 18:38:11 CET schrieb John Keeping:
> > > > This lock is used from rockchip_irq_set_type() which is part of the
> > > > irq_chip implementation and thus must use raw_spinlock_t as documented
> > > > in Documentation/gpio/driver.txt.
> > > > 
> > > > Signed-off-by: John Keeping <john@metanate.com>
> > > 
> > > Looks good
> > > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> > 
> > I have to take that back.
> > This leaves the spin_lock in the schmitt trigger unconverted and produces
> > compile issues.
> > 
> > So it either needs to be converted or removed - I guess it should be
> > removed.
> Yes, it looks like it should be removed - the patches adding that hadn't
> been applied when I sent this out!
> 
> I'll rebase and add the schmitt trigger change to patch 1 in a day or
> two, after giving a bit more time for reviews.

I don't think you need to wait overly long. Linus seems happy, I'm happy and 
the schmitt issue in the open might prevent people from taking a closer look.


Heiko

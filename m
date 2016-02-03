From: tony@atomide.com (Tony Lindgren)
Date: Wed, 3 Feb 2016 08:36:04 -0800
Subject: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
In-Reply-To: <CAJZ5v0jbOJc2m=cBrvAuMUHvY8_AQPdJEyt1w-dPikU5expeLA@mail.gmail.com>
References: <20160202210345.GZ19432@atomide.com>
 <Pine.LNX.4.44L0.1602021626540.1653-100000@iolanthe.rowland.org>
 <20160202234626.GD19432@atomide.com>
 <CAJZ5v0jbOJc2m=cBrvAuMUHvY8_AQPdJEyt1w-dPikU5expeLA@mail.gmail.com>
Message-ID: <20160203163604.GH19432@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rafael J. Wysocki <rafael@kernel.org> [160203 05:07]:
> On Wed, Feb 3, 2016 at 12:46 AM, Tony Lindgren <tony@atomide.com> wrote:
> >
> > Yes.. That works too. I guess the thing to consider is if we should
> > make pm_runtime_put_sync() always sync along the lines of a patch
> > I posted earlier today. That could avoid quite a bit of confusion
> > as already seen in this thread :)
> 
> No, we shouldn't.
> 
> As I said, the current behavior is actually well documented (in
> kerneldoc comments and elsewhere).

OK. I'll do a series of fixes to the drivers using omap_device.

Regards,

Tony

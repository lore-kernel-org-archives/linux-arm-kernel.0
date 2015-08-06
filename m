From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 06 Aug 2015 13:10:55 +0200
Subject: [PATCH v3 3/3] ARM: rockchip: enable PMU_GPIOINT_WAKEUP_EN when
 entering shallow suspend
In-Reply-To: <CAD=FV=W0L_0iM+15BAUfTA2ij5Ac90aVW9JZYyDhHMDNT2ZUMg@mail.gmail.com>
References: <2128609.Kb18M8K28F@diego> <1544453.8uqOvAiDmD@diego>
 <CAD=FV=W0L_0iM+15BAUfTA2ij5Ac90aVW9JZYyDhHMDNT2ZUMg@mail.gmail.com>
Message-ID: <3564263.VnOXW7qXSg@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 5. August 2015, 18:55:52 schrieb Doug Anderson:
> Heiko,
> 
> On Tue, Aug 4, 2015 at 3:51 PM, Heiko St?bner <heiko@sntech.de> wrote:
> > PMU_GPIOINT_WAKEUP_EN seems needed when entering the shallow suspend
> > (with logic staying on) but does not seem to be needed for the deep
> > suspend for unknown reasons.
> > Testing revealed that this setting really is necessary to reliably
> > resume the veyron devices from suspend.
> > 
> > Reported-by: Chris Zhong <zyw@rock-chips.com>
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > 
> >  arch/arm/mach-rockchip/pm.c | 9 ++++++---
> >  arch/arm/mach-rockchip/pm.h | 1 +
> >  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> Very odd, but OK by me...

Hopefully we'll get an explaination from the ic-people soon-ish.


> Hopefully we'll eventually end up being
> able to use deep suspend on mainline.  That'd be nice, wouldn't it?

hehe ... yep, one of the big remaining projects :-)

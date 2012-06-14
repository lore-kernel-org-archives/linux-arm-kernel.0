From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Thu, 14 Jun 2012 13:36:48 +0000
Subject: [PATCH v6 00/17] Add PWM framework and device tree support
In-Reply-To: <20120614125329.GA7678@avionic-0098.mockup.avionic-design.de>
References: <1334070400-25013-1-git-send-email-thierry.reding@avionic-design.de>
 <1BAFE6F6C881BF42822005164F1491C33EA21A9F@DBDE01.ent.ti.com>
 <20120614125329.GA7678@avionic-0098.mockup.avionic-design.de>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA21C02@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 18:23:29, Thierry Reding wrote:
> On Thu, Jun 14, 2012 at 12:47:13PM +0000, Hebbar, Gururaja wrote:
> > On Tue, Apr 10, 2012 at 20:36:23, Thierry Reding wrote:
> > > This patch series adds very rudimentary device-tree support for PWM
> > > devices. With all of these patches applied (plus one board-specific
> > > patch that is not included), I'm able to control the backlight on the
> > > device I'm working on using the sysfs interface provided by the pwm-bl
> > > driver and the backlight class.
> > > 
> > > This series is based on Sascha Hauer's series of patches[0] to add a
> > > generic PWM framework. The first patch in this series is taken from
> > > Sascha's branch, while the second patch enables each PWM chip to provide
> > > multiple PWM devices (the Blackfin and PXA drivers have been ported to
> > > the framework for reference). Currently a global namespace is still
> > > provided to keep backwards-compatibility with the legacy PWM API. In
> > > order to achieve this, the number of global PWM devices is limited to
> > > 1024. However, patch 2 introduces per-chip indexing of PWM devices in
> > > the core and patch 4 adds an API to request a PWM device using a lookup
> > > table registered by board setup code. They are supposed to eventually
> > > replace pwm_request() and allow to get rid of the global namespace. The
> > > device tree support code does not use the global namespace.
> > > 
> > ..snip..
> > ..snip..
> > 
> > > 
> > > The whole series is based on the linux-next tree from 20120405. I think
> > > I've addressed all of the concerns raised in the first five versions. I
> > > have also pushed this version of the series to the PWM subsystem
> > > repository[1].
> > > 
> > > Thierry
> > > 
> > > [0]: http://git.pengutronix.de/?p=imx/linux-2.6.git;a=shortlog;h=refs/heads/pwmlib
> > > [1]: http://gitorious.org/linux-pwm/linux-pwm/trees/pwm-v6
> > > 

..snip..
..snip..

> > > 
> > 
> > I am planning to add PWM support in Linux for TI AM335x SOC. 
> > I am taking your new PWM framework as reference.
> > 
> > I see a lot of ack's for the patches. I see that you are maintaining these patches in a separate repo.
> > However, I couldn't find any of these 
> > patches in the mainline kernel (including recent 3.5-rc2). 
> > Do you have any plans for pushing this again to mainline kernel. 
> 
> Yes, as a matter of fact I'm in the process of getting the series ready for
> inclusion into linux-next. I expect them to go into 3.6.
> 
> Thierry
> 

Thanks. Eagerly looking forward to it.

Thanks & Regards, 
Gururaja

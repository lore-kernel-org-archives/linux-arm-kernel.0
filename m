From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 Apr 2014 11:21:59 +0200
Subject: [PATCH 1/4] clocksource: Add support for the Mediatek SoCs
In-Reply-To: <CABuKBeKr77qJwusoTgjR2yOspWbi6Exvt5i8WPc5tjd7fez-YA@mail.gmail.com>
References: <1397072736-10793-1-git-send-email-matthias.bgg@gmail.com>
 <CAOesGMg2zvPPeyqTvztiNKVJzWP5PsNs2pkXKMaS+CfXHgO0rQ@mail.gmail.com>
 <CABuKBeKr77qJwusoTgjR2yOspWbi6Exvt5i8WPc5tjd7fez-YA@mail.gmail.com>
Message-ID: <129772722.mXH1xx9vCv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 April 2014 11:07:35 Matthias Brugger wrote:
> >
> > Of course, you'll still need these for the A9-based platforms, so the
> > driver might very well be needed anyway. Some of the earlier patches
> > seem to be for A7-based systems so I'm not sure what you're primarily
> > working on here. 
> 
> I'm working on a Cortex-A7 based platform. But ARM_ARCH_TIMER seems to
> get no clocking.
> Initializing the timer fails with:
> Architected timer frequency not available
> 
> That's why I use the SoC timer.

Are you sure you're not just missing a "clock-frequency" property
in your DT node for the timer?

	Arnd

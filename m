From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 05 Apr 2013 12:33:12 +0200
Subject: [PATCH v4 00/14] ARM: samsung-time: Prepare for multiplatform
 support
In-Reply-To: <201304050115.03879.heiko@sntech.de>
References: <1365093431-30621-1-git-send-email-t.figa@samsung.com>
 <201304050115.03879.heiko@sntech.de>
Message-ID: <2744467.M5ElrZXicK@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Friday 05 of April 2013 01:15:02 Heiko St?bner wrote:
> Am Donnerstag, 4. April 2013, 18:36:57 schrieb Tomasz Figa:
> > This series is an attempt to make the samsung-time clocksource driver
> > ready
> > for multiplatform kernels. It moves the driver to drivers/clocksource,
> > cleans it up from uses of static platform-specific definitions, simplifies
> > timer interrupt handling and adds Device Tree support.
> > 
> > Only samsung-time driver is reworked to use the master driver at this
> > time,
> > since the PWM driver can be already considered broken at the moment and
> > needs separate series of several patches to fix and clean it up, which
> > I am already working on.
> > 
> > Tested on Universal C210 board with Device Tree. Not tested without
> > Device Tree, since it has been already broken before this series.
> > Compile tested for other related SoCs.
> 
> Looks nice.
> 
> On a non-DT S3C2416 board:
> Tested-by: Heiko Stuebner <heiko@sntech.de>

Thanks for testing.

> And just so I don't search myself silly, am I right in thinking that the
> driver does not use the generic clocksource registration yet and dt machines
> must still use samsung_timer_init at this point?

Yes. Because of the build failures it caused recently I have decided not to 
use it yet. It can be added with a small patch later, though.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
SW Solution Development, Kernel and System Framework

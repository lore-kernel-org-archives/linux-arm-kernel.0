From: m.chehab@samsung.com (Mauro Carvalho Chehab)
Date: Thu, 07 Jul 2016 21:34:21 -0300
Subject: [GIT PULL 1/2] omap ir-rx51 driver fixes for multiarch for v4.8
 merge window
In-Reply-To: <pull-1467702709-538742@samsung.com>
References: <pull-1467702709-538742@samsung.com>
Message-ID: <20160707213421.07a886ac.m.chehab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Tue, 05 Jul 2016 00:56:52 -0700
Tony Lindgren <tony@atomide.com> escreveu:

> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
> 
>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.8/ir-rx51-signed
> 
> for you to fetch changes up to 79cdad3635b3a253d712aba115fa274ef94a8c6b:
> 
>   ir-rx51: use hrtimer instead of dmtimer (2016-06-29 21:54:35 -0700)
> 
> ----------------------------------------------------------------
> Fix a long time regression for ir-rx51 driver for n900 device tree
> booting.

Acked-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>

(sorry for taking too long to ack on that... got some VPN issues
that were solved only today)

> 
> This driver has been unusable with multiarch because of the hardware
> timer access. With the recent PWM changes, we can finally fix the
> driver for multiarch and device tree support. And naturally there
> is no rush for these for the -rc cycle, these can wait for the
> merge window.
> 
> The PWM changes have been acked by Thierry. For the media changes
> I did not get an ack from Mauro but he was Cc'd in the discussion
> and these changes do not conflict with other media changes.
> 
> After this series we can drop the remaining omap3 legacy booting
> board files finally.
> 
> ----------------------------------------------------------------
> Ivaylo Dimitrov (5):
>       ir-rx51: Fix build after multiarch changes broke it
>       pwm: omap-dmtimer: Allow for setting dmtimer clock source
>       ir-rx51: use PWM framework instead of OMAP dmtimer
>       ir-rx51: add DT support to driver
>       ir-rx51: use hrtimer instead of dmtimer
> 
>  .../devicetree/bindings/media/nokia,n900-ir        |  20 ++
>  .../devicetree/bindings/pwm/pwm-omap-dmtimer.txt   |   4 +
>  arch/arm/mach-omap2/board-rx51-peripherals.c       |   5 -
>  arch/arm/mach-omap2/pdata-quirks.c                 |  10 +-
>  drivers/media/rc/Kconfig                           |   2 +-
>  drivers/media/rc/ir-rx51.c                         | 229 +++++++--------------
>  drivers/pwm/pwm-omap-dmtimer.c                     |  12 +-
>  include/linux/platform_data/media/ir-rx51.h        |   3 -
>  8 files changed, 111 insertions(+), 174 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/nokia,n900-ir
> 


-- 
Thanks,
Mauro

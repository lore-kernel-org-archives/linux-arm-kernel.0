From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 29 Jan 2013 09:30:49 +0100
Subject: [GIT PULL] ARM: OMAP: Audio support via omap-twl4030 and pwm
 support
In-Reply-To: <50FE64DC.2030808@ti.com>
References: <50FE64DC.2030808@ti.com>
Message-ID: <510788B9.9050907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On 01/22/2013 11:07 AM, Peter Ujfalusi wrote:
> Hi Tony,
> 
> The content of this pull:
> 
> update for audio support via omap-twl4030 and pwm updates in board level:
> http://www.spinics.net/lists/linux-omap/msg85085.html
> 
> and zoom-peripherals update to not request the TWL GPIO7:
> http://www.spinics.net/lists/linux-omap/msg85187.html
> 
> All is on top of mainline v3.8-rc4 tag.

Have you already pulled this one? I can not find the patches in linux-next.

Regards,
P?ter

> 
> Regards,
> P?ter
> 
> ---
> The following changes since commit 7d1f9aeff1ee4a20b1aeb377dd0f579fe9647619:
> 
>   Linux 3.8-rc4 (2013-01-17 19:25:45 -0800)
> 
> are available in the git repository at:
> 
>   git://gitorious.org/omap-audio/linux-audio.git peter/for-tony
> 
> for you to fetch changes up to e4f4e8bfa47431b91fbb21dd9b86d9bc2c15cbd7:
> 
>   ARM: board-zoom: Do not request LCD panel enable GPIO from twl4030 (2013-01-22 10:35:16 +0100)
> 
> ----------------------------------------------------------------
> Peter Ujfalusi (9):
>       ARM: OMAP: 3430sdp: Enable extmute functionality for audio
>       ARM: OMAP: zoom: Zoom2 does not have extmute functionality
>       ARM: OMAP2+: twl-common: Add default twl4030 audio configuration
>       ARM: OMAP2+: twl-common: Allow boards to customize the twl4030 audio setup
>       ARM: OMAP: zoom: Audio support via the common omap-twl4030 machine driver
>       ARM: OMAP: sdp3430: Audio support via the common omap-twl4030 machine driver
>       ARM: OMAP: board-4430sdp: Proper support for TWL6030 PWM LED/Backlight
>       ARM: OMAP: omap3beagle: Use the pwm_leds driver to control the PMU_STAT led
>       ARM: board-zoom: Do not request LCD panel enable GPIO from twl4030
> 
>  arch/arm/mach-omap2/board-3430sdp.c          | 20 ++++++++++++++++++++
>  arch/arm/mach-omap2/board-4430sdp.c          | 30 +++++++++++++++++++++++++++++-
>  arch/arm/mach-omap2/board-cm-t35.c           |  2 +-
>  arch/arm/mach-omap2/board-devkit8000.c       |  2 +-
>  arch/arm/mach-omap2/board-igep0020.c         |  2 +-
>  arch/arm/mach-omap2/board-omap3beagle.c      | 41 ++++++++++++++++++++++++++++++++---------
>  arch/arm/mach-omap2/board-omap3evm.c         |  2 +-
>  arch/arm/mach-omap2/board-overo.c            |  2 +-
>  arch/arm/mach-omap2/board-zoom-peripherals.c | 39 +++++++++++++++++++++------------------
>  arch/arm/mach-omap2/twl-common.c             | 17 +++++++++++------
>  arch/arm/mach-omap2/twl-common.h             |  3 ++-
>  11 files changed, 120 insertions(+), 40 deletions(-)
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

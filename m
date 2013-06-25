From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 25 Jun 2013 22:08:52 +0200
Subject: [GIT PULL 1/2] Samsung cleanup PWM for v3.11
In-Reply-To: <51C9C6B3.4040003@samsung.com>
References: <51C87D32.6050607@samsung.com>
 <51C9C6B3.4040003@samsung.com>
Message-ID: <20130625200851.GA8663@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 01:34:59AM +0900, Kukjin Kim wrote:
> On 06/25/13 02:09, Kukjin Kim wrote:
> >The following changes since commit
> >db3824e6bf0b0f421b0d43f08d905935e826a965:
> >
> >ARM: SAMSUNG: Remove unused plat/regs-watchdog.h header (2013-06-19
> >03:13:18 +0900)
> >
> >are available in the git repository at:
> >
> >git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> >tags/samsung-cleanup-2
> >
> >for you to fetch changes up to 329d2fb35f05bd9255b4618813d534b8192555a4:
> >
> >ARM: SAMSUNG: Remove plat/regs-timer.h header (2013-06-25 01:13:49 +0900)
> >
> >----------------------------------------------------------------
> >based on tags/samsung-cleanup-1
> >
> >This cleanup of PWM Samsung is for:
> >1) moving remaining Samsung platforms to the new clocksource driver
> >2) removing old clocksource driver
> >3) adding new multiplatform- and DT-aware PWM driver
> >4) moving all Samsung platforms to use the new PWM driver
> >5) removing old PWM driver
> >6) removing all PWM-related code that is not used anymore
> >
> >----------------------------------------------------------------
> >Tomasz Figa (18):
> >ARM: SAMSUNG: Unify base address definitions of timer block
> >ARM: SAMSUNG: Add new PWM platform device
> >ARM: SAMSUNG: Set PWM platform data
> >clocksource: samsung_pwm_timer: Cache clocksource register address
> >clocksource: samsung_pwm_timer: Do not use clocksource_mmio
> >clocksource: samsung_pwm_timer: Handle suspend/resume correctly
> >ARM: SAMSUNG: Move all platforms to new clocksource driver
> >ARM: SAMSUNG: Remove old samsung-time driver
> >ARM: SAMSUNG: Remove unused PWM timer IRQ chip code
> >pwm: samsung: Rename to pwm-samsung-legacy
> >pwm: Add new pwm-samsung driver
> >ARM: SAMSUNG: Rework private data handling in dev-backlight
> >ARM: SAMSUNG: Modify board files to use new PWM platform device
> >pwm: Remove superseded pwm-samsung-legacy driver
> >ARM: SAMSUNG: Remove old PWM timer platform devices
> >ARM: SAMSUNG: Remove pwm-clock infrastructure
> >ARM: SAMSUNG: Remove remaining uses of plat/regs-timer.h header
> >ARM: SAMSUNG: Remove plat/regs-timer.h header
> >
> 
> [...]
> 
> >drivers/pwm/pwm-samsung.c | 694 ++++++++++++++-------
> 
> (+ Thierry Reding)
> 
> Hi Arnd and Olof
> 
> Please hold on pulling this one because Thierry Reding has objection
> on this. I think, this can be queued for next time.

If it's really just my objection keeping this back, then I'm fine with
adding the comment in a follow-up patch.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130625/9c5ae3a7/attachment-0001.sig>

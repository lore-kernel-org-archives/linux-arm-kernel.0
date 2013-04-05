From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 06 Apr 2013 00:57:04 +0200
Subject: [PATCH v4 00/14] ARM: samsung-time: Prepare for multiplatform
 support
In-Reply-To: <1365093431-30621-1-git-send-email-t.figa@samsung.com>
References: <1365093431-30621-1-git-send-email-t.figa@samsung.com>
Message-ID: <3831330.gb4oupANR9@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 of April 2013 18:36:57 Tomasz Figa wrote:
> This series is an attempt to make the samsung-time clocksource driver
> ready for multiplatform kernels. It moves the driver to
> drivers/clocksource, cleans it up from uses of static platform-specific
> definitions, simplifies timer interrupt handling and adds Device Tree
> support.
> 
> Only samsung-time driver is reworked to use the master driver at this
> time, since the PWM driver can be already considered broken at the
> moment and needs separate series of several patches to fix and clean it
> up, which I am already working on.
> 
> Tested on Universal C210 board with Device Tree. Not tested without
> Device Tree, since it has been already broken before this series.
> Compile tested for other related SoCs.
> 
> Changes since v3:
> (http://thread.gmane.org/gmane.linux.kernel.samsung-soc/16664/)
>  - Changed the design to use common (master) driver for operations that
>    can be done from both clocksource and PWM drivers (as suggested by
>    Arnd Bergmann) - needed to properly synchronize access to PWM
> registers - Moved handling of PWM prescaler and divider to master
> driver
> 
> Changes since v2:
> (http://thread.gmane.org/gmane.linux.kernel.samsung-soc/16158)
>  - Addressed comments from Rob Herring and Mark Rutland
>  - Removed unused register definitions
>  - Replaced samsung,source-timer and samsung,event-timer properties
>    with samsung,pwm-outputs property that defines which PWM channels
>    are reserved for PWM outputs on particular platform
>  - Split non-DT and DT initialization into two functions
>  - Fixed a copy paste error
> 
> Changes since v1:
> (http://thread.gmane.org/gmane.linux.kernel.samsung-soc/16005)
>  - Addressed comments from Mark Rutland
>  - Documented struct samsung_timer_variant
>  - Dropped inactive mail addresses from CC
> 
> Tomasz Figa (14):
>   ARM: SAMSUNG: Move samsung-time to drivers/clocksource
>   clocksource: samsung-time: Drop useless defines from public header
>   clocksource: samsung-time: Use local register definitions
>   mfd: Add Samsung PWM/timer master driver
>   ARM: SAMSUNG: Unify base address definitions of timer block
>   ARM: SAMSUNG: Add new PWM platform device
>   ARM: SAMSUNG: Set PWM platform data
>   clocksource: samsung-time: Use Samsung PWM/timer master driver
>   clocksource: samsung-time: Use variant data to get SoC-specific bits
>   clocksource: samsung-time: Use master driver to configure dividers
>   clocksource: samsung-time: Use clk_prepare_enable
>   clocksource: samsung-time: Use master driver to control PWM channels
>   clocksource: samsung-time: Move IRQ mask/ack handling to the driver
>   ARM: SAMSUNG: Remove unused PWM timer IRQ chip code

On FriendlyARM's Tiny6410 board (Mini6410-compatible), both with (using my 
patches adding S3C64xx Device Tree and pinctrl support) and without Device 
Tree:

Tested-by: Tomasz Figa <tomasz.figa@gmail.com>

Best regards,
Tomasz

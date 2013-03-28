From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 28 Mar 2013 23:29:05 +0100
Subject: [PATCH v3 00/12] ARM: samsung-time: Prepare for multiplatform
 support
In-Reply-To: <1362860601-18464-1-git-send-email-tomasz.figa@gmail.com>
References: <1362860601-18464-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1694481.ihC2TKNjHV@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 09 of March 2013 21:23:09 Tomasz Figa wrote:
> This series is an attempt to make the samsung-time clocksource driver
> ready for multiplatform kernels. It moves the driver to
> drivers/clocksource, cleans it up from uses of static platform-specific
> definitions, simplifies timer interrupt handling and adds Device Tree
> support.
> 
> Tested on a Tiny6410 board (Mini6410-compatible) both with and without
> Devicee Tree (with my DT patches for S3C64xx). Compile tested for other
> related SoCs.
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
> Tomasz Figa (12):
>   ARM: SAMSUNG: Move samsung-time to drivers/clocksource
>   clocksource: samsung-time: Set platform-specific parameters at runtime
> clocksource: samsung-time: Drop useless defines from public header ARM:
> SAMSUNG: Move samsung-time.h header to inlude/clocksource clocksource:
> samsung-time: Use local register definitions
>   clocksource: samsung-time: Remove use of static register mapping
>   clocksource: samsung-time: Use clk_get_sys for getting clocks
>   ARM: SAMSUNG: devs: Drop unnecessary IRQ resources of timer devices
>   clocksource: samsung-time: Do not use static IRQ definition
>   clocksource: samsung-time: Move IRQ mask/ack handling to the driver
>   ARM: SAMSUNG: Remove unused PWM timer IRQ chip code
>   clocksource: samsung-time: Add Device Tree support

Well, since this series is not merged yet, I would suggest to refrain from 
merging this version.

By the way of my other works, I have found that the case of samsung 
pwm/timer is a bit more complex than it initially seemed and it has to be 
done in a different way, to coordinate two separate drivers accessing the 
same hardware (samsung-time and pmw-samsung).

I'm currently working on next version, which is going to rework the pwm-
samsung driver as well.

Best regards,
Tomasz

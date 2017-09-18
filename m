From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 18 Sep 2017 23:50:11 +0200
Subject: [PATCH 0/4] arm64: Add initial Actions Semi S700 and CubieBoard7
 support
In-Reply-To: <20170911022241.11603-1-afaerber@suse.de>
References: <20170911022241.11603-1-afaerber@suse.de>
Message-ID: <6beabaab-d95f-4ac9-96f1-7c1c98bd7811@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,


On 11/09/2017 04:22, Andreas F?rber wrote:
> Hello,
> 
> This series prepares the Actions Semi S700 SoC and Cubietech CubieBoard7.
> It boots equally far as the S900 based Bubblegum-96 these patches are based on,
> i.e. into an initrd with serial and all four cores up.
> 
> I have not yet managed to download the CubieBoard7 sources from Baidu, and the
> Mega download has not yet been fixed, so this is based on the S700 datasheet
> and /proc/device-tree/ from the preinstalled Android.
> 
> Lacking sources and instructions to replace the bootloader on eMMC or to try
> booting from SD, the only working way I've found to boot mainline kernels
> appears to be booting into Android, then issuing "reboot bootloader". U-Boot
> is lacking the saveenv command, so it wasn't possible to change the bootdelay
> to facilitate this.
> 
> Cf. https://en.opensuse.org/HCL:CubieBoard7
> 
> Work branch:
> https://github.com/afaerber/linux/commits/bg96-next
> 
> Have a lot of fun!
> 
> Cheers,
> Andreas
> 
> Cc: Ahha Lee <lee@cubietech.com>
> Cc: support at cubietech.com
> 
> Cc: devicetree at vger.kernel.org
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> 
> Andreas F?rber (4):
>   dt-bindings: arm: actions: Add S700 and CubieBoard7
>   dt-bindings: timer: Add Actions Semi S700
>   clocksource: owl: Prepare S700
>   arm64: dts: actions: Add S700 and CubieBoard7
> 
>  Documentation/devicetree/bindings/arm/actions.txt  |  15 ++
>  .../bindings/timer/actions,owl-timer.txt           |   1 +

Usually sub system maintainers are also Cc'ed with Dt bindings
definitions and usage.

>  arch/arm64/boot/dts/actions/Makefile               |   2 +
>  arch/arm64/boot/dts/actions/s700-cubieboard7.dts   |  47 ++++++
>  arch/arm64/boot/dts/actions/s700.dtsi              | 164 +++++++++++++++++++++
>  drivers/clocksource/owl-timer.c                    |   1 +
>  6 files changed, 230 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/actions/s700-cubieboard7.dts
>  create mode 100644 arch/arm64/boot/dts/actions/s700.dtsi
> 


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

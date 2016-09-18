From: ayaka@soulik.info (ayaka)
Date: Sun, 18 Sep 2016 17:46:23 +0800
Subject: [PATCH v6 2/3] ARM: dts: add TOPEET itop elite based board
In-Reply-To: <1e4335db-9004-bb7c-6dc1-e435e66b8126@osg.samsung.com>
References: <1473285535-21996-1-git-send-email-ayaka@soulik.info>
 <1473285535-21996-3-git-send-email-ayaka@soulik.info>
 <CGME20160916072303eucas1p2941ba2907605055f5ea5abb2e6891d77@eucas1p2.samsung.com>
 <6bd9905d-0818-a917-8b8e-6abce134a3d3@kernel.org>
 <865b9f84-385f-fea8-2e3d-2b31e3bfe84c@soulik.info>
 <20160916172110.GA7511@kozik-lap>
 <1e4335db-9004-bb7c-6dc1-e435e66b8126@osg.samsung.com>
Message-ID: <9c542a0d-6237-164f-847f-d68ebc267fce@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/17/2016 02:09 AM, Javier Martinez Canillas wrote:
> Hello Randy,
>
> On 09/16/2016 01:21 PM, Krzysztof Kozlowski wrote:
>
> [snip]
>
>>>>> +	
>>>>> +	beep {
>>>>> +		compatible = "pwm-beeper";
>>>>> +		pwms = <&pwm 0 4000000 PWM_POLARITY_INVERTED>;
>>>> I have serious doubts that you run this code... if it does not even
>>>> compile. Sorry, I cannot accept code that does not compile and was not
>>>> tested.
>>>>
>>>> Please, test your DTS on top of current Linux tree, which would be one of:
>>>> 1. Linus' master branch: v4.8-rc6,
>>>> 2. one of my branches (for-next, next/dt etc),
>>> When I sent those patches, I tested in "Add linux-next specific files for
>>> 20160907"
>> OK, good, but please tell me why kbuild reported that build error?
>>
> I agree with Krzysztof, it doesn't seem that you tested the exact version
I am sure I does.
> that was posted. You will need the following change to make the DTS build
> in latest linux-next:
I didn't post the patch is WIP, which would adding the LCD panel support 
to this board.
>
> diff --git a/arch/arm/boot/dts/exynos4412-itop-elite.dts b/arch/arm/boot/dts/exynos4412-itop-elite.dts
> index dd83689892ff..8559f891a740 100644
> --- a/arch/arm/boot/dts/exynos4412-itop-elite.dts
> +++ b/arch/arm/boot/dts/exynos4412-itop-elite.dts
> @@ -14,6 +14,7 @@
>   */
>   
>   /dts-v1/;
> +#include <dt-bindings/pwm/pwm.h>
>   #include <dt-bindings/sound/samsung-i2s.h>
>   #include "exynos4412-itop-scp-core.dtsi"
>
> So please squash that change and resend.
I would, but I meet a problem in memory with the latest next-20160916, 
it seems that it can't access the memory while it never happened before.
MMC read: dev # 1, block # 2048, count 14336 ...14336 blocks read: 
OK                                                     [58/426]
Boot with zImage

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0xa00
[    0.000000] Linux version 4.8.0-rc6-next-20160916-00004-gae92137 
(ayaka at ritsuko) (gcc version 6.1.0 (Buildroot 2016.05-00006-g0
792d0d-dirty) ) #83 SMP PREEMPT Sun Sep 18 17:29:56 CST 2016
[    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), 
cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing 
instruction cache
[    0.000000] OF: fdt:Machine model: TOPEET iTop 4412 Elite board based 
on Exynos4412
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] OF: reserved mem: failed to allocate memory for node 
'region_mfc_right'
[    0.000000] OF: reserved mem: failed to allocate memory for node 
'region_mfc_left'
[    0.000000] cma: Failed to reserve 32 MiB
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] Kernel panic - not syncing: ERROR: Failed to allocate 
0x2000 bytes below 0x0.
[    0.000000]
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 
4.8.0-rc6-next-20160916-00004-gae92137 #83
[    0.000000] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[    0.000000] [<c010e17c>] (unwind_backtrace) from [<c010af78>] 
(show_stack+0x10/0x14)
[    0.000000] [<c010af78>] (show_stack) from [<c03080e4>] 
(dump_stack+0x70/0x8c)
[    0.000000] [<c03080e4>] (dump_stack) from [<c019e580>] 
(panic+0xc4/0x244)
[    0.000000] [<c019e580>] (panic) from [<c0810e3c>] 
(memblock_alloc_base+0x2c/0x38)
[    0.000000] [<c0810e3c>] (memblock_alloc_base) from [<c0806aec>] 
(early_alloc_aligned+0xc/0x2c)
[    0.000000] [<c0806aec>] (early_alloc_aligned) from [<c08074c8>] 
(paging_init+0x548/0xa70)
[    0.000000] [<c08074c8>] (paging_init) from [<c0803dc8>] 
(setup_arch+0x50c/0xa28)
[    0.000000] [<c0803dc8>] (setup_arch) from [<c080091c>] 
(start_kernel+0x50/0x384)
[    0.000000] [<c080091c>] (start_kernel) from [<4000807c>] (0x4000807c)
[    0.000000] ---[ end Kernel panic - not syncing: ERROR: Failed to 
allocate 0x2000 bytes below 0x0.
[    0.000000

>
> Best regards,

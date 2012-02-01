From: k.lewandowsk@samsung.com (Karol Lewandowski)
Date: Wed, 01 Feb 2012 19:26:04 +0100
Subject: [PATCH] gpio: samsung: adapt to changes in gpio specifier
 translator function declaration
In-Reply-To: <1328101352-22274-1-git-send-email-thomas.abraham@linaro.org>
References: <1328101352-22274-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <4F2983BC.40207@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01.02.2012 14:02, Thomas Abraham wrote:
> Commit 15c9a0acc3f7 (of: create of_phandle_args to simplify return of phandle
> parsing data) modifies the parameter list of of_xlate function pointer declaration
> in gpio_chip. Adapt the gpio specifier translate function for this change.
>
> Reported-by: Tushar Behera<tushar.behera@linaro.org>
> Signed-off-by: Thomas Abraham<thomas.abraham@linaro.org>

Tested-by: Karol Lewandowski <k.lewandowsk@samsung.com>

Fixes following Oops in i2c-s3c24xx.

Thanks


<1>Unable to handle kernel NULL pointer dereference at virtual address 
00000000
<1>pgd = c0004000
<1>[00000000] *pgd=00000000
<0>Internal error: Oops: 5 [#1] PREEMPT SMP
<d>Modules linked in:
CPU: 0    Tainted: G        W     (3.3.0-rc1+ #20)
PC is at exynos4_gpio_xlate+0x18/0xe8
LR is at of_get_named_gpio_flags+0xd0/0x190
pc : [<c025dd60>]    lr : [<c03423a0>]    psr: 60000013
sp : e9047d88  ip : e9047da8  fp : e9047da4
r10: 00000000  r9 : 00000000  r8 : c05ecf4c
r7 : c0864ca8  r6 : 00000000  r5 : e9047db0  r4 : c025dd48
r3 : 00000004  r2 : 00000000  r1 : e9047db0  r0 : c05ecf4c
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c53c7d  Table: 4000404a  DAC: 00000015
<0>Process swapper/0 (pid: 1, stack limit = 0xe90462f0)
<0>Stack: (0xe9047d88 to 0xe9048000)
...
[<c025dd60>] (exynos4_gpio_xlate+0x18/0xe8) from [<c03423a0>] 
(of_get_named_gpio_flags+0xd0/0x190)
[<c03423a0>] (of_get_named_gpio_flags+0xd0/0x190) from [<c02e77cc>] 
(s3c24xx_i2c_init+0x264/0x430)
[<c02e77cc>] (s3c24xx_i2c_init+0x264/0x430) from [<c02e7c24>] 
(s3c24xx_i2c_probe+0x1c8/0x4ac)
[<c02e7c24>] (s3c24xx_i2c_probe+0x1c8/0x4ac) from [<c02a4320>] 
(platform_drv_probe+0x28/0x2c)

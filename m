From: swexru@gmail.com (Alexey Mednyy)
Date: Wed, 10 Jun 2015 13:26:36 +0300
Subject: i.mx53 suspend/resume mainline kernel
Message-ID: <CAC3zGv_nAOSN6pOJb+4tmObtjoWmMpbo2s1a1cddEXiTkjprsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all!

Looks like suspend/resume not working right on i.mx53 soc in mainline kernel.
For some reason SOC is not suspending and hangs somewhere before
actual low power mode.

I've put printk's all over imx5 suspend code:

static int mx5_suspend_enter(suspend_state_t state) from pm-imx5.c
and I see printk message right before
cpu_do_idle() function which is macro really calls cpu_v7_do_idle from proc-v7.S

And I don't see that CPU pulls STANDBY pad in any way, pmic don't know
anything about cpu low power mode.
Also clocks remain on.
So, is problem somewhere in those 3 ARM instructions?

dsb @ WFI may enter a low-power mode
wfi
ret lr

Have no idea where to move next...

_________________________________
Best regards, Mednyy Alexey.

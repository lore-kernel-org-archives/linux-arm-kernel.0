From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 4 Jul 2017 16:09:48 +0200 (CEST)
Subject: [PATCH V3 2/2] timer: imx-tpm: add imx tpm timer support
In-Reply-To: <1499176823-4421-3-git-send-email-aisheng.dong@nxp.com>
References: <1499176823-4421-1-git-send-email-aisheng.dong@nxp.com>
 <1499176823-4421-3-git-send-email-aisheng.dong@nxp.com>
Message-ID: <alpine.DEB.2.20.1707041603571.9000@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Jul 2017, Dong Aisheng wrote:

> IMX Timer/PWM Module (TPM) supports both timer and pwm function while
> this patch only adds the timer support. PWM would be added later.
> 
> The TPM counter, compare and capture registers are clocked by an
> asynchronous clock that can remain enabled in low power modes.
> 
> Due to the possible bus fabric contention, the CNT write may
> take a few more cycles and we need add ETIME check in case current
> delta event program gets missed.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Anson Huang <Anson.Huang@nxp.com>
> Cc: Bai Ping <ping.bai@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> ---
> ChangeLog:
> v2->v3:
>  * address all comments from Daniel Lezcano
>  * add more explaination on ETIME check in commit message

Actually the logic wants to be explained in a comment inside the function
as well.

I'm really impressed, that 10 years after we discovered the HPET disaster
(See comment in arch/x86/kernel/hpet.c::hpet_next_event) the same hardware
idiocy comes around again....

Thanks,

	tglx

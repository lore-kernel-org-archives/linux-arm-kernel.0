From: aisheng.dong@nxp.com (A.s. Dong)
Date: Tue, 4 Jul 2017 14:27:39 +0000
Subject: [PATCH V3 2/2] timer: imx-tpm: add imx tpm timer support
In-Reply-To: <alpine.DEB.2.20.1707041603571.9000@nanos>
References: <1499176823-4421-1-git-send-email-aisheng.dong@nxp.com>
 <1499176823-4421-3-git-send-email-aisheng.dong@nxp.com>
 <alpine.DEB.2.20.1707041603571.9000@nanos>
Message-ID: <AM3PR04MB3061653B4CF496CD1A4FAE280D70@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Thomas Gleixner [mailto:tglx at linutronix.de]
> Sent: Tuesday, July 04, 2017 10:10 PM
> To: A.s. Dong
> Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> daniel.lezcano at linaro.org; shawnguo at kernel.org; Jacky Bai; Anson Huang;
> dongas86 at gmail.com; kernel at pengutronix.de; Arnd Bergmann; Anson Huang
> Subject: Re: [PATCH V3 2/2] timer: imx-tpm: add imx tpm timer support
> 
> On Tue, 4 Jul 2017, Dong Aisheng wrote:
> 
> > IMX Timer/PWM Module (TPM) supports both timer and pwm function while
> > this patch only adds the timer support. PWM would be added later.
> >
> > The TPM counter, compare and capture registers are clocked by an
> > asynchronous clock that can remain enabled in low power modes.
> >
> > Due to the possible bus fabric contention, the CNT write may take a
> > few more cycles and we need add ETIME check in case current delta
> > event program gets missed.
> >
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Anson Huang <Anson.Huang@nxp.com>
> > Cc: Bai Ping <ping.bai@nxp.com>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> >
> > ---
> > ChangeLog:
> > v2->v3:
> >  * address all comments from Daniel Lezcano
> >  * add more explaination on ETIME check in commit message
> 
> Actually the logic wants to be explained in a comment inside the function
> as well.
> 

Good suggestion, will add them inside function as well.

> I'm really impressed, that 10 years after we discovered the HPET disaster
> (See comment in arch/x86/kernel/hpet.c::hpet_next_event) the same
> hardware idiocy comes around again....
> 

Not quite sure but seems a bit different issue.
The issue is still uncertain but the test shows it's related to fabric priority
Configuration, if increase the A7 core priority higher than GPU, the issue
is very hard to be seen. But we don't want to change the default priority,
we use ETIME check to fix it.

Probably I would be better add a FIXME prefix before the comments in code
as well because it's still uncertain.

Regards
Dong Aisheng

> Thanks,
> 
> 	tglx
> 

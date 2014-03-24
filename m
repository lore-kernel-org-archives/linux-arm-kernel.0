From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 24 Mar 2014 20:44:01 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzJdIEFSTTogY2xwczcxMXg6IEFkZCBjcHVpZGxlIGRy?=
 =?UTF-8?B?aXZlcg==?=
In-Reply-To: <53305094.8010008@linaro.org>
References: <1395467076-29462-1-git-send-email-shc_work@mail.ru>
 <53305094.8010008@linaro.org>
Message-ID: <1395679441.129942365@f386.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mon, 24 Mar 2014 16:34:44 +0100 ?? Daniel Lezcano <daniel.lezcano@linaro.org>:
> On 03/22/2014 06:44 AM, Alexander Shiyan wrote:
> > Add cpuidle support for ARM Cirrus Logic CLPS711X CPUs.
> > This CPU has an unique internal register and write to this location
> > will put the system into the Idle State by halting the clock to the
> > processor until an interrupt is generated.
> >
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ---
...
> > +static struct cpuidle_driver clps711x_idle_driver = {
> > +	.name		= CLPS711X_CPUIDLE_NAME,
> > +	.owner		= THIS_MODULE,
> > +	.states[0]	= {
> > +		.name		= "HALT",
> > +		.desc		= "CLPS711X HALT",
> > +		.enter		= clps711x_cpuidle_halt,
> > +		.exit_latency	= 1,
> 
> Did you forget target_residency ? Or just not defined it as it is 0 ?

Yes, zero value.

---

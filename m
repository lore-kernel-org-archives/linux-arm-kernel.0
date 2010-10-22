From: radoslav.kolev@rnd.bg (Radoslav Kolev)
Date: Fri, 22 Oct 2010 15:26:17 +0300
Subject: [PATCH] mx3: Enable PWM clock on mx31 and mx35
In-Reply-To: <4CC17DA2.6020601@eukrea.com>
References: <396642.10697.qm@web51007.mail.re2.yahoo.com>
	<4CC17DA2.6020601@eukrea.com>
Message-ID: <1287750377.2441.5.camel@rado-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-10-22 at 14:03 +0200, Eric B?nard wrote:
> Hi Fabio,
> 
> Le 22/10/2010 13:13, Fabio Estevam a ?crit :
> > mx3: Enable PWM clock on mx31 and mx35.
> >
> Are you sure this in needed as when using the pwm.c driver in plat-mxc there 
> are pwm_enable and pwm_disable functions ?
> 
> With your patch, platforms without PWM will have the pwm clock enabled.

Fabio, sorry if I have mislead you.

I wasn't properly using the plat-mxc/pwm.c driver (and hence the
enable/disable functions were not getting called). I was just mucking
about with the registers directly, first from userspace and then by
putting some code in the driver probe function. So it was really strange
for me that I couldn't do any writes.

If the plat-mxc/pwm.c driver is used properly I guess this patch won't
be needed.

Regards,
Radoslav Kolev

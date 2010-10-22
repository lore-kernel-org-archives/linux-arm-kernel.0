From: radoslav.kolev@rnd.bg (Radoslav Kolev)
Date: Fri, 22 Oct 2010 13:13:59 +0300
Subject: imx: PWM module on mx35
In-Reply-To: <AANLkTi=p1y9aAodOBu=kskGnXUu-fZ_snL+Y9R=5-Gck@mail.gmail.com>
References: <1287700257.4822.29.camel@rado-desktop>
	<AANLkTi=p1y9aAodOBu=kskGnXUu-fZ_snL+Y9R=5-Gck@mail.gmail.com>
Message-ID: <1287742439.2441.0.camel@rado-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-10-21 at 23:10 -0200, Fabio Estevam wrote:
> Hi Radoslav,
> 
> On Thu, Oct 21, 2010 at 8:30 PM, Radoslav Kolev <radoslav.kolev@rnd.bg> wrote:
> > Hello,
> >
> > I am trying to use the PWM module on a Freescale MX35 SOC but all writes
> > to the PWM module registers seem to be ignored.
> >
> > I have found two issues reported as fixed in the changelog of
> > Freescales's Linux BSP for the i.MX31ADS (with similar PWM module) at
> > http://www.freescale.com/files/soft_dev_tools/doc/support_info/BSPIMX31ADSLTIB__RN.txt
> >
> > 851     Unable to write to PWM registers
> > 1438    Cannot write to PWM registers
> 
> These patches fixed the MXC_CCM_CGR1 offset for the pwm_clk in the
> Freescale kernel.
> 
> Another thing that was needed was to enable the PWM clock.
> 
> Please try the patch below.
> 

Thanks, Fabio!

That solved the register writing problem.

Regards,
Radoslav Kolev

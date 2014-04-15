From: horms@verge.net.au (Simon Horman)
Date: Tue, 15 Apr 2014 16:14:31 +0900
Subject: [PATCHv2 07/11] ARM: OMAP3: Beagle: use PWM_LOOKUP to initialize
 struct pwm_lookup
In-Reply-To: <534CD958.4000303@ti.com>
References: <1397512793-10325-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1397512793-10325-8-git-send-email-alexandre.belloni@free-electrons.com>
 <534CD958.4000303@ti.com>
Message-ID: <20140415071430.GA13659@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 10:01:44AM +0300, Peter Ujfalusi wrote:
> On 04/15/2014 12:59 AM, Alexandre Belloni wrote:
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > ---
> >  arch/arm/mach-omap2/board-omap3beagle.c | 10 ++--------
> >  1 file changed, 2 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> > index f27e1ec90b5e..54c135a5b4f7 100644
> > --- a/arch/arm/mach-omap2/board-omap3beagle.c
> > +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> > @@ -61,14 +61,8 @@
> >  
> >  static struct pwm_lookup pwm_lookup[] = {
> >  	/* LEDB -> PMU_STAT */
> > -	{
> > -		.provider = "twl-pwmled",
> > -		.index = 1,
> > -		.dev_id = "leds_pwm",
> > -		.con_id = "beagleboard::pmu_stat",
> > -		.period = 7812500,
> > -		.polarity = PWM_POLARITY_NORMAL,
> > -	},
> > +	PWM_LOOKUP("twl-pwmled", 1, "leds_pwm", "beagleboard::pmu_stat",
> > +		   7812500, PWM_POLARITY_NORMAL),
> 
> Why do you need to do this in two steps?
> In patch 4 you removed the existing PWM_LOOKUP() and now you are adding it back.
> Would not be simpler if you just add the two new parameters in patch 4 (the
> 812500, PWM_POLARITY_NORMAL)?

Such an approach would apply an atomic change to both the infrastructure
and the users.

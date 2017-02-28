From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 28 Feb 2017 18:42:05 +0100
Subject: [PATCH v3 05/25] clocksource: owl: Add S900 support
In-Reply-To: <6fffb7b4-6346-ffb2-ba2c-d6feed0e1294@suse.de>
References: <20170228063535.32069-1-afaerber@suse.de>
 <20170228063535.32069-6-afaerber@suse.de>
 <6fffb7b4-6346-ffb2-ba2c-d6feed0e1294@suse.de>
Message-ID: <20170228174205.GE30601@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2017 at 06:16:10PM +0100, Andreas F?rber wrote:
> Daniel,
> 
> Am 28.02.2017 um 07:35 schrieb Andreas F?rber:
> > The Actions Semi S900 SoC provides four 32-bit timers, TIMER0/1/2/3,
> > but no 2Hz timers.
> > 
> > Deal with the S500 having less timers.
> > 
> > An S900 datasheet can be found in 96Boards documentation:
> > https://github.com/96boards/documentation/blob/master/ConsumerEdition/Bubblegum-96/HardwareDocs/SoC_bubblegum96.pdf
> > 
> > Signed-off-by: Andreas F?rber <afaerber@suse.de>
> [...]
> > @@ -126,10 +127,20 @@ static irqreturn_t owl_timer1_interrupt(int irq, void *dev_id)
> >  static const struct owl_timer_info s500_timer_info = {
> >  	.timer_offset[0] = 0x08,
> >  	.timer_offset[1] = 0x14,
> > +	.timer_offset[2] = -1,
> > +	.timer_offset[3] = -1,
> > +};
> > +
> > +static const struct owl_timer_info s900_timer_info = {
> > +	.timer_offset[0] = 0x08,
> > +	.timer_offset[1] = 0x14,
> > +	.timer_offset[2] = 0x30,
> > +	.timer_offset[3] = 0x3c,
> >  };
> 
> I noticed later that the S900 manual describes TIMER2/3 as "used only in
> Secure mode". My driver code resetting them seems to work though.
> 
> Should we just drop these extra timer initializations then to make the
> driver simpler and more performant again? I'd still like to keep the two
> compatible strings in the DT though, and we may want to disable the 2Hz
> timers on S500 just in case.

Yes, makes sense.

> -- 
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
> GF: Felix Imend?rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N?rnberg)

-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 11 May 2015 11:54:33 +0100
Subject: [rtc-linux] [PATCH 07/12] rtc: st: Update IP layout information
 to include Clocksource
In-Reply-To: <20150509135854.GE3338@piout.net>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
 <1431005924-21777-8-git-send-email-lee.jones@linaro.org>
 <20150509135854.GE3338@piout.net>
Message-ID: <20150511105433.GB20742@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 09 May 2015, Alexandre Belloni wrote:

> On 07/05/2015 at 14:38:39 +0100, Lee Jones wrote :
> > Initial submission adding support for this IP only included Watchdog and
> > the Real-Time Clock.  Now the third (and final) device is enabled this
> > trivial patch is required to update the comment in the RTC driver to
> > encompass Clocksource.
> > 
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Thanks.

> I'm guessing this will go through the mfd tree along with the driver?

Yes, that is the plan, if that's okay with you?

> > ---
> >  drivers/rtc/rtc-st-lpc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/rtc/rtc-st-lpc.c b/drivers/rtc/rtc-st-lpc.c
> > index 3f9d0ac..74c0a33 100644
> > --- a/drivers/rtc/rtc-st-lpc.c
> > +++ b/drivers/rtc/rtc-st-lpc.c
> > @@ -208,7 +208,7 @@ static int st_rtc_probe(struct platform_device *pdev)
> >  		return -EINVAL;
> >  	}
> >  
> > -	/* LPC can either run in RTC or WDT mode */
> > +	/* LPC can either run as a Clocksource or in RTC or WDT mode */
> >  	if (mode != ST_LPC_MODE_RTC)
> >  		return -ENODEV;
> >  
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

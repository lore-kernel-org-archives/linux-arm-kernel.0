From: jbe@pengutronix.de (Juergen Beisert)
Date: Mon, 24 Feb 2014 15:38:26 +0100
Subject: [PATCHv6] staging/iio/adc: change the MXS touchscreen driver
 implementation
In-Reply-To: <20140224133316.GI26722@mwanda>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
 <201402241416.24270.jbe@pengutronix.de> <20140224133316.GI26722@mwanda>
Message-ID: <201402241538.26530.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dan,

On Monday 24 February 2014 14:33:16 Dan Carpenter wrote:
> On Mon, Feb 24, 2014 at 02:16:24PM +0100, Juergen Beisert wrote:
> > > While I don't have much experience with the TS part of the code but I
> > > can investigate if you don't have any idea.
> >
> > can you please test the following patch?
> > After releasing the touchscreen the internal state machine was left in a
> > wrong state.
> >
> > diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> > index e2dd783..558a76c 100644
> > --- a/drivers/staging/iio/adc/mxs-lradc.c  
> > +++ b/drivers/staging/iio/adc/mxs-lradc.c
> > @@ -698,6 +698,7 @@ static void mxs_lradc_finish_touch_event(struct
> > mxs_lradc *lradc, bool valid) }
> >
> >         /* if it is released, wait for the next touch via IRQ */
> > +       lradc->cur_plate = LRADC_TOUCH;
> >         mxs_lradc_reg_clear(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ, LRADC_CTRL1);
> >         mxs_lradc_reg_set(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ_EN, LRADC_CTRL1);
> >         } 
>
> I am confused.  Why don't you send this like a normal patch?

For testing fist. But you are right, patch will follow.

Regards,
Juergen

-- 
Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| Juergen Beisert ? ? ? ? ? ? |
Linux Solutions for Science and Industry ? ? ?| http://www.pengutronix.de/  |

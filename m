From: jbe@pengutronix.de (=?utf-8?q?J=C3=BCrgen_Beisert?=)
Date: Mon, 23 Sep 2013 16:05:03 +0200
Subject: [PATCHv5] staging/iio/adc: change the MXS touchscreen driver
 implementation
In-Reply-To: <21056.17602.24566.144289@ipc1.ka-ro>
References: <1379593369-22010-1-git-send-email-jbe@pengutronix.de>
 <201309231524.38008.jbe@pengutronix.de> <21056.17602.24566.144289@ipc1.ka-ro>
Message-ID: <201309231605.03860.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar,

On Monday 23 September 2013 15:40:18 Lothar Wa?mann wrote:
> J?rgen Beisert writes:
> > The i.MX28 manual says the LRADC delay unit is driven by a 2 kHz clock,
> > but does not say what kind of clock it is (or is derived from). I guess
> > now, this clock isn't enabled and thus the delay unit can't work. At
> > least on the MX28EVK. On your TX28 platform the clock seems enabled and
> > the delay unit can do its job and drive the state machine.
>
> The i.MX28 Ref Manual states in chapter 38.5.14 LRADC Scheduling Delay:
> | This counter operates on a 2KHz clock derived from crystal clock.
>
> Thus the clock should always be enabled.

But it isn't always on. I have now added the correct clock_get() call to the 
LRADC driver and the touchscreen works again on the MX28EVK. New patch series 
will follow. Same is required for i.MX23.

Regards,
Juergen

-- 
Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| Juergen Beisert ? ? ? ? ? ? |
Linux Solutions for Science and Industry ? ? ?| http://www.pengutronix.de/  |

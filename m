From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 25 Apr 2014 16:11:11 +0200
Subject: [PATCH] pwm: mxs: set pwm_chip can_sleep flag
In-Reply-To: <20140409143516.GW29751@pengutronix.de>
References: <1396956597-26159-1-git-send-email-shawn.guo@freescale.com>
 <5343FDD3.3070308@i2se.com> <20140408175904.GT29751@pengutronix.de>
 <20140408234243.GB13898@piout.net> <20140409082341.GV29751@pengutronix.de>
 <20140409100313.GA20704@piout.net> <20140409104652.GC9527@ulmo>
 <20140409143516.GW29751@pengutronix.de>
Message-ID: <535A6CFF.2020800@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 09.04.2014 16:35, schrieb Uwe Kleine-K?nig:
> Hello,
>
> On Wed, Apr 09, 2014 at 12:46:53PM +0200, Thierry Reding wrote:
>>
>> My preference would be simply d). Mostly because I don't like special
>> cases and especially because I don't see an advantage in special casing
>> 0 and full period duty cycles. That doesn't mean of course that drivers
>> can't special case if they really want or have to.
> Well d' is just an optimisation, because if you have a duty cycle
> between 0 and full (exclusive) and no other means of syncronisation
> you cannot influence where pwm_disable stops the output, at low or high.
>
> Do we have cases where pwm_disable makes the pin high-z? Or something
> else which violates the assumption "pwm_config(pwm, 0, period);
> pwm_disable(pwm); makes the pin 0"?
>  
>> That said I've also been thinking about adding support for e), which
>> would allow atomically changing the duty cycle, period and polarity of a
>> channel. This might become necessary at some point.
> On i.MX28 you cannot change atomically, only program atomically. The
> current period will end regularily anyhow as programmed before. But
> maybe that's what you mean?!
>
> Best regards
> Uwe
>

i want to ask gently, if somebody working on this issue?

Regards,
Stefan Wahren

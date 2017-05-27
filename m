From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sun, 28 May 2017 01:11:42 +0300
Subject: [PATCH 1/2] drivers: pwm: core: implement pwm mode
In-Reply-To: <1494332153-14534-2-git-send-email-claudiu.beznea@microchip.com>
References: <1494332153-14534-1-git-send-email-claudiu.beznea@microchip.com>
 <1494332153-14534-2-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <CAHp75VdSGLwryheu2RFg8N7U6qbEf--HmRFG5pa5CzFwJqWdfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 9, 2017 at 3:15 PM, Claudiu Beznea
<claudiu.beznea@microchip.com> wrote:
> Extends PWM framework to support PWM modes. The currently
> implemented PWM modes were called PWM complementary mode
> and PWM push-pull mode. For devices that have more than one
> output per PWM channel:
> - PWM complementary mode is standard working mode; in PWM
> complementary mode the rising and falling edges of the
> channels outputs have opposite levels, same duration and
> same starting time.
> - in PWM push-pull mode the channles outputs has same levels,
> same duration and the rising edges are delayed until the
> beginning of the next period.
> A new member was added in pwm_state structure in order to
> keep the new PWM argument.

To me it sound over-engineered.

It looks like polarity type

I dunno if PWM supports linked / virtual channels, but it would be like that

channel X  (polarity P) effectively is

channel Xa (polarity P) / channel Xb (polarity !P)

and vise versa.

Moreover, mode in your case doesn't fit to GPIO style of output which
would be emulated or native mode for PWM (we have already a use case
and one driver implements that).

GPIO type of output is, obviously, duty=100% in case of emulation,
though separate state for HW assisted kind of that.

-- 
With Best Regards,
Andy Shevchenko

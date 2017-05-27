From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sun, 28 May 2017 01:28:45 +0300
Subject: [PATCH v2 1/2] drivers: pwm: core: implement pwm dead-times
In-Reply-To: <1494317990-9131-2-git-send-email-claudiu.beznea@microchip.com>
References: <1494317990-9131-1-git-send-email-claudiu.beznea@microchip.com>
 <1494317990-9131-2-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <CAHp75Ve=v=50UmpOyi1guY3NVuk41U0Ma+_P__5NK7_dNr6gZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 9, 2017 at 11:19 AM, Claudiu Beznea
<claudiu.beznea@microchip.com> wrote:
> Extends PWM framework to support PWM dead-times.
> The notions introduced are rising edge dead-time
> and falling edge dead-time. These are useful for
> PWM controllers with channels that have more than
> one outputs.
> The implementation add sysfs interface for
> configuration. It extends the pwm_state structure
> with two new members which keeps the values for
> dead-times.
> There were no additions in device tree for PWM channels
> initialized by device tree.

AFAIU it's effectively called phase of the signal.
It looks to me much simpler if you allow to have linked / virtual
channels instead of creating a lot of (duplicated) properties.

-- 
With Best Regards,
Andy Shevchenko

From: Ludovic.Desroches@atmel.com (Desroches, Ludovic)
Date: Fri, 23 Aug 2013 17:46:03 +0200
Subject: [PATCH v2 2/4] iio: at91: Use different prescal, startup mask in
 MR for different IP
In-Reply-To: <5215DF7C.2020909@atmel.com>
References: <1376219071-29946-1-git-send-email-josh.wu@atmel.com>
 <1376219071-29946-3-git-send-email-josh.wu@atmel.com>
 <20130815192044.GD12162@lukather> <5215DF2C.3050502@atmel.com>
 <5215DF7C.2020909@atmel.com>
Message-ID: <20130823154603.GA7468@ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Aug 22, 2013 at 05:53:00PM +0800, Josh Wu wrote:
> Add Ludovic in the loop.
> 
> On 8/22/2013 5:51 PM, Josh Wu wrote:
> >Hi, Maxime
> >
> >On 8/16/2013 3:20 AM, Maxime Ripard wrote:
> >>Hi Josh,
> >>
> >>On Sun, Aug 11, 2013 at 07:04:29PM +0800, Josh Wu wrote:
> >>>For at91 boards, there are different IPs for adc. Different IPs has
> >>>different STARTUP & PRESCAL mask in ADC_MR.
> >>>
> >>>This patch introduce the multiple compatible string for those
> >>>different IPs.
> >>>
> >>>Signed-off-by: Josh Wu <josh.wu@atmel.com>
> >>Overall it looks like the right ways, but I think we can take it a step
> >>further.
> >>
> >>I'd drop at least the atmel,adc-drdy-mask, atmel,adc-num-channels,
> >>atmel,adc-status-register, atmel,adc-trigger-register properties (and
> >>probably the triggers as well description as well).
> >
> >yeah, right. Currently I want to drop following:
> >
> >atmel,adc-drdy-mask, atmel,adc-status-register,
> >atmel,adc-trigger-register, atmel,adc-channel-base
> >
> >For the adc-num-channels, I'd like to leave it in dt parameters.
> >It is a description for an adc capablity.

About this parameter, I'll remove it too from the dt bindings. To set it you
need to have a look to the datasheet and to copy a constant value into the
dt. From my point of view, it means than this parameter should be managed by
the driver and by the dt.

On the other side since there are some dynamic allocation depending on this
parameter maybe it makes sense to keep it in the dt. If the user wants to use
only 2 channels why doing allocation for max channel number. By the way, this
case is only valid if he uses the two first channels.


> >
> >For the triggers, I am not decided. An obvious benifit to remove
> >trigger in dt will save many lines of code.
> >
> >>
> >>Maxime
> >>
> >
> >Best Regards,
> >Josh Wu
>

Since we are talking about reworking this binding I was thinking about
resolution stuff. Filling atmel,adc-res is also copying constant value from
the device datasheet, so if I was consistent I would say it has to be removed
too. But I am not consistent! I mean by doing this the only thing the user
will have to fill is the resolution value. He can't set the value he wants,
there are only two choices. By keeping it into the dt then he will immediately
see the choices he has.


Regards

Ludovic 

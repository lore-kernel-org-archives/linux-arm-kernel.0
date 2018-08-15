From: sam@ravnborg.org (Sam Ravnborg)
Date: Wed, 15 Aug 2018 22:48:15 +0200
Subject: [RFC PATCH 0/7] add at91sam9 LCDC DRM driver
In-Reply-To: <4def26df-0f4b-77e5-fea9-6c8f3537d831@axentia.se>
References: <20180812184152.GA22343@ravnborg.org>
 <f1f2a2d7-ae27-87af-8041-93d3f8fe07cc@microchip.com>
 <20180813181808.GA2357@ravnborg.org>
 <20180813220454.GA28913@rob-hp-laptop>
 <20180814164343.GA13848@ravnborg.org>
 <20180814224252.GA20667@rob-hp-laptop>
 <20180815044808.GA1806@ravnborg.org>
 <CAL_JsqLwazj=7hOwSeAtcyvnYCmMDP-Nw3H8xHSr0n3YGUS21A@mail.gmail.com>
 <CAKMK7uHm03UxLNUieJFR4TD3ppTMHwkitbQTrVq67K=Mjh6OYA@mail.gmail.com>
 <4def26df-0f4b-77e5-fea9-6c8f3537d831@axentia.se>
Message-ID: <20180815204815.GB29041@ravnborg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter.

> 
> I stopped pushing that patch for reasons mentioned in
> https://lkml.org/lkml/2018/4/9/108
> 
> However, since then, the component approach mentioned in that mail was
> shot down and instead the tda998x driver is now a bridge (or soon, I expect
> the series from Russell King that to land in 4.19-rc1) which means that the
> binding from that series is back on the table. At least I guess so? However,
> in that series the approach is that the bridge states its expected input and
> the output then adjusts to what is needed. However, the "problem" is really in
> the atmel-hlcdc output (it moves the MSB for the RGB colors around depending
> on the output mode) so I no longer subscribe to all ideas in that series
> and think it is cleaner to state the needed bus format closer to the atmel-
> hlcdc endpoint as is done e.g. in this latest series:
> 
> https://lkml.org/lkml/2018/8/10/309
> 
> This latest series uses the media/video-interface approach and specifies
> the bus-width in the endpoint. However, the bus-width is alone obviously not
> enough to differentiate rgb565 and brg565, so will not help Sam
Some digging in diverse threads required.
I may take the easy way in v2 and postpone this feature.
But you all confirmed that doing something locally in the driver is the
wrong approach so that is ruled out.

> (or is it bgr565 that Sam needs? The above quoted text is ambiguous).
My bad. I need either rgb565 or bgr565 (at lest this is how I understood
the application note from Atmel/Microchip - need to re-read this too).

Some of the IP cores have an intensify bit which I do not yet understand
how to adapt to the supported formats. This is also on the todo list.

> I think something like my bus-format binding in [3] is generic enough to
> also help Sam.
Thanks, if I find time I will look into this, but first priority is to get the
bindinns correct, and then the overall structure of the driver.

	Sam

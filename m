From: sam@ravnborg.org (Sam Ravnborg)
Date: Sun, 26 Aug 2018 16:58:01 +0200
Subject: [PATCH v1 7/7] drm: add Atmel LCDC display controller support
In-Reply-To: <8581453a-8abe-c321-17c1-493f805510b1@tronnes.org>
References: <20180812184152.GA22343@ravnborg.org>
 <20180812184629.3808-7-sam@ravnborg.org>
 <8581453a-8abe-c321-17c1-493f805510b1@tronnes.org>
Message-ID: <20180826145801.GA18144@ravnborg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Noralf.

> >+/* Configuration of individual CPU's */
> >+static const struct atmel_lcdc_dc_desc atmel_lcdc_dc_at91sam9261 = {
> >+	.guard_time = 1,
> >+	.fifo_size = 512,
> >+	.min_width = 0,
> >+	.min_height = 0,
> 
> Looks like the minimum is always zero, maybe drop it?
I kept is at in reality 0 is not an OK value.
Will revisit the datasheets and check what they say.

As for all the other comments - thanks!
I will address them in v2.

Currently working on a larger refactoring to address all
the feedback.
Things becomes simpler which is always good.

	Sam

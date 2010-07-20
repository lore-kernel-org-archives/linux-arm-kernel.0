From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 20 Jul 2010 21:34:03 +0900
Subject: [PATCH v2 5/8] ARM: S5PV310: Add Timer support
In-Reply-To: <AANLkTimirpioNZmzLoWeAD9hN0gAmWodddeMyxsdY7A6@mail.gmail.com>
References: <1279270714-15146-1-git-send-email-kgene.kim@samsung.com>
	<1279270714-15146-6-git-send-email-kgene.kim@samsung.com>
	<AANLkTimirpioNZmzLoWeAD9hN0gAmWodddeMyxsdY7A6@mail.gmail.com>
Message-ID: <003b01cb2807$df794560$9e6bd020$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> On Fri, Jul 16, 2010 at 5:58 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > From: Changhwan Youn <chaos.youn@samsung.com>
> >
> > This patch adds timer support for S5PV310.
> > Until now, all S5P SoCs use CONFIG_ARCH_USES_GETTIMEOFFSET macro as
> a default
> > configuration. Instead, S5PV310 implements clocksource and
> clock_event_device
> > to support the high resolution timer and tickless system.
> >
> > Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
> > Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---

(snip)

> > diff --git a/arch/arm/mach-s5pv310/time.c b/arch/arm/mach-s5pv310/time.c
> > new file mode 100644
> > index 0000000..64accf8
> > --- /dev/null
> > +++ b/arch/arm/mach-s5pv310/time.c
> > @@ -0,0 +1,287 @@
> > +/* linux/arch/arm/mach-s5pv310/time.c
> > + *
> > + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> > + * ? ? ? ? ? ? http://www.samsung.com
> > + *
> > + * S5PV310 (and compatible) HRT support
> > + * PWM 2/4 is used for this feature
> 
> Please make it configurable, now PWM 2 is used for I2C pin in mobile
hardware.
> It seems to smdk specific file.
> 
> Why don't use the systimer?
> 
Your suggestion looks reasonable, so will support HRT with System Timer.

(snip)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

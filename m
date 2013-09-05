From: jbe@pengutronix.de (=?iso-8859-1?q?J=FCrgen_Beisert?=)
Date: Thu, 5 Sep 2013 09:12:11 +0200
Subject: [PATCH 2/5] Staging/iio/adc/touchscreen/MXS: separate i.MX28
 specific register bits
In-Reply-To: <201309041606.34837.marex@denx.de>
References: <1378299706-6742-1-git-send-email-jbe@pengutronix.de>
 <1378299706-6742-3-git-send-email-jbe@pengutronix.de>
 <201309041606.34837.marex@denx.de>
Message-ID: <201309050912.11106.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Wednesday 04 September 2013 16:06:34 Marek Vasut wrote:
> [...]
> > +# define LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE	(1 << 23)
> > +# define LRADC_CTRL0_MX28_TOUCH_SCREEN_TYPE	(1 << 22)
> > +# define LRADC_CTRL0_MX28_YNNSW	/* YM */	(1 << 21)
> > +# define LRADC_CTRL0_MX28_YPNSW	/* YP */	(1 << 20)
> > +# define LRADC_CTRL0_MX28_YPPSW	/* YP */	(1 << 19)
> > +# define LRADC_CTRL0_MX28_XNNSW	/* XM */	(1 << 18)
> > +# define LRADC_CTRL0_MX28_XNPSW	/* XM */	(1 << 17)
> > +# define LRADC_CTRL0_MX28_XPPSW	/* XP */	(1 << 16)
>
> Why do you put this space between # and define?

Matter of taste: to visible show a difference between registers itself and
their bits inside. Its my default state to help readers to read my code.

> > [...]
> >  #define	LRADC_CTRL1				0x10
> >  #define	LRADC_CTRL1_TOUCH_DETECT_IRQ_EN		(1 << 24)
> >  #define	LRADC_CTRL1_LRADC_IRQ_EN(n)		(1 << ((n) + 16))
> > -#define	LRADC_CTRL1_LRADC_IRQ_EN_MASK		(0x1fff << 16)
> > +#define	LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK	(0x1fff << 16)
> >  #define	LRADC_CTRL1_LRADC_IRQ_EN_OFFSET		16
> >  #define	LRADC_CTRL1_TOUCH_DETECT_IRQ		(1 << 8)
> >  #define	LRADC_CTRL1_LRADC_IRQ(n)		(1 << (n))
> > -#define	LRADC_CTRL1_LRADC_IRQ_MASK		0x1fff
> > +#define	LRADC_CTRL1_MX28_LRADC_IRQ_MASK		0x1fff
>
> MIght just be easier to define this as
>
> LRADC....IRQ_MASK(id) (((id) == MX23) ? 0x1ff : 0x1fff)
>
> just like the MXS SSP driver does it. Then there won't be so much churn.

Nice. Will change it.

Regards,
Juergen

-- 
Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| Juergen Beisert ? ? ? ? ? ? |
Linux Solutions for Science and Industry ? ? ?| http://www.pengutronix.de/  |

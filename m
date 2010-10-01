From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 1 Oct 2010 11:00:51 -0700
Subject: [PATCH 1/7] pwm: Add pwm core driver
In-Reply-To: <F45880696056844FA6A73F415B568C69532DCF34AE@EXDCVYMBSTM006.EQ1STM.local>
References: <4CA1BC16.3020702@metafoo.de>
	<F45880696056844FA6A73F415B568C69532DC2FC60@EXDCVYMBSTM006.EQ1STM.local>
	<4CA25841.4090702@metafoo.de>
	<F45880696056844FA6A73F415B568C69532DC8B7E4@EXDCVYMBSTM006.EQ1STM.local>
	<AANLkTingb8ox5h5rN1YrxONibfrWLicoiS6yqKf_v5bJ@mail.gmail.com>
	<F45880696056844FA6A73F415B568C69532DCF32BC@EXDCVYMBSTM006.EQ1STM.local>
	<AANLkTikTo42Q5-yMEwyQH4mt=qLjaKrtJK3ydZNFyqai@mail.gmail.com>
	<F45880696056844FA6A73F415B568C69532DCF33BB@EXDCVYMBSTM006.EQ1STM.local>
	<AANLkTimPgPY9rX_MYZTv0PpRQgfWGoSeSE9WWy_ami-V@mail.gmail.com>
	<F45880696056844FA6A73F415B568C69532DCF34AE@EXDCVYMBSTM006.EQ1STM.local>
Message-ID: <20101001180051.GC21157@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 01, 2010 at 10:46:15AM +0200, Arun MURTHY wrote:
> > On Fri, Oct 1, 2010 at 4:25 PM, Arun MURTHY

> > > I mean not the functions but the functionality.
> > > PWM is a simple device and most of its clients are controlling
> > intensity
> > > of backlight, leds, vibrator etc.
> > > I don't think these complex functionality are required.
> > oh dear !
> Here I mean why should all those function be exposed to the entire kernel,
> as most of the pwm devices do not use them.

While many PWM uses are very simple that doesn't mean that we'll never
need to support more advanced uses.  Normally we try to design APIs so
that they both scale down to the simplest use cases and also up to more
complex ones.

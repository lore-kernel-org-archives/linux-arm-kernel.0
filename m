From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 17 Aug 2010 12:39:37 +0100
Subject: [PATCH 1/3] ASoC: add 88pm860x codec driver
In-Reply-To: <AANLkTikCqRFwn5dhVah7D9Cuu7PvUeTV_ywzZzz+DLxV@mail.gmail.com>
References: <AANLkTi=i5H_oJvXzMv71ofxyw9FFXpiXU=pgzf+rdgk0@mail.gmail.com>
	<20100817095800.GD18622@rakim.wolfsonmicro.main>
	<AANLkTi=4vfkpDF=RkTtRTUR=XP9UAmhkJyvFvowV_89O@mail.gmail.com>
	<20100817110223.GA18179@rakim.wolfsonmicro.main>
	<AANLkTikCqRFwn5dhVah7D9Cuu7PvUeTV_ywzZzz+DLxV@mail.gmail.com>
Message-ID: <20100817113937.GB18179@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 17, 2010 at 07:37:21PM +0800, Haojian Zhuang wrote:
> On Tue, Aug 17, 2010 at 7:02 PM, Mark Brown

> > As I said previously I would expect you to be using a DAPM supply widget
> > for this.

> Supply widget should be always on while DAPM is working. How about
> only enable left ADC?

What makes you say this?  A supply widget is only enabled when the
things it supplies are enabled.

> > I can't associate your comment there with the code at all. ?The code
> > does nothing different for the two case statements and there's no other
> > code I can see.

> You can find pm860x_pcm_set_dai_fmt() and pm860x_i2s_set_dai_fmt().
> Both functions called set_dai_fmt(). In set_dai_fmt(), all bit
> operations are based on variable, not registers. Register operation is
> implemented in pcm_set_dai_fmt() and i2s_set_dai_fmt().

You need to move this code into the individual functions.  What you've
got now is clearly buggy - it will accept either configuration when it
sets the variable.

> >> > entirely if you're not going to implement jack detection. ?Right now all
> >> > the curernt code will do is waste power by enabling the feature but
> >> > ignoring the result.

> >> I need a document on illustrating jack on alsa. Could you share one?

> > There's a number of in tree examples - seach for snd_soc_jack.

> OK. How to test it? Still no document?

A standard API input test application such as evtest can be used.

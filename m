From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 7 Jun 2016 18:33:36 +0200
Subject: [PATCH 07/34] clk: berlin: Migrate to clk_hw based registration
 and OF APIs
In-Reply-To: <146528884761.28742.8093002152658120585@sboyd-linaro>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
 <20160601231533.9354-8-stephen.boyd@linaro.org>
 <20160605174157.GP4594@piout.net>
 <146528884761.28742.8093002152658120585@sboyd-linaro>
Message-ID: <20160607163336.GM3363@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2016 at 01:40:47 -0700, Stephen Boyd wrote :
> Quoting Alexandre Belloni (2016-06-05 10:41:57)
> > Hi,
> > 
> > The main drawback of those patches is that they break the alignment
> > (checkpatch.pl --strict complains).
> 
> Didn't checkpatch --strict already warn on these files though? I'm not
> sure I've done anything to break the alignment style here.
> 

As you change the function return value, the function arguments are no
longer aligned with the opening parenthesis.
I would agree that keeping the alignment will make the change quit
bigger though.

> > 
> > On 01/06/2016 at 16:15:06 -0700, Stephen Boyd wrote :
> > > diff --git a/drivers/clk/berlin/berlin2-avpll.h b/drivers/clk/berlin/berlin2-avpll.h
> > > index a37f5068d299..17e311153b42 100644
> > > --- a/drivers/clk/berlin/berlin2-avpll.h
> > > +++ b/drivers/clk/berlin/berlin2-avpll.h
> > > @@ -19,17 +19,13 @@
> > >  #ifndef __BERLIN2_AVPLL_H
> > >  #define __BERLIN2_AVPLL_H
> > >  
> > > -struct clk;
> > > -
> > >  #define BERLIN2_AVPLL_BIT_QUIRK              BIT(0)
> > >  #define BERLIN2_AVPLL_SCRAMBLE_QUIRK BIT(1)
> > >  
> > > -struct clk * __init
> > > -berlin2_avpll_vco_register(void __iomem *base, const char *name,
> > > +int berlin2_avpll_vco_register(void __iomem *base, const char *name,
> > 
> > This is missing __init.
> 
> Ah I also removed __init in the header file here because it doesn't do
> anything. I guess I should mention that in the commit text.

Indeed, you are right.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

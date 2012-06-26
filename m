From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Tue, 26 Jun 2012 14:07:48 +0000
Subject: [PATCH V2] ASoC: tlv320aic3x: Fix codec pll configure bug
In-Reply-To: <20120626085403.GH30406@opensource.wolfsonmicro.com>
References: <1340690623-18177-1-git-send-email-gururaja.hebbar@ti.com>
 <20120626085403.GH30406@opensource.wolfsonmicro.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA2D2A2@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2012 at 14:24:03, Mark Brown wrote:
> On Tue, Jun 26, 2012 at 11:33:43AM +0530, Hebbar, Gururaja wrote:
> > In sound/soc/codecs/tlv320aic3x.c
> > 
> >         data = snd_soc_read(codec, AIC3X_PLL_PROGA_REG);
> >         snd_soc_write(codec, AIC3X_PLL_PROGA_REG,
> >                       data | (pll_p << PLLP_SHIFT));
> > 
> > In the above code, pll-p value is OR'ed with previous value without
> > clearing it. Bug is not seen if pll-p value doesn't change across
> > Sampling frequency.
> 
> A better fix is to change the code to use snd_soc_update_bits() rather
> than open code it.  This is more idiomatic and will suppress writes if
> they don't change anything.
> 

Sure will resend the patch. Thanks for the review


Regards, 
Gururaja

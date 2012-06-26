From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Tue, 26 Jun 2012 06:23:37 +0000
Subject: [PATCH] davinci:mcasp: Fix codec pll configure bug
In-Reply-To: <1340275108-15555-1-git-send-email-gururaja.hebbar@ti.com>
References: <1340275108-15555-1-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA2C783@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

Kindly ignore this patch I will resend a corrected patch with below changes

1. add asoc codec maintainers (Mark Brown & Liam Girdwood)
2. modify the subject to indicate ASOC and codec as tlv320aic3x

On Thu, Jun 21, 2012 at 16:08:28, Hebbar, Gururaja wrote:
> In sound/soc/codecs/tlv320aic3x.c
> 
> 	data = snd_soc_read(codec, AIC3X_PLL_PROGA_REG);
> 	snd_soc_write(codec, AIC3X_PLL_PROGA_REG,
> 		      data | (pll_p << PLLP_SHIFT));
> 
> In the above code, pll-p value is OR'ed with previous value without
> clearing it. Bug is not seen if pll-p value doesn't change across
> Sampling frequency.
> 
> However on some platforms (like AM335x EVM-SK), pll-p may have different
> values across different sampling frequencies. In such case, above code
> configures the pll with a wrong value.
> Because of this bug, when a audio stream is played with pll value
> different from previous stream, audio is heard as stretched.
> 
> Fix the same by clearing the mask and then writing the value.
> 
> Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
> ---
>  sound/soc/codecs/tlv320aic3x.c |    2 +-
>  sound/soc/codecs/tlv320aic3x.h |    1 +

...snip...
...snip...

>  #define PLLJ_SHIFT		2
> -- 
> 1.7.1
> 

Regards, 
Gururaja

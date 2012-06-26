From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 26 Jun 2012 09:54:03 +0100
Subject: [PATCH V2] ASoC: tlv320aic3x: Fix codec pll configure bug
In-Reply-To: <1340690623-18177-1-git-send-email-gururaja.hebbar@ti.com>
References: <1340690623-18177-1-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <20120626085403.GH30406@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2012 at 11:33:43AM +0530, Hebbar, Gururaja wrote:
> In sound/soc/codecs/tlv320aic3x.c
> 
>         data = snd_soc_read(codec, AIC3X_PLL_PROGA_REG);
>         snd_soc_write(codec, AIC3X_PLL_PROGA_REG,
>                       data | (pll_p << PLLP_SHIFT));
> 
> In the above code, pll-p value is OR'ed with previous value without
> clearing it. Bug is not seen if pll-p value doesn't change across
> Sampling frequency.

A better fix is to change the code to use snd_soc_update_bits() rather
than open code it.  This is more idiomatic and will suppress writes if
they don't change anything.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120626/ebaf029c/attachment.sig>

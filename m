From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 25 Feb 2014 20:16:56 +0800
Subject: [PATCH] hwrng: msm: switch Kconfig to ARCH_QCOM depends
In-Reply-To: <52FB3FDA.4060307@mm-sol.com>
References: <1392150105-21057-1-git-send-email-galak@codeaurora.org>
 <52FB3FDA.4060307@mm-sol.com>
Message-ID: <20140225121656.GB12216@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 11:33:14AM +0200, Stanimir Varbanov wrote:
> Hi,
> > We've split Qualcomm MSM support into legacy and multiplatform.  The RNG
> > driver is only relevant on the multiplatform supported SoCs so switch the
> > Kconfig depends to ARCH_QCOM.
> > 
> > CC: Herbert Xu <herbert@gondor.apana.org.au>
> > Signed-off-by: Kumar Gala <galak@codeaurora.org>
> > ---
> >  drivers/char/hw_random/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
> > index 2f2b084..289bd3a 100644
> > --- a/drivers/char/hw_random/Kconfig
> > +++ b/drivers/char/hw_random/Kconfig
> > @@ -343,7 +343,7 @@ config HW_RANDOM_TPM
> >  
> >  config HW_RANDOM_MSM
> >  	tristate "Qualcomm MSM Random Number Generator support"
> > -	depends on HW_RANDOM && ARCH_MSM
> > +	depends on HW_RANDOM && ARCH_QCOM
> >  	---help---
> >  	  This driver provides kernel-side support for the Random Number
> >  	  Generator hardware found on Qualcomm MSM SoCs.
> > 
> 
> IMO, after this change the "MSM" abbreviation in help clause is
> irrelevant, could you remove it?
> 
> Reviewed-by: Stanimir Varbanov <svarbanov@mm-sol.com>

Patch applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

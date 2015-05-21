From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 May 2015 23:23:14 +0200
Subject: [PATCH] ASoC: qcom: remove incorrect dependencies
In-Reply-To: <20150521205952.GA31005@kwestfie-linux.qualcomm.com>
References: <2324031.cqS0mEEEhQ@wuerfel>
 <20150521205952.GA31005@kwestfie-linux.qualcomm.com>
Message-ID: <8811360.XmVQbMhHJj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 May 2015 14:00:00 Kenneth Westfield wrote:
> > diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> > index 5f58e4f1bca9..b07f183fc47f 100644
> > --- a/sound/soc/qcom/Kconfig
> > +++ b/sound/soc/qcom/Kconfig
> > @@ -6,12 +6,10 @@ config SND_SOC_QCOM
> >  
> >  config SND_SOC_LPASS_CPU
> >       tristate
> > -     depends on SND_SOC_QCOM
> 
> Rather than remove the dependency (which I would like to keep), would
> the following change work for SND_SOC_LPASS_CPU and
> SND_SOC_LPASS_PLATFORM?
> -       depends on SND_SOC_QCOM
> +       depends on SND_SOC_QCOM || COMPILE_TEST
> 
> If so, I will submit a patch (I know this has been applied already) on
> top of this one.
> 

That would have the same effect, but what is the point? Do you plan
to make these options user-visible in the future?

	Arnd

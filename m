From: B47053@freescale.com (Li Xiubo)
Date: Wed, 6 Nov 2013 08:59:53 +0000
Subject: [PATCHv2 5/8] ASoC: SGTL5000: Enhance the SGTL5000 codec driver
 about regulator.
In-Reply-To: <20131101185045.GG2493@sirena.org.uk>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-6-git-send-email-Li.Xiubo@freescale.com>
 <20131101185045.GG2493@sirena.org.uk>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F82876EFF@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > On VF610 series there are no regulators used, and now whether the
> > CONFIG_REGULATOR mirco is enabled or not, for the VF610 audio patch
> > series, the board cannot be probe successfully.
> > And this patch will solve this issue.
> 
> I don't understand what this is for at all, you're just saying there is a
> problem you're trying to solve but you don't explain anything about what
> the problem is or how your changes address it.
> 

Sorry for confusing.

The SGTL5000 is based on regulators and when it is disabled, there will be an error returns directly while the SGTL5000 codec is probing.
But on VF610 boards there has no regulators or needn't configure them, so the CONFIG_REGULATOR is disabled, and then the error is returned causing
to the SGTL5000 probe broken. 

Has I make it clear?

> > +#ifndef CONFIG_SND_SOC_FSL_SGTL5000_VF610
> >  static int ldo_regulator_register(struct snd_soc_codec *codec,
> 
> This is definitely broken, it won't work with multi-platform kernels, and
> I don't understand what this is supposed to do - what is the reason for
> making this change?
>

Yes, it is.

How about adding one node properties like : "regulator-exist", which will be controlled by platform data ?

From: B47053@freescale.com (Xiubo Li-B47053)
Date: Mon, 28 Oct 2013 06:07:41 +0000
Subject: [PATCHv1 5/8] ASoC: sgtl5000: Revise the bugs about the
 sgt15000 codec.
In-Reply-To: <20131018172814.GT2443@sirena.org.uk>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-6-git-send-email-Li.Xiubo@freescale.com>
 <20131018172814.GT2443@sirena.org.uk>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F8286A3DC@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > @@ -883,14 +883,19 @@ static int ldo_regulator_register(struct
> snd_soc_codec *codec,
> >  				struct regulator_init_data *init_data,
> >  				int voltage)
> >  {
> > +#ifdef CONFIG_SND_SOC_FSL_SGTL5000
> > +	return 0;
> > +#else
> >  	dev_err(codec->dev, "this setup needs regulator support in the
> kernel\n");
> >  	return -EINVAL;
> > +#endif
> >  }
> 
> If these systems don't actually need the internal regulator then should
> they not be trying to enable it?  
>
Yes, I think do not trying to enable the regulator is much better.

>Alternatively if it's OK to ignore this then why is this conditional in the board?
> 
The CONFIG_SND_SOC_FSL_SGTL5000 micro maybe confuse you and others.
And it should be CONFIG_SND_SOC_FSL_SGTL5000_VF610....

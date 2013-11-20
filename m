From: Li.Xiubo@freescale.com (Li Xiubo)
Date: Wed, 20 Nov 2013 07:49:06 +0000
Subject: [PATCHv2 6/8] ASoC: fsl: add SGTL5000 based audio machine driver.
In-Reply-To: <20131101184008.GF2493@sirena.org.uk>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-7-git-send-email-Li.Xiubo@freescale.com>
 <20131101184008.GF2493@sirena.org.uk>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F828B38EC@039-SN2MPN1-012.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > +	/* TODO: The SAI driver should figure this out for us */
> > +	switch (channels) {
> > +	case 2:
> > +		snd_soc_dai_set_tdm_slot(cpu_dai, 0xfffffffc, 0xfffffffc, 2,
> 0);
> > +		break;
> > +	case 1:
> > +		snd_soc_dai_set_tdm_slot(cpu_dai, 0xfffffffe, 0xfffffffe, 1,
> 0);
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> 
> Yes, it should - this code should probably just be copied straight into
> the SAI driver.  If we need to support other configurations we can do
> that later.
> 

Well, yes.
I have considered carefully about this, It maybe nicer to move this to SAI driver's .hw_params.



--
Best Regards,
Xiubo

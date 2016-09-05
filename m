From: pmeerw@pmeerw.net (Peter Meerwald-Stadler)
Date: Mon, 5 Sep 2016 11:02:21 +0200 (CEST)
Subject: [PATCH v4 3/3] iio: adc: add support for Allwinner SoCs ADC
In-Reply-To: <d40388ec-bf25-92b2-eeb6-39749d88c15c@free-electrons.com>
References: <1472738705-20145-1-git-send-email-quentin.schulz@free-electrons.com>
 <1472738705-20145-4-git-send-email-quentin.schulz@free-electrons.com>
 <alpine.DEB.2.02.1609041754350.2060@pmeerw.net>
 <aed1e00f-ceaa-27e9-502d-51428f59a84f@free-electrons.com>
 <alpine.DEB.2.02.1609050924370.12528@pmeerw.net>
 <d40388ec-bf25-92b2-eeb6-39749d88c15c@free-electrons.com>
Message-ID: <alpine.DEB.2.02.1609051101560.12528@pmeerw.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >>>> +{
> >>>> +	return SUN6I_GPADC_CTRL1_ADC_CHAN_SELECT(chan);
> >>>> +}
> >>>> +
> >>>> +struct soc_specific {
> >>>> +	const int		temp_offset;
> >>>
> >>> wondering why you constify every member?
> >>>
> >>
> >> Because they're supposed to be fixed values? It won't change in runtime.
> >> Is there any reason why I shouldn't do that?
> > 
> > yes, but using the entire struct as const has the same effect;
> > constifying individual members makes more sense if there are also 
> > non-const members
> > 
> > nothing wrong, just unusual
> > 
> 
> So I would let all members non-const and then when using the struct
> soc_specific as a member in a struct or as a variable I would prefix it
> with const? That's what you mean by using the entire struct as const?

yes, exactly

thanks, p.

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)

From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 28 Aug 2010 17:27:10 +0200
Subject: [PATCH 3/3 v2] dmaengine: Add Freescale i.MX SDMA support
In-Reply-To: <AANLkTimmEKfErV17RWNBO-pVCfFtFw=yJL2v92UBN0=2@mail.gmail.com>
References: <1281956870-12463-1-git-send-email-s.hauer@pengutronix.de>
	<20100823174852.GB26928@pengutronix.de>
	<AANLkTimmEKfErV17RWNBO-pVCfFtFw=yJL2v92UBN0=2@mail.gmail.com>
Message-ID: <201008281727.10913.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne So 28. srpna 2010 17:18:17 Linus Walleij napsal(a):
> 2010/8/23 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> >> +     evt = readl(SDMA_H_EVTOVR);
> >> +     mcu = readl(SDMA_H_HOSTOVR);
> >> +     dsp = readl(SDMA_H_DSPOVR);
> > 
> > __raw_readl?
> 
> Sorry I never understood this __raw_[read|write][b|w|l] vs.
> plain read[b|w|l] proliferation in some drivers and code.
> 
> What's the reason for?

Hey,

this trick is, if you create the VA<->PA mapping at the kernel start (eg. see 
how pxa_map_io() is replacedon some devices for instance), you then use the VA 
address you specified and use __raw_{read,write}[b,w,l](). So use 
__raw_{read,write}[b,w,l]() on drivers specific for certain device and use 
{read,write}[b,w,l]() on ioremap()ed memory areas, aka. in common drivers.

Cheers

> 
> Yours,
> Linus Walleij
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

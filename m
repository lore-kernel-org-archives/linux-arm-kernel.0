From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sat, 26 Feb 2011 18:39:46 +0200
Subject: [PATCH v2 1/3] ARM: PXA: PXAFB: Fix double-free issue
In-Reply-To: <201102201946.20681.marek.vasut@gmail.com>
References: <20110217110321.GF24627@n2100.arm.linux.org.uk>
	<1298214147-11578-1-git-send-email-anarsoul@gmail.com>
	<201102201946.20681.marek.vasut@gmail.com>
Message-ID: <201102261839.46806.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 20 February 2011 20:46:20 Marek Vasut wrote:

> > @@ -629,6 +629,9 @@ static void overlay1fb_disable(struct pxafb_layer
> > *ofb)
> > 
> >  {
> >  
> >  	uint32_t lccr5 = lcd_readl(ofb->fbi, LCCR5);
> > 
> > +	if (!(lcd_readl(ofb->fbi, OVL1C1) & OVLxC1_OEN))
> > +		return;
> > +
> 
> Maybe you can even avoid reading LCCR5 above ;-)

Agreed.

Will resend soon.

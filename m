From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Wed, 27 Jan 2010 13:18:00 +0100
Subject: [PATCH v3] input: MXC: add mxc-keypad driver to support the
	Keypad Port present in the mxc application processors family.
In-Reply-To: <1264594452.2463.62.camel@realization>
References: <1264586106.2463.23.camel@realization>
	<19296.5728.557535.920849@ipc1.ka-ro>
	<1264594452.2463.62.camel@realization>
Message-ID: <19296.12024.559688.606548@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Alberto Panizzo writes:
> > > +	irq = platform_get_irq(pdev, 0);
> > > +	if (irq < 0) {
> > > +		dev_err(&pdev->dev, "failed to get keypad irq\n");
> > > +		return -ENXIO;
> > > +	}
> > >
> > This should be -ENODEV.
> > 
> Lot of reference keyboard driver use -ENXIO..
> May should be better: return irq ?
> 
Yes, of course. If a function returns an error code that should be
promoted to the caller instead of inventing a new error code.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________

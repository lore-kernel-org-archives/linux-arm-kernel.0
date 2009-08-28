From: sleep_walker@suse.cz (=?utf-8?q?Tom=C3=A1=C5=A1_=27Sleep=5FWalker=27?=
	=?utf-8?q?_=C4=8Cech?=)
Date: Fri, 28 Aug 2009 22:18:28 +0200
Subject: [PATCH 5/5] PalmGSM: add basic Centro support
In-Reply-To: <200908271535.37959.marek.vasut@gmail.com>
References: <1251333811-22360-1-git-send-email-sleep_walker@suse.cz>
	<1251333811-22360-6-git-send-email-sleep_walker@suse.cz>
	<200908271535.37959.marek.vasut@gmail.com>
Message-ID: <200908282218.28263.sleep_walker@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dne ?t 27. srpna 2009 15:35:37 Marek Vasut napsal(a):
> Dne ?t 27. srpna 2009 02:43:31 Tom?? ?ech napsal(a):
> > From: Tom?? ?ech <sleep walker@suse.cz>
> >
> > ---
> ...
> > +	{
> > +		.name			= "centro:green:led",
> > +		.default_trigger	= "mmc0",
> > +		.gpio			= GPIO_NR_PALMGSM_GREEN_LED,
> > +	},
> > +	{
> > +		.name			= "centro:keybbl:keybbl",
> 
> Should be 'centro:white:keybbl' I think...see Documentation/leds-class.txt

I read it and I created the name accordingly, but if you don't accept this name, I would ommit color (centro::keybbl) - its color is white, but the buttons are light grey, dark grey and blue :)
I don't care much about that...

> > +		.default_trigger	= "none",
> > +		.active_low		= 1,
> > +		.gpio			= GPIO_NR_CENTRO_KEYB_BL,
> > +	},
> 
> And there is also that red led on the device, does it work already too?

It seems that red led is out of my control now - it seems to be attached to GSM chip. It can be turned off only when power source is unplugged and GSM chip is powered down now. This is to be found.

Best regards,

Tomas Cech

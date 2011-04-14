From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Thu, 14 Apr 2011 08:38:52 +0200
Subject: [PATCH v5 2/4] MTD : add the common code for GPMI controller
	driver
In-Reply-To: <4DA659D0.9030504@freescale.com>
References: <1302675881-18862-1-git-send-email-b32955@freescale.com>
	<1302675881-18862-3-git-send-email-b32955@freescale.com>
	<19877.65411.687158.113390@ipc1.ka-ro>
	<4DA659D0.9030504@freescale.com>
Message-ID: <19878.38524.705271.384302@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Huang Shijie writes:
> >> +	this->swap_block_mark = true;
> >> +	if (GPMI_IS_MX23(this))
> >> +		this->swap_block_mark = false;
> >>
> > if ... else ...?
> else is "true" by default.
>
I meant it would be clearer to do:
	if (GPMI_IS_MX23(this))
		this->swap_block_mark = false;
	else
		this->swap_block_mark = true;


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________

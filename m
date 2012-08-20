From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Mon, 20 Aug 2012 10:57:34 +0200
Subject: restart callback not supposed to sleep?
In-Reply-To: <20120820082423.GJ2232@pengutronix.de>
References: <20120820082423.GJ2232@pengutronix.de>
Message-ID: <20529.64510.403690.325993@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Uwe Kleine-K?nig writes:
> Hello,
> 
> while triggering a reboot via sysrq on an ARM machine I saw a "BUG:
> sleeping function called from invalid context" message (details below).
> The reason is that the sysrq handler is calling the restart hook in irq
> context. So what should be done about that? The obvious possiblities
> are:
> 
>  a) ignore the problem as it won't result in problems (and maybe somehow
>     silence the warnign); or
>  b) make the restart hook atomic; or
>  c) assert sysrq not calling the hook in atomic mode
> 
> What do you think?
> 
This has been discussed earlier (with your participation) with 'a)'
being the conclusion.
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-December/033877.html


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________

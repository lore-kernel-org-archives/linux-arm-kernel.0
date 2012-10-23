From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Tue, 23 Oct 2012 14:00:44 +0200
Subject: [PATCH v3 1/4] net/macb: fix truncate warnings
In-Reply-To: <20121023.044829.1915412359769438159.davem@davemloft.net>
References: <1350931534-8416-1-git-send-email-manabian@gmail.com>
 <1350931534-8416-2-git-send-email-manabian@gmail.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B705B@saturn3.aculab.com>
 <20121023.044829.1915412359769438159.davem@davemloft.net>
Message-ID: <20614.34540.248020.471598@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

David Miller writes:
> From: "David Laight" <David.Laight@ACULAB.COM>
> Date: Tue, 23 Oct 2012 09:21:11 +0100
> 
> >> When building macb on x86_64 the following warnings show up:
> >>   drivers/net/ethernet/cadence/macb.c: In function macb_interrupt:
> >>   drivers/net/ethernet/cadence/macb.c:556:4: warning: large integer implicitly truncated to unsigned type [-Woverflow]
> > ...
> >> -			macb_writel(bp, IDR, ~0UL);
> >> +			macb_writel(bp, IDR, -1);
> > 
> > Seems wrong to fix an error with an unsigned value
> > by using -1.
> 
> -1 is equally an unsigned value of all 1's and completely legitimate.
> The correction being made here is one of size not signedness.
> 
You could use '~0' (without the 'UL').


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________

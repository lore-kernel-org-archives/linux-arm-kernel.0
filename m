From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Mon, 11 Oct 2010 14:23:00 +0200
Subject: [PATCH] mxc/gpio: make _set_value work with values != 0/1
In-Reply-To: <20101011121745.GA12849@jasper.tkos.co.il> (Baruch Siach's
	message of "Mon, 11 Oct 2010 14:17:46 +0200")
References: <1286798345-32647-1-git-send-email-jacmet@sunsite.dk>
	<20101011121745.GA12849@jasper.tkos.co.il>
Message-ID: <87bp70or4r.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Baruch" == Baruch Siach <baruch@tkos.co.il> writes:

Hi,

 >> +

 Baruch> Unneeded empty line.

Yeah, just noticed as well.

 >> spin_lock_irqsave(&port->lock, flags);
 >> -	l = (__raw_readl(reg) & (~(1 << offset))) | (value << offset);
 >> +	l = __raw_readl(reg);
 >> +	if (value)
 >> +		l |= 1 << offset;
 >> +	else
 >> +		l &= ~(1 << offset);

 Baruch> Alternative shorter version:

 Baruch> l = (__raw_readl(reg) & (~(1 << offset))) | (!!value << offset);

Well, what do you know - I seem to be outnumbered ;)

Sasha, do you want the !! version instead? Then I'll resend.

-- 
Bye, Peter Korsgaard

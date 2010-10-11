From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 11 Oct 2010 14:54:31 +0200
Subject: [PATCH] mxc/gpio: make _set_value work with values != 0/1
In-Reply-To: <877hhoopzm.fsf@macbook.be.48ers.dk>
References: <1286798345-32647-1-git-send-email-jacmet@sunsite.dk>
	<20101011121745.GA12849@jasper.tkos.co.il>
	<87bp70or4r.fsf@macbook.be.48ers.dk>
	<20101011123903.GU28242@pengutronix.de>
	<877hhoopzm.fsf@macbook.be.48ers.dk>
Message-ID: <20101011125431.GX28242@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 11, 2010 at 02:47:41PM +0200, Peter Korsgaard wrote:
> >>>>> "Sascha" == Sascha Hauer <s.hauer@pengutronix.de> writes:
> 
> Hi,
> 
>  Baruch> Alternative shorter version:
>  Baruch> l = (__raw_readl(reg) & (~(1 << offset))) | (!!value << offset);
> 
>  Sascha> This is shorter but I find this significantly harder to read and I bet
>  Sascha> the compiler generates the same code from both versions.
> 
> Agreed.
> 
>  >> Well, what do you know - I seem to be outnumbered ;)
>  >> 
>  >> Sasha, do you want the !! version instead? Then I'll resend.
> 
>  Sascha> I like the !! version. The only problem with this is that people tend
>  Sascha> to try to remove the !! as it looks like a noop at first sight.
> 
> So what then? Do you want me to change to !!, resend with the extra
> empty line removed or just let you remove the line when you apply it?

If noone replies with '!! totally sucks' within 2 minutes just send a
patch which changes it to !! and removes the extra empty line.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Mon, 11 Oct 2010 14:47:41 +0200
Subject: [PATCH] mxc/gpio: make _set_value work with values != 0/1
In-Reply-To: <20101011123903.GU28242@pengutronix.de> (Sascha Hauer's message
	of "Mon, 11 Oct 2010 14:39:03 +0200")
References: <1286798345-32647-1-git-send-email-jacmet@sunsite.dk>
	<20101011121745.GA12849@jasper.tkos.co.il>
	<87bp70or4r.fsf@macbook.be.48ers.dk>
	<20101011123903.GU28242@pengutronix.de>
Message-ID: <877hhoopzm.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Sascha" == Sascha Hauer <s.hauer@pengutronix.de> writes:

Hi,

 Baruch> Alternative shorter version:
 Baruch> l = (__raw_readl(reg) & (~(1 << offset))) | (!!value << offset);

 Sascha> This is shorter but I find this significantly harder to read and I bet
 Sascha> the compiler generates the same code from both versions.

Agreed.

 >> Well, what do you know - I seem to be outnumbered ;)
 >> 
 >> Sasha, do you want the !! version instead? Then I'll resend.

 Sascha> I like the !! version. The only problem with this is that people tend
 Sascha> to try to remove the !! as it looks like a noop at first sight.

So what then? Do you want me to change to !!, resend with the extra
empty line removed or just let you remove the line when you apply it?

-- 
Bye, Peter Korsgaard

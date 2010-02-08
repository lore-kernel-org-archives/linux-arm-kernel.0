From: insane79@yandex.ru (Dennis Semakin)
Date: Mon, 08 Feb 2010 15:16:12 +0300
Subject: [PXA320] How to find I/O registers,
	base address of ASIX ethernet chip?
In-Reply-To: <20100208101524.GX28972@buzzloop.caiaq.de>
References: <19621265275300@webmail108.yandex.ru>
	<20100205042655.GR28972@buzzloop.caiaq.de>
	<33291265356930@webmail116.yandex.ru>
	<20100207051343.GL9007@buzzloop.caiaq.de>
	<33061265619560@webmail103.yandex.ru>
	<20100208091348.GC15255@pengutronix.de>
	<18311265621886@webmail106.yandex.ru>
	<20100208101524.GX28972@buzzloop.caiaq.de>
Message-ID: <32661265631372@webmail120.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Daniel
Thank you very much for code. It works fine.
If you will be in Moscow, I'll buy you a pints of beer :)

It is necessary to ask only: why in u-boot git-repository I didn't see this code?

08.02.10, 11:15, "Daniel Mack" <daniel@caiaq.de>:

> On Mon, Feb 08, 2010 at 12:38:06PM +0300, Dennis Semakin wrote:
>  > 08.02.10, 10:13, "Uwe Kleine-K?nig" :
>  > >  This sounds like a missing clock.  Ah, and Daniel already asked that,
>  > >  too: "Did you switch on the clock for the static bus?"
>  > >  
>  > 
>  > Well... I yet do not know how to do this...
>  
>  Try adding this sniplet to your lowlevel_init function in U-Boot:
>  
>          /* enable clocks for NAND and static memory */
>          ldr             r0, =CKENA
>          ldr             r1, [r0]
>          orr             r1, r1, #(CKENA_4_NAND | CKENA_9_SMC)
>          str             r1, [r0]
>          ldr             r1, [r0]
>  
>  Daniel
>  

Thanks
Best regards
Dennis Semakin

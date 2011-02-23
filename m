From: will.deacon@arm.com (Will Deacon)
Date: Wed, 23 Feb 2011 17:36:21 -0000
Subject: [PATCH] nmk-gpio: use request_irq instead of chained handler
In-Reply-To: <AANLkTin94vzJ_RvxvydnF1ymT2hbKGHruqUMrFTZKPJ+@mail.gmail.com>
References: <1298465690-27077-1-git-send-email-rabin.vincent@stericsson.com>
	<-6148324460357957969@unknownmsgid>
	<AANLkTin94vzJ_RvxvydnF1ymT2hbKGHruqUMrFTZKPJ+@mail.gmail.com>
Message-ID: <002101cbd380$2f7d5a50$8e780ef0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Wed, Feb 23, 2011 at 22:47, Will Deacon <will.deacon@arm.com> wrote:
> >> __nmk_gpio_irq_handler doesn't do anything more that what a normal handler
> >> does, so it can become one. ?This is also needed for changing the GIC
> >> implementation to a different flow handler.
> >>
> >> Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
> >
> > mach-nomadik only seems to use the vic. Why does this GPIO handler
> > need updating?
> 
> plat-nomadik/gpio.c is also used by mach-ux500, which uses the GIC.

Ah yes, sorry I missed that one. I'm happy to include any patches from you
in the GIC fasteoi series if it makes merging easier.

Will

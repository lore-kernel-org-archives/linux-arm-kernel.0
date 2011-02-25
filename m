From: will.deacon@arm.com (Will Deacon)
Date: Fri, 25 Feb 2011 17:16:25 -0000
Subject: [PATCH] nmk-gpio: use request_irq instead of chained handler
In-Reply-To: <AANLkTin_xxPJnOKxiu-z=Yo2FVkD=_Ow7CoGb2gApUaq@mail.gmail.com>
References: <1298465690-27077-1-git-send-email-rabin.vincent@stericsson.com>	<-6148324460357957969@unknownmsgid>	<AANLkTin94vzJ_RvxvydnF1ymT2hbKGHruqUMrFTZKPJ+@mail.gmail.com>	<5890487119819559395@unknownmsgid>
	<AANLkTin_xxPJnOKxiu-z=Yo2FVkD=_Ow7CoGb2gApUaq@mail.gmail.com>
Message-ID: <000c01cbd50f$bbc24d50$3346e7f0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

> 2011/2/23 Will Deacon <will.deacon@arm.com>:
> >> On Wed, Feb 23, 2011 at 22:47, Will Deacon <will.deacon@arm.com> wrote:
> >> >> __nmk_gpio_irq_handler doesn't do anything more that what a normal handler
> >> >> does, so it can become one. ?This is also needed for changing the GIC
> >> >> implementation to a different flow handler.
> >> >>
> >> >> Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
> >> >
> >> > mach-nomadik only seems to use the vic. Why does this GPIO handler
> >> > need updating?
> >>
> >> plat-nomadik/gpio.c is also used by mach-ux500, which uses the GIC.
> >
> > Ah yes, sorry I missed that one. I'm happy to include any patches from you
> > in the GIC fasteoi series if it makes merging easier.
> 
> OK if this one is OK I sure prefer that you take it in your series Will,
> since you have the whole picture of what you want to do with the
> GIC.
> 
> It'll likely collide with the stuff I have stacked up for the 2.6.39 merge
> window though, which will be pull-requested any day now.

Sure. I'll add a patch to my series that makes the minimal change required
and post it next week.

Will

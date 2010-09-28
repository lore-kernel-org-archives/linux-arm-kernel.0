From: chlrbgh0@gmail.com (=?UTF-8?B?7LWc6rec7Zi4?=)
Date: Tue, 28 Sep 2010 20:30:38 +0900
Subject: [PATCH] ARM: S5PV210: Add Torbreck board support
In-Reply-To: <004c01cb5ed1$bb44b890$31ce29b0$%kim@samsung.com>
References: <1285463130-14227-1-git-send-email-chlrbgh0@gmail.com>
	<AANLkTik5SkqjEz5Ymtg6RvwfrU0i8XzhPQq3Un7gMbP=@mail.gmail.com>
	<AANLkTik1YAd8W75DzrDmfhFYG-JE8__Tu4uq83RKsioC@mail.gmail.com>
	<004c01cb5ed1$bb44b890$31ce29b0$%kim@samsung.com>
Message-ID: <AANLkTi=J692UG8M0BgTZZrHVAYjyGyQQ61azcUWGtb+o@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 28, 2010 at 2:55 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>
> ??? wrote:
> Hi,
>
> Welcome to Linux mainline ;-)
> I have some comments about your patches.
>
> Firstly could you please use English character in the representing name in e-mail client not Korean character :-)
> And make sure it's text type.
>
> >Hi,
> >Thank you for your interesting.
> >On Mon, Sep 27, 2010 at 11:58 AM, Kyungmin Park <kmpark@infradead.org> wrote:
>
> (snip)
>
> >> +#define TORBRECK_UFCON_DEFAULT (S3C2410_UFCON_FIFOMODE | ? ? ? \
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?S5PV210_UFCON_TXTRIG4 | ? ? ? ?\
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?S5PV210_UFCON_RXTRIG4)
> >Any reason to use TRIG4? just use the full trigger e.g., 256.
> >
> >Okay, I'll fix it.
> >
> Hmm...Kyungmin, any reason to use full trigger here?
>
> It depends on board...so it doesn't matter TRIG4 or anything else if there is no problem on your board.
> It means the maximum value is not best condition...only depends on your situation/condition.
>

Okay, if this is not a mandatory, I want to keep this original, I had no problem
with this setting when I tested.

> >> +
> >> +static struct s3c2410_uartcfg torbreck_uartcfgs[] __initdata = {
> >> + ? ? ? [0] = {
> >> + ? ? ? ? ? ? ? .hwport ? ? ? ? = 0,
> >> + ? ? ? ? ? ? ? .flags ? ? ? ? ?= 0,
> >There's no code for flags, please remove it all.
> >
> >Okay, I'll remove it.
> >
> I think no need to modify it.
> Actually I said many times about this...
>
> And as Ben Dooks said in other patch, the format will be changed soon.
>

This also, I don't want to take _unknown_ side effects to modify this alone. :(
Actually, others(smdks, aquilla, goni) are also set this field. So, I hope this
also modify with Ben's other patch that you mentioned.

> >> + ? ? ? ? ? ? ? .ucon ? ? ? ? ? = TORBRECK_UCON_DEFAULT,
> >> + ? ? ? ? ? ? ? .ulcon ? ? ? ? ?= TORBRECK_ULCON_DEFAULT,
> >> + ? ? ? ? ? ? ? .ufcon ? ? ? ? ?= TORBRECK_UFCON_DEFAULT,
> >> + ? ? ? },
> >> + ? ? ? [1] = {
> >> + ? ? ? ? ? ? ? .hwport ? ? ? ? = 1,
> >> + ? ? ? ? ? ? ? .flags ? ? ? ? ?= 0,
> >> + ? ? ? ? ? ? ? .ucon ? ? ? ? ? = TORBRECK_UCON_DEFAULT,
> >> + ? ? ? ? ? ? ? .ulcon ? ? ? ? ?= TORBRECK_ULCON_DEFAULT,
> >> + ? ? ? ? ? ? ? .ufcon ? ? ? ? ?= TORBRECK_UFCON_DEFAULT,
> >> + ? ? ? },
> >> + ? ? ? [2] = {
> >> + ? ? ? ? ? ? ? .hwport ? ? ? ? = 2,
> >> + ? ? ? ? ? ? ? .flags ? ? ? ? ?= 0,
> >> + ? ? ? ? ? ? ? .ucon ? ? ? ? ? = TORBRECK_UCON_DEFAULT,
> >> + ? ? ? ? ? ? ? .ulcon ? ? ? ? ?= TORBRECK_ULCON_DEFAULT,
> >> + ? ? ? ? ? ? ? .ufcon ? ? ? ? ?= TORBRECK_UFCON_DEFAULT,
> >> + ? ? ? },
> >> + ? ? ? [3] = {
> >> + ? ? ? ? ? ? ? .hwport ? ? ? ? = 3,
> >> + ? ? ? ? ? ? ? .flags ? ? ? ? ?= 0,
> >> + ? ? ? ? ? ? ? .ucon ? ? ? ? ? = TORBRECK_UCON_DEFAULT,
> >> + ? ? ? ? ? ? ? .ulcon ? ? ? ? ?= TORBRECK_ULCON_DEFAULT,
> >> + ? ? ? ? ? ? ? .ufcon ? ? ? ? ?= TORBRECK_UFCON_DEFAULT,
> >> + ? ? ? },
> >> +};
> >> +
>
> (snip)
>
> >> --
> >> 1.5.6.3
> >>
> If possible, please use later version git.
> It doesn't mean latest git is best...
> This is just private opinion. :-)

Yes. :-)

Thanks,
Kyuho Choi

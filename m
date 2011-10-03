From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 3 Oct 2011 09:38:07 +0200
Subject: [GIT PULL] ux500-timers
In-Reply-To: <1422315.r6YLuIojzy@wuerfel>
References: <CACRpkdbCZwSdXzqvPCrGagaikc53xLyDTQaZMRtuyqo9vw=Yng@mail.gmail.com>
	<201109302228.46572.arnd@arndb.de> <1422315.r6YLuIojzy@wuerfel>
Message-ID: <CACRpkdbt0hL-GJRHbhJXoGVrVEMLfx9eStCiLx+y+=LA12WT-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 1, 2011 at 6:00 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> It caused a few build regressions:
>
> - missing include of errno.h
> - clksrc_dbx500_prcmu_init stub needs to be static inline, or it causes a
> ?link failure.

Sorry about this crap I'll be looking closer next time :-(

> - clksrc_dbx500_timer_base may be initialized when it's not actually linked in
>
> For the last one, I think it would actually be best to make the timer
> a platform_device and pass the address in platform_data or device tree
> property, or alternatively make it an argument to clksrc_dbx500_prcmu_init
> and make the variable static.

I chose the latter approach.

> Please send a new pull request with these things fixed, either with
> patches on top or replacing the original ones, whichever you prefer.

I have applied a hacked version of your patch like this:

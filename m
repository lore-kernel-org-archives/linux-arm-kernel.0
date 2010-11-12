From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 12 Nov 2010 10:43:25 +0100
Subject: [PATCH] RFC: nomadik: expand timesource to 63 bits
In-Reply-To: <AANLkTi=ysONhPQBTbVNRgTOx5PGEM=STaUYY6RnUpfES@mail.gmail.com>
References: <1289466356-16697-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTi=ysONhPQBTbVNRgTOx5PGEM=STaUYY6RnUpfES@mail.gmail.com>
Message-ID: <4CDD0C3D.5070309@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

john stultz wrote:

> I would advise against expanding the hardware counter to 63bits via
> software at the clocksource layer. This breaks the
> CLOCK_SOURCE_IS_CONTINUOUS flag rule (since the hardware will wrap
> below the mask value if not updated in the software layer). And as
> Thomas said, this will cause problems in the nohz idle limiting code
> (which makes sure we wake up before the clocksource wraps).

Hm, yeah that's probably the wisest thing to do right now..

Then the Tegra code is not quite sound. It will probably experience
bad stuff like shaky clocksource when idling too long.

> Instead, I'd use this extension at the sched_clock level, where it
> seems reasonable that it will be called frequently enough to not brake
> the cnt32_to_63 magic.

Yeah we will do it like the Orion does.

Thanks!
Linus Walleij

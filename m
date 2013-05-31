From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 31 May 2013 16:02:34 +0200
Subject: [PATCH 12/39] ARM: u300: set up board power from device tree
In-Reply-To: <4270774.6CqcMSP3z0@wuerfel>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
 <6621177.ZgrPQ48FXE@wuerfel>
 <CACRpkdYXfm4xzqn2Kb0fw2_+BSSXBoNXye2zu3fpv1sPQcHO9w@mail.gmail.com>
 <4270774.6CqcMSP3z0@wuerfel>
Message-ID: <CACRpkdb=Z8oFpvxni6jyaWHoQOjhFkWQ_71ku=h5UFk9pzJZ2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 31, 2013 at 3:51 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> If it is not really a property of a particular board, but something
> that you would need for other boards as well, it could perhaps
> be tied to the syscon functionality, or to ab3100:
>
> ab3100_regulators_probe() could itself set up the the supply
> and then set the syscon bit. Basically you just move all of
> arch/arm/mach-u300/regulator.c into drivers/regulator/ab3100.c

I think this is more likely the case.

Mark: would you be OK with the ab3100 driver hogging one of its
own regulators?

Yours,
Linus Walleij

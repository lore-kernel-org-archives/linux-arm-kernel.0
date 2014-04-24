From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 24 Apr 2014 15:26:20 +0200
Subject: [PATCH v2 0/7] ARM: berlin: add pinctrl support
In-Reply-To: <CACRpkdbT94HqVroM_0gSJJ8Q2+YaKXLwjFGMn+4SCa_PYiF19Q@mail.gmail.com>
References: <1398268276-9696-1-git-send-email-antoine.tenart@free-electrons.com>
 <CACRpkdbT94HqVroM_0gSJJ8Q2+YaKXLwjFGMn+4SCa_PYiF19Q@mail.gmail.com>
Message-ID: <20140424152620.39eae472@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Linus Walleij,

On Thu, 24 Apr 2014 14:52:20 +0200, Linus Walleij wrote:

> > Tested on the Berlin BG2Q.
> 
> So now I need some advice from the mvebu pinctrl maintainers
> (Thomas, Sebastian etc):
> 
> - Is this a totally different pin controller so that drivers/pinctrl/mvebu
>  can not be used?

It is. The CPU families are completely different, made from completely
separate divisions of Marvell. Just think that they come from different
companies :-)

On the mvebu side, each pin can be independently configured to a
different function: there is a 4-bits field for each pin to configure
the function.

On the berlin side, pins are only configured in groups. You can't
independently set the functions of each pin: you can set a function to
a pre-defined set of pins.

> - Really?

Yes.

> - OK can you help me review this thing?

Sure. I believe Sebastian already had a very detailed look so he can
provide his review.

> - Should the base folder really be named "berlin" or is this going to
>   be part of a bigger family of pin controllers so a more neutral name
>   should be sought?

berlin is the name of the mach-<foo> directory in arch/arm, and that's
really the code name for this SoC family.

> - Why do hardware engineers seek to reinvent wheels like pin
>   controllers, GPIO and DMA engines all the time :-/

I guess Russell already gave you a good answer to this question :-)

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

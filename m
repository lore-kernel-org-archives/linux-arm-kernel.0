From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Apr 2012 13:31:17 +0200
Subject: [PATCH 1/1] pinctrl: handle dummy state in core
In-Reply-To: <20120417034210.GD17173@shlinux2.ap.freescale.net>
References: <1334586289-13078-1-git-send-email-b29396@freescale.com>
 <4F8C42D6.2000607@wwwdotorg.org>
 <20120417034210.GD17173@shlinux2.ap.freescale.net>
Message-ID: <CACRpkdYH06_kGbSdozKPWZcOG0FvoOyHvjHwhz-xUL1pfSX9DQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2012 at 5:42 AM, Dong Aisheng
<aisheng.dong@freescale.com> wrote:

> I think the main issue is for one platform neither supports dt nor using pinctrl
> subsystem, do you think it still makes too much sense to force that platform
> to define a _PINCTRL_ dummy state in their machine code?
>
> But the driver is commonly shared between these different platforms(using pinctrl
> or not).

So this is for the situation where some machines have pinctrl and some haven't.

And I think that's how some archs have used the regulator dummies earlier,
so I clearly see the point. So if converting a subset of machines in an
architecture you will need this for a transitional period.

Is this helpful to get i.MX support in place?

On one hand I'd say we merge it for that reason alone, instead of requiring
all i.MX machines to be converted at once.

On the other hand, I fear that this will be used to avoid *ever* migrating
the old machines to pinctrl. And it's a generic disease that people working
in the arch/arm/* tree want to ditch old hardware without actually deleting
the code.

I'd like Sascha's view on this to make a good decision.

Yours,
Linus Walleij

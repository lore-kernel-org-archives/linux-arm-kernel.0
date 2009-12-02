From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 2 Dec 2009 12:34:53 +0800
Subject: [PATCH] MMC: pxamci: call pdata->setpower even when regulator is
	used
In-Reply-To: <1259233813-2724-1-git-send-email-daniel@caiaq.de>
References: <1259233813-2724-1-git-send-email-daniel@caiaq.de>
Message-ID: <f17812d70912012034t57ebde8fmb7f7971109436775@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2009 at 7:10 PM, Daniel Mack <daniel@caiaq.de> wrote:
> On platforms where the vmmc regulator is used, it might still be
> necessary to call the platform data's setpower() callback in order to
> drive GPIOs to power up hardware.
>
> I can't see any pxamci user with power regulators enabled, hence this
> shouldn't break anything.
>

I was thinking about this for quite a time, and I'm afraid that this patch
solves only one corner case - that some specific actions need to be
taken _after_ mmc regulator is adjusted, while excluding the possibility
for that to happen _before_. I wonder maybe for those corner cases,
if one can just manipulate the vmmc regulator and other specific stuffs
within ->setpower().

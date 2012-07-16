From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 16 Jul 2012 13:37:13 +0200
Subject: linux-next: manual merge of the arm-soc tree with the
 i2c-embedded tree
In-Reply-To: <20120716101706.GB17435@pengutronix.de>
References: <20120710164130.f38e4d1673f925ddb13914c9@canb.auug.org.au>
 <20120712131231.GH2194@pengutronix.de>
 <CACRpkdboeF_G=sTPeSyuZ6KGLCmGSKx_NS=6Rim6HkR2f9=AAQ@mail.gmail.com>
 <20120716101706.GB17435@pengutronix.de>
Message-ID: <CACRpkdY626iYATorphAvg7cQxD2ufysBvXdt3Z644zEuW0wS=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2012 at 12:17 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:

>> And about the perpetual nature of device tree bindings it
>> appears to me that the modus operandi right now is to not
>> regard any of these as written in stone until they are removed
>> from the kernel tree. We have plenty of drivers patching
>> trees and drivers in one for the moment.
>
> I don't get this one. Yes, they are of perpetual nature, so how could we
> remove them from the kernel tree?

What I meant was that at the point when arch/arm/boot/dts/*
is (if ever) removed from the kernel tree and into its own git, so that
the standardization of bindings is decoupled from the Linux kernel
tree, from that point it is no longer possible to alter the bindings
and the code in sync, so at that point the bindings need to be
frozen and all subsequent work will need to gear down and
work on bindings before deployment.

That said, this does not at all solve the problem of already-deployed
device trees using old bindings...

> What I am afraid of is: tentative solutions tend to stay, because the
> need for a proper solution is reduced. Yet, finding proper generic
> bindings might take some time which doesn't meet the high pressure
> around DT at the moment.

I'm +1 on this. But I have learned that I have had to strike a
compromise with people who want to forge ahead. They see things
in the other way: perpetual committee discussions and no code
nor device trees being deployed... :-)

Yours,
Linus Walleij

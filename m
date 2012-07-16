From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 16 Jul 2012 21:45:29 +0200
Subject: linux-next: manual merge of the arm-soc tree with the
 i2c-embedded tree
In-Reply-To: <20120716123550.GE17435@pengutronix.de>
References: <20120710164130.f38e4d1673f925ddb13914c9@canb.auug.org.au>
 <20120712131231.GH2194@pengutronix.de>
 <CACRpkdboeF_G=sTPeSyuZ6KGLCmGSKx_NS=6Rim6HkR2f9=AAQ@mail.gmail.com>
 <20120716101706.GB17435@pengutronix.de>
 <CACRpkdY626iYATorphAvg7cQxD2ufysBvXdt3Z644zEuW0wS=w@mail.gmail.com>
 <20120716123550.GE17435@pengutronix.de>
Message-ID: <CACRpkdaMB-n7XYcxE8QtAm-WrGc2DR0krfTjQZCbvOL1HYep1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2012 at 2:35 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:

> Uhm, I seem to have missed that bindings are deemed more "flexible" as
> long as they are coupled to in-kernel dts files? Is that discussed
> somewhere? I do wonder about it...

Well patches like this are sent out but not commented on from
the perspective of binding stability. So of course, they get merged.

Have a look at this commit:

commit 7f217794ffa72f208a250b79ab0b7ea3de19677f
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Sun May 13 00:14:24 2012 -0400

    mmc: dt: Consolidate DT bindings

This is deleting custom properties from DTS files without
adding any code to fallback-support them on old device trees.

(Actually I like this commit a lot, since it is removing custom MMC
props and replacing these with standard bindings common for all
MMC/SD controllers, but ...)

I think there are more examples if you git log on arch/arm/boot/dts...

Yours,
Linus Walleij

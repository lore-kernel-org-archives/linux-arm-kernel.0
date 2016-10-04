From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 04 Oct 2016 11:22:11 +0200
Subject: [PATCH] bus: qcom-ebi2: depend on HAS_IOMEM
In-Reply-To: <e3b1a575-7f97-ed6c-e2c0-16ae193b1b49@codeaurora.org>
References: <1475445239-25006-1-git-send-email-linus.walleij@linaro.org>
 <e3b1a575-7f97-ed6c-e2c0-16ae193b1b49@codeaurora.org>
Message-ID: <4689181.6Kvp1DKsXN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, October 3, 2016 12:04:00 PM CEST Stephen Boyd wrote:
> On 10/02/2016 02:53 PM, Linus Walleij wrote:
> > After being asked to not depend on ARCH_QCOM* or similar,
> > unsurprisingly compilation fails on UM as it has no I/O
> > memory:
> 
> We could have depends on ARCH_QCOM || COMPILE_TEST and then life is
> good. The HAS_IOMEM would of course stick around for compile testing.

Agreed, that would be nice also since most x86 don't want to
see the Kconfig option unless they set COMPILE_TEST.

Note that COMPILE_TEST now depends on !UML, so we don't have
to worry about that any more.

	Arnd

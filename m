From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 09 Dec 2015 22:00:49 +0100
Subject: [PATCH] ARM: pxa: cm-x2xx: avoid duplicate macro warnings
In-Reply-To: <5126103.CuC5iMSqYG@wuerfel> (Arnd Bergmann's message of "Wed, 09
 Dec 2015 17:52:06 +0100")
References: <5126103.CuC5iMSqYG@wuerfel>
Message-ID: <87y4d3jq0u.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> In an old commit, we worked around the duplicate definition of
> GPIO24_SSP1_SFRM in cm-x2xx.c, which includes files for both
> pxa25x and pxa27x. Apparently the problem has come back and we
> now have four additional duplicate symbols that cause warnings:
>
> In file included from /git/arm-soc/arch/arm/mach-pxa/pxa27x.h:7:0,
>                  from /git/arm-soc/arch/arm/mach-pxa/cm-x2xx.c:27:
> /git/arm-soc/arch/arm/mach-pxa/mfp-pxa27x.h:21:0: warning: "GPIO86_GPIO" redefined
>  #define GPIO86_GPIO  MFP_CFG_IN(GPIO86, AF0)
>
> This uses the same hack as before and undefines all symbols that
> are defined more than once. Fortunately, cm-x2xx does not need
> any of these.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Digging out old patches of 2012, cool.
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

I suppose it's a necessary hack until I manage to kill the mfp interface in
favor of pinctrl.

Cheers.

--
Robert

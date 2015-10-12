From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 12 Oct 2015 19:03:44 +0200
Subject: [PATCH] ARM: pxa: fix pxa3xx DFI lockup hack
In-Reply-To: <5287252.pkh9x0t1Y6@wuerfel> (Arnd Bergmann's message of "Mon, 12
 Oct 2015 15:44:49 +0200")
References: <5287252.pkh9x0t1Y6@wuerfel>
Message-ID: <878u786mtr.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> Some recently added code to avoid a bug introduced a build error
> when CONFIG_PM is disabled and a macro is hidden:
>
> arch/arm/mach-pxa/pxa3xx.c: In function 'pxa3xx_init':
> arch/arm/mach-pxa/pxa3xx.c:439:3: error: 'NDCR' undeclared (first use in this function)
>    NDCR = (NDCR & ~NDCR_ND_ARB_EN) | NDCR_ND_ARB_CNTL;
>    ^
>
> This moves the macro outside of the #ifdef so it can be
> referenced correctly.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: adf3442cc890 ("ARM: pxa: fix DFI bus lockups on startup")
> ---
> We merged the patch that introduced this as a fix for 4.3, so we should
> probably add this one too.
Oh yes, didn't see that ifdef, and all my non-regression defconfigs have
CONFIG_PM ...

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

So do you want to take it directly (my preferred solution) or do you want a
proper pull request for in the -rc5 timeframe ?

Cheers.

-- 
Robert

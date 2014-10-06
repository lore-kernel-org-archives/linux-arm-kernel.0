From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 06 Oct 2014 23:36:43 +0200
Subject: [PATCH v1] clk: pxa clocks build system fix
In-Reply-To: <8761fwc2me.fsf@free.fr>
References: <1412199569-27958-1-git-send-email-robert.jarzmik@free.fr>
 <2017199.vcTs1JkoqL@wuerfel> <8761fwc2me.fsf@free.fr>
Message-ID: <7069544.aUPivvE1xF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 06 October 2014 23:25:13 Robert Jarzmik wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > On Sunday 05 October 2014 13:43:58 Mike Turquette wrote:
> >> Quoting Robert Jarzmik (2014-10-01 14:39:29)
> >> > Fix the building of pxa clock drivers so that the files are actually
> >> > compiled if and only if COMMON_CLK was selected by the architecture.
> >> > 
> >> > This prevents conflicts with mach-pxa clock legacy implementation.
> >> > 
> >> > Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> >> 
> >
> > I seem to still hit a build error with this applied in e.g.
> > build/palmz72_defconfig, which enables both pxa25x and pxa27x,
> > so I get both the pxa250 private clock code and the pxa270
> > common clock code, resulting in this error message:
> Do you have the patch "Revert "arm: pxa: Transition pxa27x to clk framework" in
> your tree ?
> 
> Normally the fix was made of :
>  - the fixup patch "clk: pxa clocks build system fix"
>  - the revert queued by Mike "arm: pxa: Transition pxa27x to clk framework"

No, I was missing that one, sorry for the noise. It works now after
I've applied it. I was using the latest -next kernel as a base and assumed
that it had all the latest fixes from Mike's tree.

	Arnd

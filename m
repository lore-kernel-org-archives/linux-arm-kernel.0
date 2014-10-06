From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 06 Oct 2014 15:15:16 -0700
Subject: [PATCH v1] clk: pxa clocks build system fix
In-Reply-To: <7069544.aUPivvE1xF@wuerfel>
References: <1412199569-27958-1-git-send-email-robert.jarzmik@free.fr>
 <2017199.vcTs1JkoqL@wuerfel> <8761fwc2me.fsf@free.fr>
 <7069544.aUPivvE1xF@wuerfel>
Message-ID: <20141006221516.4379.66624@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Arnd Bergmann (2014-10-06 14:36:43)
> On Monday 06 October 2014 23:25:13 Robert Jarzmik wrote:
> > Arnd Bergmann <arnd@arndb.de> writes:
> > 
> > > On Sunday 05 October 2014 13:43:58 Mike Turquette wrote:
> > >> Quoting Robert Jarzmik (2014-10-01 14:39:29)
> > >> > Fix the building of pxa clock drivers so that the files are actually
> > >> > compiled if and only if COMMON_CLK was selected by the architecture.
> > >> > 
> > >> > This prevents conflicts with mach-pxa clock legacy implementation.
> > >> > 
> > >> > Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> > >> 
> > >
> > > I seem to still hit a build error with this applied in e.g.
> > > build/palmz72_defconfig, which enables both pxa25x and pxa27x,
> > > so I get both the pxa250 private clock code and the pxa270
> > > common clock code, resulting in this error message:
> > Do you have the patch "Revert "arm: pxa: Transition pxa27x to clk framework" in
> > your tree ?
> > 
> > Normally the fix was made of :
> >  - the fixup patch "clk: pxa clocks build system fix"
> >  - the revert queued by Mike "arm: pxa: Transition pxa27x to clk framework"
> 
> No, I was missing that one, sorry for the noise. It works now after
> I've applied it. I was using the latest -next kernel as a base and assumed
> that it had all the latest fixes from Mike's tree.

I pushed the changes to my mirror over the weekend. I guess -next hasn't
picked it up. I'm waiting for a couple of -next cycles this week before
I push my tag to Linus.

Regards,
Mike

> 
>         Arnd

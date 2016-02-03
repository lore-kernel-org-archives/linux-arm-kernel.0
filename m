From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Feb 2016 21:49:22 +0100
Subject: [PATCH 0/7] USB changes for rare warnings
In-Reply-To: <87lh7161wc.fsf@belgarion.home>
References: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
 <87oabxpsr8.fsf@ti.com> <87lh7161wc.fsf@belgarion.home>
Message-ID: <1964102.4NLQkU883F@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 February 2016 20:15:47 Robert Jarzmik wrote:
> Felipe Balbi <balbi@kernel.org> writes:
> 
> > Hi Arnd,
> >
> >>  arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h | 198 ---------
> >>  arch/arm/mach-pxa/include/mach/pxa25x-udc.h     | 163 --------
> >
> > for arch/arm I need Acked-by from relevant folks.
> You already have mine for arch/arm/mach-pxa/include/mach/pxa25x-udc.h I think,
> or did my mailer betray me again ...

I saw it.

> I cannot speak for ixp4xx though.

Krzysztof Halasa <khalasa@piap.pl> gave an Ack for the first patch already,
and I think we concluded that the patch was keeping the current behavior
otherwise and is therefore not a regression, though we did not finish
the side-discussion about whether ixp4xx actually works in both BE and LE
mode with both indirect and direct I/O, or which of the four combinations
is broken.

> > Also, do you think we need this during the -rc or can we consider it
> > non-critical fixes for v4.6 merge window ?

I meant it for 4.6, sorry for not being very clear about that.
All the warnings I fixed in this series are harmless as far as I
can tell, and they only show up in rare randconfig builds.

	Arnd

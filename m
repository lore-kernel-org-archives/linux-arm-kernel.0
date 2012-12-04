From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 4 Dec 2012 13:58:03 +0000
Subject: [PATCH 1/1] ARM: ux500: Change IRQ from low-to-high edge
 triggered to high-to-low
In-Reply-To: <CACRpkdYn7tuCjNiy0KpDEefC3tMDjKSnaWKzM38URN9HQALT7Q@mail.gmail.com>
References: <1354289099-17931-1-git-send-email-lee.jones@linaro.org>
 <CACRpkdafvpnyq7YMV=iSjN4+u1hpt3xntAb-daJZifG9VpgnOw@mail.gmail.com>
 <20121204091215.GD2718@gmail.com>
 <CACRpkdYn7tuCjNiy0KpDEefC3tMDjKSnaWKzM38URN9HQALT7Q@mail.gmail.com>
Message-ID: <20121204135803.GG2718@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 04 Dec 2012, Linus Walleij wrote:

> On Tue, Dec 4, 2012 at 10:12 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Sat, 01 Dec 2012, Linus Walleij wrote:
> >
> >> On Fri, Nov 30, 2012 at 4:24 PM, Lee Jones <lee.jones@linaro.org> wrote:
> >>
> >> > When the STMPE IRQ is triggered to be active high level-sensitive, the
> >> > Nomadik GPIO controller it uses complains, although it still works.
> >> > Recently we attempted to move triggering to low-to-high in an attempt
> >> > to prevent the warning; however, this ensured that the IRQ was actually
> >> > missed completely. Now we have a solution which both works and keeps the
> >> > GPIO controller happy.
> >> >
> >> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >>
> >> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >>
> >> Is this something I should put into the ux500 tree or will you
> >> take care of this in a separate pull request?
> >
> > Can you still get this into the RCs, as it's a bugfix?
> 
> Well it doesn't apply to the -rc:s since it's patching
> arch/arm/boot/dts/stuib.dtsi which does not exist in
> the v3.7 series.
> 
> Either what you want is to submit a fix to Arnd & Olof
> on top of your previous DT patches, or you need to send
> a rebased version...

Ah, well if it's fixing something that isn't in the -rc:s, then
it doesn't need to go into the -rc:s. Well as the merge window
is not long opening, I'll hold on to it and stick it in for -rc1
or something.

Thanks for letting me know.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

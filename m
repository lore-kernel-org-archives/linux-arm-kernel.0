From: ralph.sennhauser@gmail.com (Ralph Sennhauser)
Date: Mon, 12 Jun 2017 09:17:21 +0200
Subject: [PATCHv2 1/2] gpio: mvebu: fix blink counter register selection
In-Reply-To: <CACRpkdbH4L=k+RjP7wpmpUQC4kthBF07Brk6K+sxXyf+G1Ke9g@mail.gmail.com>
References: <20170601121826.14685-1-richard.genoud@gmail.com>
 <20170601121826.14685-2-richard.genoud@gmail.com>
 <CACRpkdbRN3pgNqUJXHimpMjSOMeZepjxACveTSVzYJWneM9hOQ@mail.gmail.com>
 <20170609100322.765adf7f@gmail.com>
 <CACRpkdbH4L=k+RjP7wpmpUQC4kthBF07Brk6K+sxXyf+G1Ke9g@mail.gmail.com>
Message-ID: <20170612091721.6c7d4f48@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Sun, 11 Jun 2017 23:48:34 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Fri, Jun 9, 2017 at 10:03 AM, Ralph Sennhauser
> <ralph.sennhauser@gmail.com> wrote:
> > On Fri, 9 Jun 2017 09:37:55 +0200
> > Linus Walleij <linus.walleij@linaro.org> wrote:
> >  
> >> On Thu, Jun 1, 2017 at 2:18 PM, Richard Genoud
> >> <richard.genoud@gmail.com> wrote:
> >>  
> >> > The blink counter A was always selected because 0 was forced in
> >> > the blink select counter register.
> >> > The variable 'set' was obviously there to be used as the register
> >> > value, selecting the B counter when id==1 and A counter when
> >> > id==0.
> >> >
> >> > Tested on clearfog-pro (Marvell 88F6828)
> >> >
> >> > Fixes: 757642f9a584 ("gpio: mvebu: Add limited PWM support")
> >> > Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> >> > Reviewed-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
> >> > Signed-off-by: Richard Genoud <richard.genoud@gmail.com>  
> >>
> >> Patch applied for fixes.
> >>
> >> It appears this will clash with patches on the development
> >> branch :(  
> >
> > Hi Linus,
> >
> > The commit 2233bf7a92e7 ("gpio: mvebu: switch to regmap for register
> > access") which you likely mean breaks gpio-keys, reported about an
> > hour ago, so you might just want to drop that one for now instead
> > as it needs mor work anyway.  
> 
> I would like to get an indication from Thomas and/or Gregory if they
> think it is a good idea to revert or if they just wanna fix it.

A fix patch by Gregory exists by now ([PATCH v2] gpio: mvebu: fix
regmap_update_bits usage).
 
> We still have development time before we even start merging for v4.13
> and then we have all the release candidates. No point to throw up
> hands this early?

Ah, not throwing hands. Just thought the author might prefer to rebase
the patch himself when fixing the bug so there is just one clean patch
for the change as there is still enough time for that before the merge
window opens.

Ralph

From: lukma@denx.de (Lukasz Majewski)
Date: Wed, 20 Dec 2017 14:18:48 +0100
Subject: [PATCH v5 0/4] ARM: ep93xx: ts72xx: Add support for BK3 board
In-Reply-To: <CACRpkdaAYLd6ZcBXQP_SfA1dTyyb4kjOpGoW5DUBgH_9pDDtQQ@mail.gmail.com>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171211233625.5689-1-lukma@denx.de>
 <CACRpkdbCeBCENDcRcYBKTXVNz6H3t=WKHYP8Uf3WJ=Wvtib1Jg@mail.gmail.com>
 <1513153607.2439.2.camel@Nokia-N900> <20171213095257.5cf424fb@jawa>
 <CACRpkdaAYLd6ZcBXQP_SfA1dTyyb4kjOpGoW5DUBgH_9pDDtQQ@mail.gmail.com>
Message-ID: <20171220141848.3f7c49c4@jawa>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

> On Wed, Dec 13, 2017 at 9:52 AM, Lukasz Majewski <lukma@denx.de>
> wrote:
> >> On Wed Dec 13 08:34:22 2017 Linus Walleij
> >> <linus.walleij@linaro.org> wrote:  
> >> > On Tue, Dec 12, 2017 at 12:36 AM, Lukasz Majewski <lukma@denx.de>
> >> > wrote: Out of curiosity: Liebherr is obviously doing heavy-duty
> >> > industrial control systems. Likewise Hartley is doing similar
> >> > business over at Vision Engravings.
> >> >
> >> > Is the situation such that there is a whole bunch of industrial
> >> > systems out there, in active use and needing future upgrades,
> >> > that use the EP93xx?  
> >>
> >> That's definitely the case. I'm as well aware of several thousands
> >> of industrial devices which are expected to run 24/7 for the next 5
> >> years at least. And they are updated from time to time.  
> >
> > I can agree with this statement.  
> 
> OK I'm coloring this platform with a highlight for ARM32 maintenance.
> 
> >> > Arnd has been nudging me to do DT conversion for EP93xx
> >> > so if there are many active industrial users of these
> >> > I should prioritize it, because these things have 20+ years
> >> > support cycles.  
> >>
> >> I'm not sure how important or necessary at all is to change
> >> anything in these legacy platforms.  
> >
> > +1  
> 
> That is an understandable conservative stance.
> 
> There is a fine line between "it works, don't touch it" and
> "modernize the ARM32 ecosystem".

There may be a more pragmatic reason. If those boards are deployed
(widely) in the industry - there may be a problem with re-validation of
the SW.

> 
> There is a point where supporting old board files will stand in
> the way and cost a lot in maintenance (like moving drivers our
> of arch/arm, or modernizing misc subsystems). Then moving the
> platform over to device tree should be preferred.

With my limited experience - those platforms have more similarities to
x86. Multiplatform may be the goal here....

> 
> > I'm using OE to build toolchain (SDK). I can confirm that gcc 7.2
> > works with it.
> >
> > And yes, armv4 support shall be preserved in GCC ....  

I should have be more peculiar - this is armv4t (arm920t)

> 
> Yes that is the same toochain I use.
> 
> Yours,
> Linus Walleij



Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171220/7d527241/attachment.sig>

From: lukma@denx.de (Lukasz Majewski)
Date: Sun, 17 Dec 2017 20:41:22 +0100
Subject: [PATCH v5 0/4] ARM: ep93xx: ts72xx: Add support for BK3 board
In-Reply-To: <CAK8P3a2jEVQXKXJXp27ft5oaD8Jbo6g1fB-t_aduJWhC2dtJ0g@mail.gmail.com>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171211233625.5689-1-lukma@denx.de>
 <CACRpkdbCeBCENDcRcYBKTXVNz6H3t=WKHYP8Uf3WJ=Wvtib1Jg@mail.gmail.com>
 <1513153607.2439.2.camel@Nokia-N900>
 <CAK8P3a2jEVQXKXJXp27ft5oaD8Jbo6g1fB-t_aduJWhC2dtJ0g@mail.gmail.com>
Message-ID: <20171217204122.0a10a5e1@jawa>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

> On Wed, Dec 13, 2017 at 9:26 AM, Alexander Sverdlin
> <alexander.sverdlin@gmail.com> wrote:
> > On Wed Dec 13 08:34:22 2017 Linus Walleij
> > <linus.walleij@linaro.org> wrote:  
> >> Arnd has been nudging me to do DT conversion for EP93xx
> >> so if there are many active industrial users of these
> >> I should prioritize it, because these things have 20+ years
> >> support cycles.  
> >
> > I'm not sure how important or necessary at all is to change
> > anything in these legacy platforms.  
> 
> I suspect that at several points in the next 5 to 10 years, we will
> remove additional platforms or CPU types, as we tend to do when a
> platform becomes a maintenance burden and is clearly not used by
> anyone.

I suppose that at least the last argument is not the case here :-).

> 
> It's hard to predict in advance what triggers the removal, but as the
> number of platforms that are not using DT or ARCH_MULTIPLATFORM
> goes down to a small number, there will be increased interested in
> either removing or converting the remaining ones. This is not an
> immediate danger at the moment, since we still have 14 platforms that
> are not using ARCH_MULTIPLATFORM, and 23 that have remaining
> board files, but you don't want to be the last user of the last
> platform after the other ones are done ;-)

:-)

> 
> >> We also need to think about upholding support in GCC for
> >> ARMv4(t) for the foreseeable future if there is a big web of
> >> random deeply embedded systems out there that will need
> >> updates.  
> >
> > But we should definitely preserve at least what we have.  
> 
> Plain ARMv4 (and earlier) support in gcc is already marked
> 'deprecated' and will likely be gone in gcc-8 (it's still there as of
> last week). ARMv4T is going to be around for a while, and you can
> even keep building for ARMv4 using "-march=armv4t -marm" when linking
> with 'ld --fix-v4bx'.

I think that we shall start complaining on the gcc-devel mailing list
now.

I would be hard to wake up in 2 years time and realise that we don't
have a modern compiler.

> 
> Debian recently did a survey to find out whether there were still
> users on ARMv4 or ARMv4T, and the result was that probably everyone is
> on ARMv5E or ARMv6 for the ARM port (which is separate from the
> ARMHF port that is ARMv7+). See also
> https://lists.debian.org/debian-user/2017/11/msg00379.html
> and let them know quickly if you use Debian stable releases and
> plan to update to Debian 10 (Buster) in the future.
> 
>      Arnd



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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171217/56d4973a/attachment.sig>

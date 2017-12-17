From: lukma@denx.de (Lukasz Majewski)
Date: Sun, 17 Dec 2017 22:28:56 +0100
Subject: [PATCH v5 0/4] ARM: ep93xx: ts72xx: Add support for BK3 board
In-Reply-To: <CAK8P3a09V1ZhhVCvdy27BiBCMM54zo4qyypgSDvrg2CdpneVmg@mail.gmail.com>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171211233625.5689-1-lukma@denx.de>
 <CACRpkdbCeBCENDcRcYBKTXVNz6H3t=WKHYP8Uf3WJ=Wvtib1Jg@mail.gmail.com>
 <1513153607.2439.2.camel@Nokia-N900>
 <CAK8P3a2jEVQXKXJXp27ft5oaD8Jbo6g1fB-t_aduJWhC2dtJ0g@mail.gmail.com>
 <20171217204122.0a10a5e1@jawa>
 <CAK8P3a09V1ZhhVCvdy27BiBCMM54zo4qyypgSDvrg2CdpneVmg@mail.gmail.com>
Message-ID: <20171217222856.2c5937a4@jawa>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

> On Sun, Dec 17, 2017 at 8:41 PM, Lukasz Majewski <lukma@denx.de>
> wrote:
> >> >> We also need to think about upholding support in GCC for
> >> >> ARMv4(t) for the foreseeable future if there is a big web of
> >> >> random deeply embedded systems out there that will need
> >> >> updates.  
> >> >
> >> > But we should definitely preserve at least what we have.  
> >>
> >> Plain ARMv4 (and earlier) support in gcc is already marked
> >> 'deprecated' and will likely be gone in gcc-8 (it's still there as
> >> of last week). ARMv4T is going to be around for a while, and you
> >> can even keep building for ARMv4 using "-march=armv4t -marm" when
> >> linking with 'ld --fix-v4bx'.  
> >
> > I think that we shall start complaining on the gcc-devel mailing
> > list now.
> >
> > I would be hard to wake up in 2 years time and realise that we don't
> > have a modern compiler.  
> 
> What distro or build system are you using?

I'm using OE with the "include conf/machine/include/tune-arm920t.inc"

GCC 7.2 is working 

> It would also be helpful
> to test whether the -march=armv4t/--fix-v4bx workaround produces
> working binaries for you, in that case you could report to the gcc
> developers that the removal of armv4 can continue but that
> the --fix-v4bx option in ld needs to stay around.

I may ask this issue on OE/Yocto mailing list as well....

Thanks for hint.

> 
>        Arnd



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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171217/bec5a31a/attachment-0001.sig>

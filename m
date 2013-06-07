From: wookey@wookware.org (Wookey)
Date: Fri, 7 Jun 2013 19:57:24 +0100
Subject: [Arm-netbook] getting allwinner SoC support upstream (was Re:
 Uploading linux (3.9.4-1))
In-Reply-To: <20130606172810.GE14209@lukather>
References: <CAPweEDz=hFxXW3XF9CSNZpEFSjayb5an1E8Xze1_uQcCZONVxg@mail.gmail.com>
 <1370469574.18839.33.camel@localhost>
 <CAPweEDxMpeJc-w=Yd7d2OT=UisRBp2rxf-MPMDUCOG3EyJz1GQ@mail.gmail.com>
 <CAKON4OxwyV2f_iTEb5RnP_azc7EsSxPdku_TY5WLWxN7USiY1Q@mail.gmail.com>
 <CAPweEDw1BabE0cmT5fxZ3Z9p9EH508M3Nzcqk2VcO0oz-qYsvg@mail.gmail.com>
 <1370475609.20454.44.camel@localhost>
 <CAPweEDwS3tR=wh-bZJb3vqR8fVQra=3XxDitowGRdH9c7WRfmQ@mail.gmail.com>
 <CAKON4OxPDpN3BTc9GWP44exDSkAZGJ5OeCpUP37vRnnvxwUnmw@mail.gmail.com>
 <CAOesGMgqxhG45NyCfpHc_0uHS+_Gn-hGZm-+CRvK2EEf1AGTow@mail.gmail.com>
 <20130606172810.GE14209@lukather>
Message-ID: <20130607185724.GZ14125@stoneboat.aleph1.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+++ Maxime Ripard [2013-06-06 19:28 +0200]:
> Hi everyone,
> 
> On Thu, Jun 06, 2013 at 09:00:00AM -0700, Olof Johansson wrote:

> > Listen, Allwinner isn't working in a vacuum, believe it or not. I've
> > talked to them, so has Arnd and other people working on ARM, including
> > Maxime Ripard, who's been reimplementing upstream support for their
> > platform. Everybody is interested in the right things happening, it's
> > just a matter of figuring out how to do it. The right people are
> > already talking.
> 
> I should also add that Allwinner not only talked to us already, but also
> expressed interest in doing actual modern kernel development (like using
> "recently" introduced kernel frameworks, like the clk framework).
> 
> I've received patches from them already for private reviews, they began
> to show up on the kernel mailing lists, they asked to be CCed on the
> patches I send upstream, they're even the one that reached out to me
> when the early support for their chips was released. So, like Olof said,
> they aren't in a vacuum, they are very aware of the mainline kernel and
> speak a decent english.

OK, this sounds good. Could you say who the allwinner engineers are? I
guess it's quite a large organisation, so if Crazy Luke can say 'the
work of mainline integration using device-tree is already being done
by $these $people, please talk to them to help move it along', that
might help get everyone on the same page.

If it's like many large organisations, some bits of it will 'get it'
and see why, in the long term, mainline integration is worthwhile, but
other bits will look at what they have now and their android focus,
and decide it's easier to keep doing what they are doing. 

There is a lot of hardware using these socs, and I'd love to be able
to use that with mainstream stuff, rather than random vendor piles,
and specific android kernels, so anything we can do to help make that
happen is good.

> So yes, Allwinner has an evil vendor tree (c), with a solution similar yet
> inferior (because not generic enough) to the device tree, but they show
> interest on going down the mainline road.

So, luke: mainline is not going to support fex directly, whatever you
or allwinner do. The advantages to allwinner of working with mainline
are:
1) Ability to use whatever (kernel supported) hardware they like with
new designs, with no driver work
2) Ability to use latest kernels and thus whatever shiny goodies those
include
3) No need to do fex-ready drivers for new hardware
4) No need to keep backporting new kernels to add fex integration
forevermore

If they want to keep existing tools and fex workflow then a fex<->DT
translation tool will be needed. (It's not clear to me to what degree
DT can simply be used instead directly)


Wookey
-- 
Principal hats:  Linaro, Emdebian, Wookware, Balloonboard, ARM
http://wookware.org/

From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Feb 2016 12:14:41 +0100
Subject: [PATCH 1/3] irqchip: gic/realview: support more RealView DCC
 variants
In-Reply-To: <CACRpkdZD_qg0p8spr9HnFBSzXidi59J_kR8XBo-s8z-tSqKs5g@mail.gmail.com>
References: <1455803172-22747-1-git-send-email-linus.walleij@linaro.org>
 <5028476.WAQS3ylXOd@wuerfel>
 <CACRpkdZD_qg0p8spr9HnFBSzXidi59J_kR8XBo-s8z-tSqKs5g@mail.gmail.com>
Message-ID: <3474694.oM65GZWKke@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 February 2016 19:30:27 Linus Walleij wrote:
> On Thu, Feb 18, 2016 at 3:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday 18 February 2016 14:19:48 Marc Zyngier wrote:
> >> On 18/02/16 13:46, Linus Walleij wrote:
> >> > In the add-on file for the GIC dealing with the RealView family
> >> > we currently only handle the PB11MPCore, let's extend this to
> >> > manage the RealView EB ARM11MPCore as well. The Revision B of the
> >> > ARM11MPCore core tile is a bit special and needs special handling
> >> > as it moves a system control register around at random.
> >>
> >> Ah, 11MPCore RevB. That thing. Tried to locate one in the magic
> >> cupboard, and failed. Oh well...
> >
> > What surprised me though is that it's enabled by default:
> 
> Looks like my fault according to git-blame...
> 
> I think this happened when making cover-all defconfigs for
> multiplatform. I think I just turned everything on... not realizing
> that turning on RevB disabled RevA+RevC.
> 
> However since it is the *only* version that works with QEMU
> it actually makes some kind of weird sense to have it enabled
> since the QEMU version is probably more common than
> RevA+RevC...

Do we have reason to believe that any RevA exists?

My understanding from reading the source was that RevB was everything
there was until support for RevC got added and RevB gained a
separate option, or possibly that RevA was the same as RevB but
it was never common enough to even get mentioned in the source.

	Arnd

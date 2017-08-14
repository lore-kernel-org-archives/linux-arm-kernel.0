From: andrew@aj.id.au (Andrew Jeffery)
Date: Mon, 14 Aug 2017 12:38:16 +0930
Subject: [PATCH 00/11] watchdog: Consolidate FTWDT010 derivatives
In-Reply-To: <CACPK8XetQJ_=CD4TPOmyigQZv2pRankWYew31Yf_ep4fai6X-g@mail.gmail.com>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
 <CACPK8XetQJ_=CD4TPOmyigQZv2pRankWYew31Yf_ep4fai6X-g@mail.gmail.com>
Message-ID: <1502680096.14932.8.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-08-14 at 10:54 +0930, Joel Stanley wrote:
> Hi Linus,
>?
> On Sun, Aug 13, 2017 at 4:13 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > The MOXA ART and Aspeed watchdogs are clearly based on the
> > Faraday Technology FTWDT010 IP block.
>?
> They have a similar register interface, but I'm told they are not the same IP.
>?
> We've got some patches on the list that add some extra registers to
> the driver for the ast2500. If we decide to merge the drivers, that
> support will need to be included.
>?
> Andrew was working on that, I'll let him follow up on the details.

There are two series on the lists expanding driver support for the Aspeed
watchdog, one from Chris Bostic and another from myself:

1. [PATCH v5 0/2] Add ASPEED watchdog device tree properties:

	https://lkml.org/lkml/2017/7/17/777?

2. [PATCH 0/2] watchdog: aspeed: External reset signal properties:

	https://www.spinics.net/lists/kernel/msg2570666.html?

I don't have the datasheets for either the Moxa or Faraday SoCs, so I can't
assess how the support I've added for the external pulse properties on Aspeed
hardware impacts/is impacted by the merge. Chris' changes on the otherhand look
like they could be generalised. At least, the vendor prefix on the devicetree
properties he defined could perhaps be changed from aspeed to faraday.

Cheers,

Andrew

PS: Patch 10/11 failed to apply for me against several trees, failing on the
hunk for arch/arm/boot/dts/gemini.dtsi. Is there an unmentioned dependency?

>?
> > This series consolidates the drivers into one by extending
> > the Gemini driver to be as generic as possible, renaming it
> > to ftwdt010_wdt and merging the two other drivers into it.
> >?
> > As similar approach was used for the FTTMR010 driver in the
> > past.
> >?
> > The series ends with two patches that will be applied to
> > the ARM SoC tree to fix up the PCLK annotations, but these
> > are not needed to make the consolidation, patches 1-9 can
> > be applied directly to the watchdog tree to perform the
> > consolidation.
>?
> The clock isn't called PCLK in the Aspeed documentation (similarly for
> the timer, but I was too slow to speak up in that case).
>?
> I'm trying to find some time to write a proper clock driver so it's
> clear how the clocks are set out in the Aspeed.
>?
> Cheers,
>?
> Joel
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170814/5e4c82bd/attachment.sig>

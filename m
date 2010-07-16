From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 16 Jul 2010 11:17:24 -0700
Subject: [RFC PATCH] Kconfig: Enable Kconfig fragments to be used for
	defconfig
In-Reply-To: <20100716180701.GA26854@n2100.arm.linux.org.uk>
References: <20100713230352.6781.18644.stgit@angua>
	<1279296221.17878.66.camel@e102109-lin.cambridge.arm.com>
	<AANLkTinyFBTKYaryFANYheTuP-biJUws2x01NRNZPb4M@mail.gmail.com>
	<20100716180701.GA26854@n2100.arm.linux.org.uk>
Message-ID: <AANLkTik_pGP2oI0UQmjiz7BndmvFXDs1G2b9Au15y6n1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 16, 2010 at 11:07 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>
> I thought Linus' idea was to use:
>
> KBUILD_KCONFIG=file make allnoconfig

See an earlier reply - that is indeed what I suggested, and yes, it
avoids the need to be able to "unselect" things.

However, it turns out that even then you do want to extend the Kconfig
language with the ability to select particular values. Not for boolean
(or even tristate things), but for things that select an integer or
string value etc.

So the "select OPTION=xyz" syntax ends up being a good thing even for
the "-n" (allnoconfig) case too.

And while I think the allnoconfig model has some advantages (the
Kconfig input file ends up being independent of the default values),
that very fact ends up being a disadvantage too (the Kconfig input
file likely ends up being larger, since _hopefully_ the defaults are
sane).

So I'm not at all married to the "allnoconfig" model. It's one way of
doing things, but I think the argument that we should start with the
defaults and modify those instead is not an invalid one.

                     Linus

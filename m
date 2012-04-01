From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 2 Apr 2012 00:33:20 +0200
Subject: [PATCH/RFC v2] ARM: amba: Remove AMBA level regulator support
In-Reply-To: <20120401212750.GE8971@opensource.wolfsonmicro.com>
References: <1333306720-28344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CACRpkdYRStgKo_e-4kZKA-V-OoMiV21jRS3R4g1Cq+4c+4=iQA@mail.gmail.com>
 <20120401212750.GE8971@opensource.wolfsonmicro.com>
Message-ID: <CACRpkdbj_shuGWATGER+zxvA9MNDobGjWC3XHh+-5e0R6V4n4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 1, 2012 at 11:27 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Sun, Apr 01, 2012 at 09:22:50PM +0200, Linus Walleij wrote:
>
>> Combined with the PL022 patch this causes a power regression since
>> the PL022 is hereafter always on.
>
> I guess this code isn't in mainline, though? ?In that case you can
> always add a revert of this commit to your out of tree patches if you
> need to.

No, we can sure live with it... Out-of-mainline we do use power domains
so that's what we should do instead. It currently looks like this:
http://www.igloocommunity.org/gitweb/?p=kernel/igloo-kernel.git;a=blob;f=arch/arm/mach-ux500/pm/runtime.c;hb=HEAD

It's a really nice piece of code but uses some out-of-tree features,
the most obvious one is "atomic regulators" (which are exactly
that).

>> But to the defence: power domain code was not in the kernel
>> when the AMBA "vcore" regulator was introduced so how else
>> could we do it... except for inventing power domains...
>
> Which might've happened sooner if we'd noticed :) ?There were some other
> platforms doing similar things but they mostly used the clock API since
> it was always entirely platform code until 3.4 so they're less intrusive
> into the generic code.

Yeah ... but this sounds familiar, (searching searching) Yes! We did ask on
the lists if regulators were proper for modeling power domains in 2008:
http://marc.info/?l=linux-arm-kernel&m=121580531500758&w=2

But I should've pushed for a proper answer ...

Yours,
Linus Walleij

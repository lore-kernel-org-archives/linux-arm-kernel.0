From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 1 Apr 2012 22:27:50 +0100
Subject: [PATCH/RFC v2] ARM: amba: Remove AMBA level regulator support
In-Reply-To: <CACRpkdYRStgKo_e-4kZKA-V-OoMiV21jRS3R4g1Cq+4c+4=iQA@mail.gmail.com>
References: <1333306720-28344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CACRpkdYRStgKo_e-4kZKA-V-OoMiV21jRS3R4g1Cq+4c+4=iQA@mail.gmail.com>
Message-ID: <20120401212750.GE8971@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 01, 2012 at 09:22:50PM +0200, Linus Walleij wrote:

> Combined with the PL022 patch this causes a power regression since
> the PL022 is hereafter always on.

I guess this code isn't in mainline, though?  In that case you can
always add a revert of this commit to your out of tree patches if you
need to.

> But I guess if I fix a power domain patch to accomplish much the
> same things then nothing is really lost...

Let me know if you run into any trouble with that - I don't have any
systems which could usefully use such support so I'm unlikely to work on
it directly and from what you were saying you'll need to integrate with
existing power domain code anyway.

> And I do like the change, if for nothing else so for the fact that it
> eventually pushes to power domains what belongs there, so:

> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks.

> But to the defence: power domain code was not in the kernel
> when the AMBA "vcore" regulator was introduced so how else
> could we do it... except for inventing power domains...

Which might've happened sooner if we'd noticed :)  There were some other
platforms doing similar things but they mostly used the clock API since
it was always entirely platform code until 3.4 so they're less intrusive
into the generic code.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120401/f1b48146/attachment.sig>

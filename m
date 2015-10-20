From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Tue, 20 Oct 2015 12:20:26 +0100
Subject: [PATCH] ARM64: juno: add NOR flash to device tree
In-Reply-To: <CACRpkdb1XRSq3EERbiMwCnuV7Dtit2xGYRDBtQ9+odyXq6kM7A@mail.gmail.com>
References: <1444904415-19597-1-git-send-email-linus.walleij@linaro.org>
 <561FC681.2040809@arm.com>
 <CACRpkdaSox9WKb5-dkD_zAwO9WxP6+b010p3bdxsm1LRy=WvKg@mail.gmail.com>
 <5624C31D.3070906@arm.com> <20151019102932.GB10678@leverpostej>
 <CACRpkdaGscb_ccbGuwccsRj_b1d6xoveiiZpw1a5eXon3PxAUA@mail.gmail.com>
 <20151019113904.GE10678@leverpostej>
 <CACRpkdb1XRSq3EERbiMwCnuV7Dtit2xGYRDBtQ9+odyXq6kM7A@mail.gmail.com>
Message-ID: <20151020112026.GF10728@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 11:55:32PM +0200, Linus Walleij wrote:
> > As I mentioned, I was under the impression that at least a portion of
> > the flash was used by UEFI for variable storage, and that UEFI could
> > therefore access the flash at runtime (due to runtime services calls).
> 
> OK I see. But doesn't that portion of the flash live inside one of the
> AFS partitions simply?

Are you saying that you see AFS partitions matching the entries in
your platform's SITE1/HBI0262?/images.txt?

If that is the case, then certainly that is a reasonable mechanism to
make use of. However, the log in your commit message didn't show
any partitions being detected. And you should have at least a bl0.bin,
bl1.bin, fip.bin and hdlcdclk.dat in there.

> No why would anyone do that. As with all file systems and
> partitions it is possible to destroy them if you can access them,
> with great power comes great responsibility as always, I'm just
> not fond of the idea of hiding things behind the back for hackers
> "for their own good", that is not the right spirit I think.

If it is actually possible to describe this properly to the kernel, I
agree. But, due to the somewhat hyper-flexible boot architecture of
Juno, we may end up with different boards of the same revision having
different "safe" regions.

And if the regions are detected, we still need to have a protective
entry for the UEFI persistent data region added to future Juno firmare
releases.

/
    Leif

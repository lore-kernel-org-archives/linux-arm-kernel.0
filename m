From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 19 Oct 2015 23:58:24 +0200
Subject: [PATCH] ARM64: juno: add NOR flash to device tree
In-Reply-To: <CAKv+Gu9YDBN8Epa+4xH0ert6LBRgfUAdC9OENdD16oQcGHVRXw@mail.gmail.com>
References: <1444904415-19597-1-git-send-email-linus.walleij@linaro.org>
 <561FC681.2040809@arm.com>
 <CACRpkdaSox9WKb5-dkD_zAwO9WxP6+b010p3bdxsm1LRy=WvKg@mail.gmail.com>
 <5624C31D.3070906@arm.com> <20151019102932.GB10678@leverpostej>
 <CACRpkdaGscb_ccbGuwccsRj_b1d6xoveiiZpw1a5eXon3PxAUA@mail.gmail.com>
 <20151019113904.GE10678@leverpostej>
 <CAKv+Gu9YDBN8Epa+4xH0ert6LBRgfUAdC9OENdD16oQcGHVRXw@mail.gmail.com>
Message-ID: <CACRpkdZxqPwCm2iLZ3sifRqT0Ub0cE_A-Pzd=_K5kTVf5O6LMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 4:40 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:

> I sent some patches around about a year ago that registers UEFI
> runtime MMIO regions with /proc/iomem, which should prevent drivers
> from attaching to the same physical memory regions. With that in
> place, describing it in the DT would not be a problem, and on devices
> with multiple NOR flashes of which only one is used at runtime by
> UEFI, it would allow Linux to still access the other one.

That is very un-kernellike I think, isn't it better that it gets defined as
an MTD partition?

None of it should affect registering the flash in the device tree
however, it is indeed the hardware that is there, it is a device tree.

We could discuss switching MTD and/or AFS off for EFI boots,
but it seems a bit overzealous to me.

Yours,
Linus Walleij

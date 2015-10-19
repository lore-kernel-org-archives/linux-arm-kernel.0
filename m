From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 19 Oct 2015 13:19:14 +0200
Subject: [PATCH] ARM64: juno: add NOR flash to device tree
In-Reply-To: <20151019102932.GB10678@leverpostej>
References: <1444904415-19597-1-git-send-email-linus.walleij@linaro.org>
 <561FC681.2040809@arm.com>
 <CACRpkdaSox9WKb5-dkD_zAwO9WxP6+b010p3bdxsm1LRy=WvKg@mail.gmail.com>
 <5624C31D.3070906@arm.com> <20151019102932.GB10678@leverpostej>
Message-ID: <CACRpkdaGscb_ccbGuwccsRj_b1d6xoveiiZpw1a5eXon3PxAUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 12:29 PM, Mark Rutland <mark.rutland@arm.com> wrote:

> Also, for non U-Boot systems I was under the impression that the flash
> was effectively owned by EFI (for variable storage),

If it is "owned" by something it is owned by the boot monitor, neither
by U-Boot or (U)EFI. The boot monitor can flash "images" into
the flash using USB or ethernet/TFTP and it is not part of any
boot loader, but an autonomous flash image on the board.
(Actually it can replace itself.)

EFI or U-Boot is one such "image", as is the kernel and the
other patch series I've sent (AFSv2 support) makes these
"images" visible to the kernel as individual MTD partitions.

This flash image format has nothing to do with UEFI or any other
boot loader, it has been around since the RealView platforms,
and has basically not changed since. (Well the forst pointer in
the image information structure was changed from u32 to u64).

My impression is that the boot monitor code is just a continous
evolution from reference design to reference design inside ARM.
It cares very little about what boot loader happens to be the
fashion of the day, it is also used for flashing images of Windows
mobile or QNX or whatever people want to run as well.

The "images" are very simplistic things designed to support
execute-in-place. New images can be added/removed by any
compliant software, be it EFI, U-Boot or the kernel. But the
format of these images is part of the hardware or rather the boot
monitor, nothing else.

Yours,
Linus Walleij

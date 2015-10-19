From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Mon, 19 Oct 2015 12:27:49 +0100
Subject: [PATCH] ARM64: juno: add NOR flash to device tree
In-Reply-To: <CACRpkdaGscb_ccbGuwccsRj_b1d6xoveiiZpw1a5eXon3PxAUA@mail.gmail.com>
References: <1444904415-19597-1-git-send-email-linus.walleij@linaro.org>
 <561FC681.2040809@arm.com>
 <CACRpkdaSox9WKb5-dkD_zAwO9WxP6+b010p3bdxsm1LRy=WvKg@mail.gmail.com>
 <5624C31D.3070906@arm.com> <20151019102932.GB10678@leverpostej>
 <CACRpkdaGscb_ccbGuwccsRj_b1d6xoveiiZpw1a5eXon3PxAUA@mail.gmail.com>
Message-ID: <20151019112749.GB10728@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 01:19:14PM +0200, Linus Walleij wrote:
> On Mon, Oct 19, 2015 at 12:29 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > Also, for non U-Boot systems I was under the impression that the flash
> > was effectively owned by EFI (for variable storage),
> 
> If it is "owned" by something it is owned by the boot monitor, neither
> by U-Boot or (U)EFI. The boot monitor can flash "images" into
> the flash using USB or ethernet/TFTP and it is not part of any
> boot loader, but an autonomous flash image on the board.
> (Actually it can replace itself.)

No.

This would be true for any preceding ARM devboard, but Juno's boot
architecture is different. The thing that gives the 'Cmd>' prompt is
running on a system microcontroller. It writes images to the system
NOR based on the contents of images.txt in the magic USB filesystem.

While I think you _can_ run the boot monitor on Juno, it it not part
of the UEFI boot path, and I didn't think it was for U-Boot either?
It certainly shouldn't be needed.

/
    Leif

From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Oct 2015 12:59:19 +0100
Subject: [PATCH] ARM64: juno: add NOR flash to device tree
In-Reply-To: <CAD0U-h+cr0xpAAcCD1P8k2hUcJJL2Ga+-Grrb8WaZrgm08G2nA@mail.gmail.com>
References: <1444904415-19597-1-git-send-email-linus.walleij@linaro.org>
 <561FC681.2040809@arm.com>
 <CACRpkdaSox9WKb5-dkD_zAwO9WxP6+b010p3bdxsm1LRy=WvKg@mail.gmail.com>
 <5624C31D.3070906@arm.com> <20151019102932.GB10678@leverpostej>
 <20151019112033.GA10728@bivouac.eciton.net>
 <CAD0U-h+cr0xpAAcCD1P8k2hUcJJL2Ga+-Grrb8WaZrgm08G2nA@mail.gmail.com>
Message-ID: <CACRpkdY8RneiS7fd+_emwjjWQrLXc+k66N7KVg35ZC6Z5uHs4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 21, 2015 at 1:18 PM, Ryan Harkin <ryan.harkin@linaro.org> wrote:

> There is no global TOC placed in NOR or elsewhere.
>
> Each image stored in NOR flash contains a "footer" at the end of the
> last sector of the image.  This footer describes the image, including
> it's image "name".
>
> To find all of the images in NOR flash, the AFS code has to scan for
> the footer's signature at the end of every sector in flash.  The v1
> footer is the last 4 bytes of the sector, the v2 footer is the last 8
> bytes.  Juno uses v2 footers.

Yeah it's made like this to facilitate execute-in-place. You can't
mess with the data in the beginning of the image if you're going
to be able to execute it right off.

Not that I know if execute-in-place for ARM64 was ever an option,
it can be done I guess... anyways this is a legacy format for
all ARM reference designs.

As mentioned it the other mail, if we agree on a name for the
read-only bootloader/EFI data partition, it can easily be made into
as a readonly thing.

Yours,
Linus Walleij

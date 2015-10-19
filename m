From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Mon, 19 Oct 2015 12:20:33 +0100
Subject: [PATCH] ARM64: juno: add NOR flash to device tree
In-Reply-To: <20151019102932.GB10678@leverpostej>
References: <1444904415-19597-1-git-send-email-linus.walleij@linaro.org>
 <561FC681.2040809@arm.com>
 <CACRpkdaSox9WKb5-dkD_zAwO9WxP6+b010p3bdxsm1LRy=WvKg@mail.gmail.com>
 <5624C31D.3070906@arm.com> <20151019102932.GB10678@leverpostej>
Message-ID: <20151019112033.GA10728@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 11:29:32AM +0100, Mark Rutland wrote:
> > Correct, I just mentioned so that if you see/get any boot issue report
> > with NOR flash and CPUIdle enabled, you will have the background instead
> > of investigating the known issue again.
> 
> Also, for non U-Boot systems I was under the impression that the flash
> was effectively owned by EFI (for variable storage), so it doesn't seem
> like a sensible idea to me to poke the flash behind its back in that
> case.
> 
> Given that, I'm not sure that the flash node should be enabled by
> default in the DT.
> 
> Leif?

Well, given that it's a NOR device (or even two), it doesn't
necessarily have to be an all-or-nothing decision.

0x0BFC0000-0x0BFFFFFF ("erase region 1", the last 256KB) is used for
the persistent storage. This is hard wired into the UEFI image.

But the rest of the flash consists of whatever the contents of
images.txt in the magic configuration-via-USB-filesystem says it is.
I'm not convinced that is written to the device in AFS format.

/
    Leif

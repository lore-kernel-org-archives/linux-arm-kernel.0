From: grant.likely@linaro.org (Grant Likely)
Date: Wed, 25 Nov 2015 16:38:35 +0000
Subject: Building an uImage with appended DTB
In-Reply-To: <5655DED0.5000601@free.fr>
References: <5655DED0.5000601@free.fr>
Message-ID: <CACxGe6t0RD-z=duiP+=sbWm_JY7_OjjTmBL7jLZRRuLBSMan6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 4:16 PM, Mason <slash.tmp@free.fr> wrote:
> Hello,
>
> Per Russell's advice (IIRC) I have a script to generate a uImage
> of a kernel with an appended DTB:
>
> export LOADADDR=0x80008000
> MAKE="make -j2 ARCH=arm"
> $MAKE dtbs zImage && \
> cat arch/arm/boot/zImage arch/arm/boot/dts/tango4-vantage-1172.dtb >zImage.tmp && \
> mv zImage.tmp arch/arm/boot/zImage && \
> $MAKE uImage
>
> Russell's version uses an explicit mkimage instead of "MAKE uImage"
> perhaps in part to get around the following limitation:
>
> if there is nothing to be done, cat+mv will update arch/arm/boot/zImage
> thus the uImage will be rebuilt even when it's not necessary.
>
> Doesn't the top-level Makefile support a target to build a uImage
> with appended DTB?
>
> (I suppose someone has submitted a patch for that. Was it perhaps
> never merged? Or did I just miss the feature?)

I don't remember what happened there. That was a long time ago. I
think it got nacked, but cannot remember the reason.

g.

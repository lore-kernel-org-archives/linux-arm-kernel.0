From: slash.tmp@free.fr (Mason)
Date: Wed, 25 Nov 2015 17:16:16 +0100
Subject: Building an uImage with appended DTB
Message-ID: <5655DED0.5000601@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Per Russell's advice (IIRC) I have a script to generate a uImage
of a kernel with an appended DTB:

export LOADADDR=0x80008000
MAKE="make -j2 ARCH=arm"
$MAKE dtbs zImage && \
cat arch/arm/boot/zImage arch/arm/boot/dts/tango4-vantage-1172.dtb >zImage.tmp && \
mv zImage.tmp arch/arm/boot/zImage && \
$MAKE uImage

Russell's version uses an explicit mkimage instead of "MAKE uImage"
perhaps in part to get around the following limitation:

if there is nothing to be done, cat+mv will update arch/arm/boot/zImage
thus the uImage will be rebuilt even when it's not necessary.

Doesn't the top-level Makefile support a target to build a uImage
with appended DTB?

(I suppose someone has submitted a patch for that. Was it perhaps
never merged? Or did I just miss the feature?)

Something like this:
https://patchwork.kernel.org/patch/1133461/

Regards.

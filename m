From: eric@anholt.net (Eric Anholt)
Date: Tue, 07 Jun 2016 15:42:20 -0700
Subject: [PATCH v3 00/10] raspberry pi 3 patch series, part 1: essentials
In-Reply-To: <1465297548-17182-1-git-send-email-kraxel@redhat.com>
References: <1465297548-17182-1-git-send-email-kraxel@redhat.com>
Message-ID: <87shwo4o4z.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gerd Hoffmann <kraxel@redhat.com> writes:

>   Hi,
>
> Raspberry pi 3 patches, next round.  Should be pretty much ready
> to go now.
>
> Changes v3:
>  * redo defconfig update, drop DRM_VC4=y for now (not working for me).
>  * split rpi3 device tree patch into two again (arm64 + arm).
>
> Changes v2:
>  * send essential patches only
>  * dropped ARCH_BCM kconfig option.
>  * drop include hack for rpi3 device tree in arm.
>  * drop DMA offset patch, pick up the version from Alex instead.
>
> Patches are also available from:
>   git://git.kraxel.org/linux bcm2837-47-v3
>
> Note that the git branch has the complete set of patches (including
> device tree patches and rpi3 wifi).

Patches 2, 3, and 9 were queued for -next as of last night.  Hopefully Gerd
can do any future submissions against -next so we don't see duplicate
patches.

I've pulled patches 6, 7 (folding in a feedback fix from a previous
round), and 10.

That leaves the following that I'm hoping arm/arm64 maintainers can ack
since they've had a bunch of discussion:

Patch 4, 1: Can we keep ARCH_BCM2835 being the platform select?  All the
platform's drivers have been under ARCH_BCM2835, that select has covered
the rest of the chips in the family on the 32-bit side, and we have two
other families like this for BCM already (IPROC, VULCAN)

Patch 5: I expect we'll have some =m changes still.

Patch 8: I think this one is ready.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160607/acffc59f/attachment.sig>

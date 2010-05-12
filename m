From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 12 May 2010 17:37:08 +0200
Subject: [PATCH] qnap tsx1x: fix section mismatch
Message-ID: <87wrv9dtcr.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org




Fix the following warning :
WARNING: vmlinux.o(.text+0x95a0): Section mismatch in reference from the
function qnap_tsx1x_register_flash() to the (unknown reference) .init.data:(unknown)
The function qnap_tsx1x_register_flash() references
the (unknown reference) __initdata (unknown).
This is often because qnap_tsx1x_register_flash lacks a __initdata
annotation or the annotation of (unknown) is wrong.

Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
---
-------------- next part --------------
A non-text attachment was scrubbed...
Name: tsx1x_section_mismatch.patch
Type: text/x-diff
Size: 615 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100512/812d16ed/attachment.bin>

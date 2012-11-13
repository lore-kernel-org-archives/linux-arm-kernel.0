From: etienne.carriere@st.com (Etienne CARRIERE)
Date: Tue, 13 Nov 2012 17:07:55 +0100
Subject: [PATCH 0/2] L2CC shared mutex with ARM TZ
Message-ID: <0154077FE026E54BB093CA7EB3FD1AE32B57AF1B57@SAFEX1MAIL3.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Etienne Carriere <etienne.carriere@stericsson.com>

Dear all,

A need for a shared mutex between linux and TrustZone has raised on ST-Ericsson ux500 platforms and coming ux600 platforms.

This patch series shows how we intend to modify ARM L2 cache driver to allow platforms to register a shared mutex between Linux and TrustZone code.

The 1st patch contains the target modifications in L2X0 driver in the kernel main track.

The 2nd patch (romcode-shared_mutex.c) is an example of how such feature could be used by platform specific code.
This patch does not target merge on kernel main track.

Patch were extracted from local kernel tree and may not apply straight on pristine kernel tree. I hope they clearly describe our purpose.

In the hope to get your feedback,
Regards.

Etienne Carriere (2)
 arm: mm: l2cc external shared mutex support
  mach-ux500: tee: l2cc TEE shared mutex support

arch/arm/include/asm/outercache.h |  9 ++++
arch/arm/mm/cache-l2x0.c          | 87 +++++++++++++++++++++++++++++----------
arch/arm/mach-ux500/romcode-shared_mutex.c | 111 +++++++++++++++++++++++++++++
3 files changed, 185 insertions(+), 22 deletions(-)



--

1.7.11.3

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121113/9a188fa7/attachment-0001.html>

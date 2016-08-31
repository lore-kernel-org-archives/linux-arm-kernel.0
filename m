From: labbott@redhat.com (Laura Abbott)
Date: Tue, 30 Aug 2016 17:04:26 -0700
Subject: [PATCHv3 0/3] Devicetree bindings for Ion
Message-ID: <1472601869-19469-1-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is a long overdue resend and slight update from the last version[1] of
Ion devicetree bindings.

The goal here is to keep the Ion bindings minimalist. I experimented with
dropping all but a dummy devicetree node and just matching on the machine
name in the platform file. This ends up being a nightmare for the DMA (i.e. CMA)
heap type. That heap requires a device structure to do its allocation and
setting up a device structure properly isn't pretty. I have other ideas for
working with that heap if this gets NAKed.

I've thought about the idea of a devicetree overlay for specifying more
platform configuration but that a) requires Android actually load the overlay
at the right time in the framework and b) opens up an entirely new can of
worms.

In conclusion, if we assume that Ion platform support is something anyone
actually wants, this is still the least bad and intrusive idea I've come up
with. There exists hisilicon Ion code but it came in without being fully acked.
I've converted it over as an example of how it might look.

As always, feedback appreciated.

Thanks,
Laura

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/385452.html

Laura Abbott (3):
  devicetree: bindings for Ion
  staging: ion: Add files for parsing the devicetree
  staging: android: ion: Convert hi6220 to common platform

 drivers/staging/android/ion/Kconfig                |  11 ++
 drivers/staging/android/ion/Makefile               |   1 +
 drivers/staging/android/ion/devicetree.txt         |  51 ++++++
 drivers/staging/android/ion/hisilicon/hi6220_ion.c | 192 +++++----------------
 drivers/staging/android/ion/ion_of.c               | 168 ++++++++++++++++++
 drivers/staging/android/ion/ion_of.h               |  35 ++++
 6 files changed, 306 insertions(+), 152 deletions(-)
 create mode 100644 drivers/staging/android/ion/devicetree.txt
 create mode 100644 drivers/staging/android/ion/ion_of.c
 create mode 100644 drivers/staging/android/ion/ion_of.h

-- 
2.7.4

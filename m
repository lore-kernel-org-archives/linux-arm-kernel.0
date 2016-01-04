From: andre.przywara@arm.com (Andre Przywara)
Date: Mon,  4 Jan 2016 14:50:32 +0000
Subject: [PATCH 0/2] arm: configs: improve KVM support
Message-ID: <1451919034-12846-1-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

there doesn't seem to be a good generic defconfig which includes
KVM support, so this config tends to get less testing.
This mini-series addresses this with a two-fold approach:

Patch 1/2 introduces VIRTIO drivers to the existing multi_v7_defconfig,
so those kernels can be easily used as guest kernels in KVM.
This goes with the arm64 defconfig, which has those drivers compiled
in as well.

Patch 2/2 adds a new kvm_defconfig, which includes LPAE and KVM host
capability on top of the said multi_v7_defconfig. This should help to
find compatibility issues with LPAE configs on the way.
I didn't bother to deselect platforms that are not LPAE capable, as:
a) some platforms may include LPAE capable cores in the future
b) compile testing drivers is part of this exercise.
I guess with LPAE capable machines adding some KBytes to the
kernel image is not really an issue, so let's just keep those
platforms in. Also that makes the diff to multi_v7_defconfig pretty
small.

Alison, the last patch comes pretty close to your:
"[RFC PATCH] ARM: add v7 LPAE multi-platform defconfig" from early
November, though with a slightly different focus. If you have a new
version of your patch in the queue, I am happy to withdraw mine and
rather help to get yours merged, possibly with the KVM options added.
What is your take on this?

Cheers,
Andre.

Andre Przywara (2):
  arm: multi_v7_defconfig: Add virtio drivers
  arm: configs: add kvm_defconfig

 arch/arm/configs/{multi_v7_defconfig => kvm_defconfig} | 14 ++++++++++++++
 arch/arm/configs/multi_v7_defconfig                    |  8 ++++++++
 2 files changed, 22 insertions(+)
 copy arch/arm/configs/{multi_v7_defconfig => kvm_defconfig} (98%)

-- 
2.6.4

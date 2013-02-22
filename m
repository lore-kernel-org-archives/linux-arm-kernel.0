From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 22 Feb 2013 18:40:44 +0000
Subject: [PATCH 0/2] VGIC fixes for 3.9-rc1
Message-ID: <1361558446-8375-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've just realised that these patches have never been on LAKML, and
only to kvm-arm. It is probably better to repost them here before they
get pulled in.

The first patch is just a cleanup, and has very little consequence on
the behaviour of the VGIC. The second one is more serious, and results
in lost interrupts under heavy load.

Patches are against mainline as of today, and tested on both TC2 and
arm64 model.

Cheers,

	M.

Marc Zyngier (2):
  ARM: KVM: vgic: force EOIed LRs to the empty state
  ARM: KVM: vgic: take distributor lock on sync_hwstate path

 arch/arm/kvm/vgic.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

-- 
1.7.12.4

From: julien.grall@citrix.com (Julien Grall)
Date: Thu, 10 Sep 2015 14:42:40 +0100
Subject: [PATCH 0/2] xen/swiotlb: Add support for 64KB page granularity,
Message-ID: <1441892562-22059-1-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This small series add support for 64KB guests in swiotlb. It's based on
top of my 64KB page granularity support [1].

It has been tested on both 4KB and 64KB page granularity DOM0 by using an
LVM partition for the guest rootfs.

Regards,

[1] https://lwn.net/Articles/656797/

Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: David Vrabel <david.vrabel@citrix.com>

Julien Grall (2):
  xen/swiotlb: Pass addresses rather than frame numbers to
    xen_arch_need_swiotlb
  xen/swiotlb: Add support for 64KB page granularity

 arch/arm/include/asm/xen/page-coherent.h | 26 ++++++++++++-------
 arch/arm/include/asm/xen/page.h          |  4 +--
 arch/arm/xen/mm.c                        | 39 +++++++++++++++++++++--------
 arch/x86/include/asm/xen/page.h          |  4 +--
 drivers/xen/swiotlb-xen.c                | 43 ++++++++++++++++----------------
 5 files changed, 71 insertions(+), 45 deletions(-)

-- 
2.1.4

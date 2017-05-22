From: jnair@caviumnetworks.com (Jayachandran C)
Date: Mon, 22 May 2017 07:01:45 +0000
Subject: [PATCH 0/2] ioremap_wc on arm64
Message-ID: <1495436507-81890-1-git-send-email-jnair@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From its definition, the device "gather" attribute seems to be a better
fit for implementing write combining mapping in ioremap_wc().  And on
ThunderX2, Device GRE mapping has optimizations that makes it much faster
than normal uncached mapping.

I am not sure of the reasoning behind the original decision to make
ioremap_wc use "Normal Non-Cached" attribute, since all the other variants
of ioremap use device attributes, and ioremap_wc looks like an exception.

Comments are very welcome.

Thanks,
JC.

Jayachandran C (2):
  arm64: add PROT_DEVICE_GRE for Device GRE mapping
  arm64: switch ioremap_wc to use Device GRE

 arch/arm64/include/asm/io.h           | 2 +-
 arch/arm64/include/asm/pgtable-prot.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.7.4

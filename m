From: joe@perches.com (Joe Perches)
Date: Mon, 30 Mar 2015 16:45:58 -0700
Subject: [PATCH 00/25] treewide: Use bool function return values of true/false
 not 1/0
Message-ID: <cover.1427759009.git.joe@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joe Perches (25):
  arm: Use bool function return values of true/false not 1/0
  arm64: Use bool function return values of true/false not 1/0
  hexagon: Use bool function return values of true/false not 1/0
  ia64: Use bool function return values of true/false not 1/0
  mips: Use bool function return values of true/false not 1/0
  powerpc: Use bool function return values of true/false not 1/0
  s390: Use bool function return values of true/false not 1/0
  sparc: Use bool function return values of true/false not 1/0
  tile: Use bool function return values of true/false not 1/0
  unicore32: Use bool function return values of true/false not 1/0
  x86: Use bool function return values of true/false not 1/0
  virtio_console: Use bool function return values of true/false not 1/0
  csiostor: Use bool function return values of true/false not 1/0
  dcache: Use bool function return values of true/false not 1/0
  nfsd: nfs4state: Use bool function return values of true/false not 1/0
  include/linux: Use bool function return values of true/false not 1/0
  sound: Use bool function return values of true/false not 1/0
  rcu: tree_plugin: Use bool function return values of true/false not 1/0
  sched: Use bool function return values of true/false not 1/0
  ftrace: Use bool function return values of true/false not 1/0
  slub: Use bool function return values of true/false not 1/0
  bridge: Use bool function return values of true/false not 1/0
  netfilter: Use bool function return values of true/false not 1/0
  security: Use bool function return values of true/false not 1/0
  sound: wm5100-tables: Use bool function return values of true/false not 1/0

 arch/arm/include/asm/dma-mapping.h           |  8 ++--
 arch/arm/include/asm/kvm_emulate.h           |  2 +-
 arch/arm/mach-omap2/powerdomain.c            | 14 +++---
 arch/arm64/include/asm/dma-mapping.h         |  2 +-
 arch/hexagon/include/asm/dma-mapping.h       |  2 +-
 arch/ia64/include/asm/dma-mapping.h          |  2 +-
 arch/mips/include/asm/dma-mapping.h          |  2 +-
 arch/powerpc/include/asm/dcr-native.h        |  2 +-
 arch/powerpc/include/asm/dma-mapping.h       |  4 +-
 arch/powerpc/include/asm/kvm_book3s_64.h     |  4 +-
 arch/powerpc/sysdev/dcr.c                    |  2 +-
 arch/s390/include/asm/dma-mapping.h          |  2 +-
 arch/sparc/mm/init_64.c                      |  8 ++--
 arch/tile/include/asm/dma-mapping.h          |  2 +-
 arch/unicore32/include/asm/dma-mapping.h     |  2 +-
 arch/x86/include/asm/archrandom.h            |  2 +-
 arch/x86/include/asm/dma-mapping.h           |  2 +-
 arch/x86/include/asm/kvm_para.h              |  2 +-
 arch/x86/kvm/cpuid.h                         |  2 +-
 arch/x86/kvm/vmx.c                           | 72 ++++++++++++++--------------
 drivers/char/virtio_console.c                |  2 +-
 drivers/scsi/csiostor/csio_scsi.c            |  4 +-
 fs/dcache.c                                  | 12 ++---
 fs/nfsd/nfs4state.c                          |  2 +-
 include/linux/blkdev.h                       |  2 +-
 include/linux/ide.h                          |  2 +-
 include/linux/kgdb.h                         |  2 +-
 include/linux/mfd/db8500-prcmu.h             |  2 +-
 include/linux/mm.h                           |  2 +-
 include/linux/power_supply.h                 |  8 ++--
 include/linux/ssb/ssb_driver_extif.h         |  2 +-
 include/linux/ssb/ssb_driver_gige.h          | 16 +++----
 include/sound/soc.h                          |  4 +-
 kernel/rcu/tree_plugin.h                     |  4 +-
 kernel/sched/auto_group.h                    |  2 +-
 kernel/sched/completion.c                    | 16 ++++---
 kernel/trace/ftrace.c                        | 10 ++--
 mm/slub.c                                    | 12 ++---
 net/bridge/br_private.h                      |  2 +-
 net/ipv4/netfilter/ipt_ah.c                  |  2 +-
 net/netfilter/ipset/ip_set_hash_ip.c         |  8 ++--
 net/netfilter/ipset/ip_set_hash_ipmark.c     |  8 ++--
 net/netfilter/ipset/ip_set_hash_ipport.c     |  8 ++--
 net/netfilter/ipset/ip_set_hash_ipportip.c   |  8 ++--
 net/netfilter/ipset/ip_set_hash_ipportnet.c  |  8 ++--
 net/netfilter/ipset/ip_set_hash_net.c        |  8 ++--
 net/netfilter/ipset/ip_set_hash_netiface.c   |  8 ++--
 net/netfilter/ipset/ip_set_hash_netport.c    |  8 ++--
 net/netfilter/ipset/ip_set_hash_netportnet.c |  8 ++--
 net/netfilter/xt_connlimit.c                 |  2 +-
 net/netfilter/xt_hashlimit.c                 |  2 +-
 net/netfilter/xt_ipcomp.c                    |  2 +-
 security/apparmor/file.c                     |  8 ++--
 security/apparmor/policy.c                   | 10 ++--
 sound/soc/codecs/wm5100-tables.c             | 12 ++---
 55 files changed, 178 insertions(+), 176 deletions(-)

-- 
2.1.2

From: mst@redhat.com (Michael S. Tsirkin)
Date: Thu, 15 Dec 2016 07:15:06 +0200
Subject: [PATCH 0/8] enable endian checks for all sparse builds
Message-ID: <1481778865-27667-1-git-send-email-mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is just a reposting of the patch that enables endian checks, with addition
of trivial patches that drop __bitwise__ and __CHECK_ENDIAN__ everywhere.

I plan to include this in my pull request unless I hear otherwise.

Michael S. Tsirkin (8):
  linux/types.h: enable endian checks for all sparse builds
  tools: enable endian checks for all sparse builds
  Documentation/sparse: drop __bitwise__
  checkpatch: replace __bitwise__ with __bitwise
  linux: drop __bitwise__ everywhere
  Documentation/sparse: drop __CHECK_ENDIAN__
  fs/logfs: drop __CHECK_ENDIAN__
  Makefile: drop -D__CHECK_ENDIAN__ from cflags

 Documentation/translations/zh_CN/sparse.txt               |  7 +------
 arch/arm/plat-samsung/include/plat/gpio-cfg.h             |  2 +-
 drivers/md/dm-cache-block-types.h                         |  6 +++---
 drivers/net/ethernet/sun/sunhme.h                         |  2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-fw-file.h          |  4 ++--
 fs/logfs/logfs.h                                          |  4 +---
 include/linux/mmzone.h                                    |  2 +-
 include/linux/serial_core.h                               |  4 ++--
 include/linux/types.h                                     |  4 ++--
 include/scsi/iscsi_proto.h                                |  2 +-
 include/target/target_core_base.h                         |  2 +-
 include/uapi/linux/types.h                                |  4 ----
 include/uapi/linux/virtio_types.h                         |  6 +++---
 net/ieee802154/6lowpan/6lowpan_i.h                        |  2 +-
 net/mac80211/ieee80211_i.h                                |  4 ++--
 tools/include/linux/types.h                               |  4 ----
 Documentation/dev-tools/sparse.rst                        | 14 +-------------
 drivers/bluetooth/Makefile                                |  2 --
 drivers/net/can/Makefile                                  |  1 -
 drivers/net/ethernet/altera/Makefile                      |  1 -
 drivers/net/ethernet/atheros/alx/Makefile                 |  1 -
 drivers/net/ethernet/freescale/Makefile                   |  2 --
 drivers/net/wireless/ath/Makefile                         |  2 --
 drivers/net/wireless/ath/wil6210/Makefile                 |  2 --
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/Makefile |  2 --
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/Makefile |  1 -
 drivers/net/wireless/intel/iwlegacy/Makefile              |  2 --
 drivers/net/wireless/intel/iwlwifi/Makefile               |  2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/Makefile           |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/Makefile           |  2 +-
 drivers/net/wireless/intersil/orinoco/Makefile            |  3 ---
 drivers/net/wireless/mediatek/mt7601u/Makefile            |  2 --
 drivers/net/wireless/realtek/rtlwifi/Makefile             |  2 --
 drivers/net/wireless/realtek/rtlwifi/btcoexist/Makefile   |  2 --
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/Makefile   |  2 --
 drivers/net/wireless/realtek/rtlwifi/rtl8192c/Makefile    |  2 --
 drivers/net/wireless/realtek/rtlwifi/rtl8192ce/Makefile   |  2 --
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/Makefile   |  2 --
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/Makefile   |  2 --
 drivers/net/wireless/realtek/rtlwifi/rtl8192ee/Makefile   |  2 --
 drivers/net/wireless/realtek/rtlwifi/rtl8192se/Makefile   |  2 --
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/Makefile   |  2 --
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/Makefile   |  2 --
 drivers/net/wireless/realtek/rtlwifi/rtl8723com/Makefile  |  2 --
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/Makefile   |  2 --
 drivers/net/wireless/ti/wl1251/Makefile                   |  2 --
 drivers/net/wireless/ti/wlcore/Makefile                   |  2 --
 drivers/staging/rtl8188eu/Makefile                        |  2 +-
 drivers/staging/rtl8192e/Makefile                         |  2 --
 drivers/staging/rtl8192e/rtl8192e/Makefile                |  2 --
 net/bluetooth/Makefile                                    |  2 --
 net/ieee802154/Makefile                                   |  2 --
 net/mac80211/Makefile                                     |  2 +-
 net/mac802154/Makefile                                    |  2 --
 net/wireless/Makefile                                     |  2 --
 scripts/checkpatch.pl                                     |  4 ++--
 56 files changed, 30 insertions(+), 120 deletions(-)

-- 
MST

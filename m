From: garsilva@embeddedor.com (Gustavo A. R. Silva)
Date: Thu, 12 Oct 2017 11:15:07 -0500
Subject: [PATCH 00/20] mark expected switch fall-throughs
Message-ID: <cover.1507781178.git.garsilva@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation to enabling -Wimplicit-fallthrough, this patchset aims
to mark switch cases where we are expecting to fall through.

In Kees Cook words:
"This is an unfortunate omission in the C language, and thankfully both
gcc and clang have stepped up to solve this the same way static
analyzers have solved it. It does both document the intention for
humans and provide a way for analyzers to report issues.

Having the compiler help us not make mistakes is quite handy."

In some cases there were "no break" or "fall thru" comments already
in place. So I replaced them with proper "fall through" comments, which
is what GCC is expecting to find.

For the rest of the cases, please double check if the actual intention
of the code is to fall through.

Thanks!

Gustavo A. R. Silva (20):
  staging: ks7010: ks_wlan_net: mark expected switch fall-throughs
  staging: lustre: lnet: socklnd: mark expected switch fall-through
  staging: rtl8192e: mark expected switch fall-through
  staging: rtl8723bs: rtw_mlme_ext: mark expected switch fall-through
  staging: lustre: lnet: net_fault: mark expected switch fall-through
  staging: comedi: s526: mark expected switch fall-through
  staging: rtl8188eu: usb_halinit: mark expected switch fall-through
  staging: vc04_services: vchiq_core: mark expected switch fall-through
  staging: vt6656: card: mark expected switch fall-throughs
  staging: rtl8188eu: usb_ops_linux: mark expected switch fall-through
  staging: r8822be: mark expected switch fall-throughs
  staging: lustre: lnet: selftest: mark expected switch fall-through
  staging: rtlwifi: halmac: mark expected switch fall-through
  staging: lustre: lnet: selftest: mark expected switch fall-throughs
  staging: lustre: llite: mark expected switch fall-through
  staging: lustre: lprocfs: mark expected switch fall-throughs
  staging: lustre: ldlm: mark expected switch fall-through
  staging: lustre: osc: mark expected switch fall-through
  staging: lustre: ptlrpc: mark expected switch fall-throughs
  staging: lustre: rpc: mark expected switch fall-throughs

 drivers/staging/comedi/drivers/s526.c                       |  5 ++---
 drivers/staging/ks7010/ks_wlan_net.c                        | 10 ++++++++++
 drivers/staging/lustre/lnet/klnds/socklnd/socklnd.c         |  2 +-
 drivers/staging/lustre/lnet/lnet/net_fault.c                |  1 +
 drivers/staging/lustre/lnet/selftest/conctl.c               |  1 +
 drivers/staging/lustre/lnet/selftest/module.c               |  5 ++++-
 drivers/staging/lustre/lnet/selftest/rpc.c                  | 13 +++++++++----
 drivers/staging/lustre/lustre/ldlm/ldlm_request.c           |  1 +
 drivers/staging/lustre/lustre/llite/namei.c                 |  4 +++-
 drivers/staging/lustre/lustre/obdclass/lprocfs_status.c     |  4 ++++
 drivers/staging/lustre/lustre/osc/osc_cache.c               |  1 +
 drivers/staging/lustre/lustre/ptlrpc/pack_generic.c         |  6 +++---
 drivers/staging/rtl8188eu/hal/usb_halinit.c                 |  1 +
 drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c            |  1 +
 drivers/staging/rtl8192e/rtllib_wx.c                        |  3 +--
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c               |  2 +-
 .../staging/rtlwifi/halmac/halmac_88xx/halmac_api_88xx.c    |  2 ++
 drivers/staging/rtlwifi/halmac/rtl_halmac.c                 |  2 +-
 .../staging/vc04_services/interface/vchiq_arm/vchiq_core.c  |  3 +--
 drivers/staging/vt6656/card.c                               |  2 ++
 20 files changed, 50 insertions(+), 19 deletions(-)

-- 
2.7.4

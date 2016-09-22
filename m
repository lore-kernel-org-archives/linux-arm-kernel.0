From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 22 Sep 2016 10:18:07 +0300
Subject: [GIT PULL] Allwinner sun4i DRM fixes for 4.9
Message-ID: <20160922071807.GA13920@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

Here is a bunch of fixes for the previous pull request I sent.

Thanks!
Maxime

The following changes since commit 0c3ff44cc23cbede56aa1ca5916b126e681ca69b:

  drm/sun4i: add missing header dependencies (2016-09-08 14:55:48 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-drm-fixes-for-4.9

for you to fetch changes up to f0188ef8301ccbb128bbfd10751a9aeca8c9172e:

  drm/sun4i: Fix the high buffer address mask (2016-09-22 10:13:22 +0300)

----------------------------------------------------------------
Allwinner sun4i DRM fixes for 4.9

A few fixes for the sun4i drm driver that range, including some fixes that
might prevent multiple planes from working depending on the sequence where
they are enabled.

----------------------------------------------------------------
Chen-Yu Tsai (3):
      drm/sun4i: dotclock: Fix clock rate read back calcation
      drm/sun4i: dotclock: Allow divider = 127
      drm/sun4i: dotclock: Round to closest clock rate

Maxime Ripard (3):
      drm/sun4i: Fix formats usable by the primary plane
      drm/sun4i: tv: Check mode pointer
      drm/sun4i: Fix the high buffer address mask

Ville Syrj?l? (1):
      drm/sun4i: Fix sparse warnings

Wei Yongjun (1):
      drm/sun4i: backend: remove redundant dev_err call in sun4i_backend_bind()

 drivers/gpu/drm/sun4i/sun4i_backend.c  | 13 +++++---
 drivers/gpu/drm/sun4i/sun4i_backend.h  |  4 +--
 drivers/gpu/drm/sun4i/sun4i_dotclock.c |  7 +++--
 drivers/gpu/drm/sun4i/sun4i_layer.c    | 56 +++++++++++++++++++++++-----------
 drivers/gpu/drm/sun4i/sun4i_tv.c       | 46 ++++++++++++++++------------
 5 files changed, 79 insertions(+), 47 deletions(-)

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160922/42771ce4/attachment.sig>

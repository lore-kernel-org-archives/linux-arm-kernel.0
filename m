From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 20 Jun 2016 11:07:04 +0200
Subject: [GIT PULL] Allwinner sun4i DRM fixes for 4.7
Message-ID: <20160620090704.GA18304@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

Please pull the following tag for the 4.7 release cycle.

Thanks!
Maxime

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-drm-fixes-for-4.7

for you to fetch changes up to 13fef095bde04228316046f997eb963285d8532e:

  drm: sun4i: do cleanup if RGB output init fails (2016-05-30 08:28:33 +0200)

----------------------------------------------------------------
Allwinner sun4i DRM driver fixes

A bunch of fixes that address:
  - Compilation errors in various corner cases
  - Move to helpers
  - Fix the pixel clock computation
  - Fix our panel probe

----------------------------------------------------------------
Arnd Bergmann (3):
      drm/sun4i: add COMMON_CLK dependency
      drm: sun4i: print DMA address correctly
      drm: sun4i: fix probe error handling

Chen-Yu Tsai (1):
      drm: sun4i: do cleanup if RGB output init fails

Maxime Ripard (6):
      drm/sun4i: request exact rates to our parents
      drm/sun4i: rgb: Validate the clock rate
      drm/sun4i: defer only if we didn't find our panel
      drm/sun4i: rgb: panel is an error pointer
      drm/sun4i: remove simplefb at probe
      drm/sun4i: Convert to connector register helpers

 drivers/gpu/drm/sun4i/Kconfig          |  2 +-
 drivers/gpu/drm/sun4i/sun4i_backend.c  |  4 +--
 drivers/gpu/drm/sun4i/sun4i_dotclock.c | 39 +++++++++++++++++++++++---
 drivers/gpu/drm/sun4i/sun4i_drv.c      | 50 ++++++++++++++--------------------
 drivers/gpu/drm/sun4i/sun4i_rgb.c      | 16 ++++++++++-
 drivers/gpu/drm/sun4i/sun4i_tcon.c     | 23 ++++++++++------
 6 files changed, 88 insertions(+), 46 deletions(-)

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160620/4826954f/attachment-0001.sig>

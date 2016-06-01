From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 1 Jun 2016 17:28:07 +0200
Subject: [PULL v2] drm: atmel-hlcdc: fixes for 4.7-rc2
Message-ID: <20160601172807.555abf84@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

Same pull request but after fixing the prototype mismatch in patch 1
(this time I tested it).

This pull request contains 2 trivial fixes for the atmel-hlcdc driver.

The first one is making use of __drm_atomic_helper_crtc_destroy_state()
instead of duplicating its logic in atmel_hlcdc_crtc_reset() and
risking memory leaks if other objects are added to the common CRTC
state.

The second one is fixing a possible NULL pointer dereference.

Regards,

Boris

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git at github.com:bbrezillon/linux-at91.git tags/drm-atmel-hlcdc-fixes/for-4.7-rc2

for you to fetch changes up to 58a2ab3af722550b2e4e8155eb08660e16c20ee6:

  drm: atmel-hlcdc: fix a NULL check (2016-06-01 15:59:36 +0200)

----------------------------------------------------------------
Two trivial bugfixes for the atmel-hlcdc driver.

The first one is making use of __drm_atomic_helper_crtc_destroy_state()
instead of duplicating its logic in atmel_hlcdc_crtc_reset() and
risking memory leaks if other objects are added to the common CRTC
state.

The second one is fixing a possible NULL pointer dereference.

----------------------------------------------------------------
Boris Brezillon (1):
      drm: atmel-hlcdc: fix atmel_hlcdc_crtc_reset() implementation

Dan Carpenter (1):
      drm: atmel-hlcdc: fix a NULL check

 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

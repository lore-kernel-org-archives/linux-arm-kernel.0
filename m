From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Fri,  6 Oct 2017 15:30:06 -0600
Subject: [PATCH 0/2] Fix s5p-mfc lock contention in request firmware paths
Message-ID: <cover.1507325072.git.shuahkh@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes inefficiencies and lock contention in the request
firmware paths.

Shuah Khan (2):
  media: s5p-mfc: check for firmware allocation before requesting
    firmware
  media: s5p-mfc: fix lock confection - request_firmware() once and keep
    state

 drivers/media/platform/s5p-mfc/s5p_mfc.c        |  4 ++++
 drivers/media/platform/s5p-mfc/s5p_mfc_common.h |  3 +++
 drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c   | 15 ++++++++++-----
 3 files changed, 17 insertions(+), 5 deletions(-)

-- 
2.7.4
